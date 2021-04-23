package main

import (
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"strings"
	"time"

	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/labels"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/cache"
)

func main() {
	// creates the in-cluster config
	config, err := rest.InClusterConfig()
	if err != nil {
		panic(err.Error())
	}
	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	selector := labels.SelectorFromSet(labels.Set(map[string]string{"instana": "dashboard-config"})).String()

	optionsModifer := func(options *metav1.ListOptions) {
		options.LabelSelector = selector
	}
	watchlist := cache.NewFilteredListWatchFromClient(
		clientset.CoreV1().RESTClient(),
		string(v1.ResourceConfigMaps), // which resource
		v1.NamespaceAll,               // in which namespace
		optionsModifer,
	)
	_, controller := cache.NewInformer(
		watchlist,
		&v1.ConfigMap{},
		0, //Duration is int64
		cache.ResourceEventHandlerFuncs{
			AddFunc: func(obj interface{}) {
				cm, _ := obj.(*v1.ConfigMap)
				actOnNewDashboardConfig(cm)
			},
			DeleteFunc: func(obj interface{}) {
				cm, _ := obj.(*v1.ConfigMap)
				fmt.Printf("cm deleted: %s \n", cm.Name)
			},
			UpdateFunc: func(oldObj, newObj interface{}) {
				oldCM, _ := oldObj.(*v1.ConfigMap)
				newCM, _ := newObj.(*v1.ConfigMap)
				fmt.Printf("old cm: %+v \n", oldCM)
				actOnNewDashboardConfig(newCM)
			},
		},
	)

	stop := make(chan struct{})
	defer close(stop)
	go controller.Run(stop)
	for {
		time.Sleep(time.Second)
	}
}

func actOnNewDashboardConfig(cm *v1.ConfigMap) {
	fmt.Printf("cm: %s \n", cm.Name)
	if cm.Data != nil {
		if jsonString, ok := cm.Data["dashboard.json"]; ok {
			fmt.Printf("New / updated dashboard configmap:\n%s \n", jsonString)

			payload := strings.NewReader(jsonString)

			postInstanaAPI(payload)

			// TODO Do we want to unmarschal
			//var jsonMap map[string]json.RawMessage
			//err := json.Unmarshal([]byte(jsonString), &jsonMap)
		}
	}
}

func postInstanaAPI(payload io.Reader) {
	url := os.Getenv("INSTANA_BASE_URL") + "/api/custom-dashboard"
	req, _ := http.NewRequest("POST", url, payload)
	req.Header.Add("authorization", "apiToken "+os.Getenv("INSTANA_API_TOKEN"))
	req.Header.Add("content-type", "application/json")
	fmt.Println("Post to url: " + url)
	fmt.Printf("with header: %+v \n", req)

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		panic(err.Error())
	}

	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		panic(err.Error())
	}

	fmt.Println("\n\n" + string(body))

}
