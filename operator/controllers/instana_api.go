package controllers

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"

	"github.com/go-logr/logr"
	customv1 "github.com/luebken/custom-dashboards/api/v1"
)

type InstanaApiResponse struct {
	Id    string `json:"id"`
	Title string `json:"title"`
}

type InstanaApi struct {
	ApiToken string
	BaseUrl  string
}

func (apiConfig InstanaApi) createDashboard(dashboard customv1.Dashboard, log logr.Logger) InstanaApiResponse {
	log.Info("Creating Instana dashboard")

	instanaUrl := apiConfig.BaseUrl + "/api/custom-dashboard"
	var jsonStr = []byte(dashboard.Spec.Config)
	client := &http.Client{}
	req2, err := http.NewRequest("POST", instanaUrl, bytes.NewBuffer(jsonStr))
	if err != nil {
		log.Info(err.Error())
	}
	req2.Header.Add("Accept", "application/json")
	req2.Header.Set("Content-Type", "application/json")
	req2.Header.Add("authorization", "apiToken "+apiConfig.ApiToken)
	resp, err := client.Do(req2)
	if err != nil {
		log.Info(err.Error())
	}
	defer resp.Body.Close()
	bodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Info(err.Error())
	}
	log.Info("POST Response.Status:" + resp.Status)
	//fmt.Printf("response bodyBytes:%+v\n", string(bodyBytes))

	var r InstanaApiResponse
	json.Unmarshal(bodyBytes, &r)
	return r
}

func (apiConfig InstanaApi) deleteDashboard(dashboard customv1.Dashboard, log logr.Logger) InstanaApiResponse {
	log.Info("Deleting Instana dashboard")

	instanaUrl := apiConfig.BaseUrl + "/api/custom-dashboard/" + dashboard.Status.DashboardId
	client := &http.Client{}
	req2, err := http.NewRequest("DELETE", instanaUrl, nil)
	if err != nil {
		log.Info(err.Error())
	}
	req2.Header.Add("Accept", "application/json")
	req2.Header.Set("Content-Type", "application/json")
	req2.Header.Add("authorization", "apiToken "+apiConfig.ApiToken)
	resp, err := client.Do(req2)
	if err != nil {
		log.Info(err.Error())
	}
	defer resp.Body.Close()
	bodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Info(err.Error())
	}
	log.Info("DELETE Response.Status:" + resp.Status)
	//fmt.Printf("response bodyBytes:%+v\n", string(bodyBytes))

	var r InstanaApiResponse
	json.Unmarshal(bodyBytes, &r)
	return r
}

func getInstanaDashboards(apiConfig InstanaApi, log logr.Logger) {
	instanaUrl := apiConfig.BaseUrl + "/api/custom-dashboard"
	client := &http.Client{}
	req2, err := http.NewRequest("GET", instanaUrl, nil)
	if err != nil {
		log.Info(err.Error())
	}
	req2.Header.Add("Accept", "application/json")
	req2.Header.Set("Content-Type", "application/json")
	req2.Header.Add("authorization", "apiToken "+apiConfig.ApiToken)
	resp, err := client.Do(req2)
	if err != nil {
		log.Info(err.Error())
	}
	defer resp.Body.Close()
	bodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Info(err.Error())
	}
	log.Info("Response.Status:" + resp.Status)
	fmt.Printf("response bodyBytes:%+v\n", string(bodyBytes))
}
