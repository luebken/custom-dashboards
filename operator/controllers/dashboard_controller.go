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
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/go-logr/logr"
	"k8s.io/apimachinery/pkg/runtime"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"

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
// TODO(user): Modify the Reconcile function to compare the state specified by
// the Dashboard object against the actual cluster state, and then
// perform operations to make the cluster state reflect the state specified by
// the user.
//
// For more details, check Reconcile and its Result here:
// - https://pkg.go.dev/sigs.k8s.io/controller-runtime@v0.7.2/pkg/reconcile
func (r *DashboardReconciler) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
	log := r.Log.WithValues("dashboard", req.NamespacedName)

	log.Info("Reconcile called")

	var dashboard customv1.Dashboard
	if err := r.Get(ctx, req.NamespacedName, &dashboard); err != nil {
		log.Error(err, "unable to fetch Dashboard")
		// we'll ignore not-found errors, since they can't be fixed by an immediate requeue
		return ctrl.Result{}, client.IgnoreNotFound(err)
	}
	log.Info("Got dashboard named '" + dashboard.Name + "'")
	log.Info("dashboard.Spec.InstanaUserId '" + dashboard.Spec.InstanaUserId + "'")
	log.Info("dashboard.Spec.InstanaApiToken '" + dashboard.Spec.InstanaApiToken + "'")
	log.Info("dashboard.Spec.InstanaApiTokenRelationId '" + dashboard.Spec.InstanaApiTokenRelationId + "'")
	instanaUrl := dashboard.Spec.InstanaBaseUrl + "/api/custom-dashboard"
	log.Info("dashboard.Spec.InstanaBaseUrl '" + instanaUrl + "'")
	var jsonStr = []byte(dashboard.Spec.Config)

	type Response struct {
		Id    string `json:"id"`
		Title string `json:"title"`
	}

	fmt.Printf("Creating Dashboard %+v\n", dashboard.Spec.Config)

	client := &http.Client{}
	req2, err := http.NewRequest("POST", instanaUrl, bytes.NewBuffer(jsonStr))
	if err != nil {
		fmt.Print(err.Error())
	}
	req2.Header.Add("Accept", "application/json")
	req2.Header.Set("Content-Type", "application/json")
	req2.Header.Add("authorization", "apiToken "+dashboard.Spec.InstanaApiToken)
	resp, err := client.Do(req2)
	if err != nil {
		fmt.Print(err.Error())
	}
	defer resp.Body.Close()
	bodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Print(err.Error())
	}
	fmt.Println("response Status:", resp.Status)
	fmt.Println("response Headers:", resp.Header)
	var responseObject Response
	json.Unmarshal(bodyBytes, &responseObject)
	fmt.Printf("responseObject %+v\n", responseObject)

	return ctrl.Result{}, nil
}

// SetupWithManager sets up the controller with the Manager.
func (r *DashboardReconciler) SetupWithManager(mgr ctrl.Manager) error {
	return ctrl.NewControllerManagedBy(mgr).
		For(&customv1.Dashboard{}).
		Complete(r)
}
