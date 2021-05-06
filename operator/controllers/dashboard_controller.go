/*
Copyright 2021.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package controllers

import (
	"context"
	"fmt"

	corev1 "k8s.io/api/core/v1"

	"github.com/go-logr/logr"
	"k8s.io/apimachinery/pkg/runtime"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
	"sigs.k8s.io/controller-runtime/pkg/controller/controllerutil"

	customv1 "github.com/luebken/custom-dashboards/api/v1"
)

// DashboardReconciler reconciles a Dashboard object
type DashboardReconciler struct {
	client.Client
	Log    logr.Logger
	Scheme *runtime.Scheme
}

//+kubebuilder:rbac:groups=custom.instana.io,resources=dashboards,verbs=get;list;watch;create;update;patch;delete
//+kubebuilder:rbac:groups=custom.instana.io,resources=dashboards/status,verbs=get;update;patch
//+kubebuilder:rbac:groups=custom.instana.io,resources=dashboards/finalizers,verbs=update

// Reconcile is part of the main kubernetes reconciliation loop which aims to
// move the current state of the cluster closer to the desired state.
//
// For more details, check Reconcile and its Result here:
// - https://pkg.go.dev/sigs.k8s.io/controller-runtime@v0.7.2/pkg/reconcile
func (r *DashboardReconciler) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
	log := r.Log.WithValues("dashboard", req.NamespacedName)
	log.Info("Reconcile called for: " + req.NamespacedName.Name)

	// Read Instana API Config from ConfigMap
	cm := &corev1.ConfigMap{}
	_ = r.Client.Get(context.Background(), client.ObjectKey{
		Namespace: "default",
		Name:      "instana-custom-dashboard-config",
	}, cm)
	var instanaApi = InstanaApi{
		ApiToken: cm.Data["instana-api-token"],
		BaseUrl:  cm.Data["instana-base-url"],
	}
	log.Info("Loaded InstanaApiConfig. BaseUrl: " + instanaApi.BaseUrl)

	//getInstanaDashboards(instanaApiConfig, log)

	var dashboard customv1.Dashboard
	if err := r.Get(ctx, req.NamespacedName, &dashboard); err != nil {
		log.Info("Unable to load Dashboard. Assuming it was deleted. Skipping.")
		return ctrl.Result{}, client.IgnoreNotFound(err)
	}
	log.Info("Loadad resource dashboard: '" + dashboard.Name + "' with ResourceVersion: " + dashboard.ObjectMeta.GetResourceVersion() + ".")

	// Check for deletion
	finalizerName := "dashboard.custom.instana.io/finalizer"
	if dashboard.ObjectMeta.DeletionTimestamp != nil {
		log.Info("Found DeleteTimestamp. De resource")
		fmt.Printf("DeleteTimestamp: %+v\n", dashboard.ObjectMeta.DeletionTimestamp)
		fmt.Printf("Finalizers %+v\n", dashboard.ObjectMeta.GetFinalizers())
		instanaApi.deleteDashboard(dashboard, log)
		controllerutil.RemoveFinalizer(&dashboard, finalizerName)
		if err := r.Update(ctx, &dashboard); err != nil {
			log.Error(err, "unable to update dashboard")
			return ctrl.Result{}, err
		}
		return ctrl.Result{}, nil
	}

	// name of our custom finalizer

	if dashboard.Status.DashboardId != "" {
		//TODO sync with actual state in instana.
		log.Info("Dashboard Status has a DashboardId: " + dashboard.Status.DashboardId + ". Skipping it.")
		return ctrl.Result{}, nil
	}

	var apiResponse = instanaApi.createDashboard(dashboard, log)
	dashboard.Status.DashboardId = apiResponse.Id
	dashboard.Status.DashboardTitle = apiResponse.Title
	log.Info("Updating Dashboard Status CRD with Status.DashboardId: " + dashboard.Status.DashboardId)
	if err := r.Status().Update(ctx, &dashboard); err != nil {
		log.Error(err, "unable to update dashboard status")
		return ctrl.Result{}, err
	}
	log.Info("ResourceVersion after status update: " + dashboard.ObjectMeta.GetResourceVersion() + ".")
	controllerutil.AddFinalizer(&dashboard, finalizerName)
	log.Info("Updating Dashboard MetaData with finalizer: " + dashboard.ObjectMeta.GetFinalizers()[0])
	if err := r.Update(ctx, &dashboard); err != nil {
		log.Error(err, "unable to update dashboard")
		return ctrl.Result{}, err
	}
	log.Info("ResourceVersion after update: " + dashboard.ObjectMeta.GetResourceVersion() + ".")
	return ctrl.Result{}, nil
}

// SetupWithManager sets up the controller with the Manager.
func (r *DashboardReconciler) SetupWithManager(mgr ctrl.Manager) error {
	return ctrl.NewControllerManagedBy(mgr).
		For(&customv1.Dashboard{}).
		Complete(r)
}
