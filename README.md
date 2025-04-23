# Depi-Prometheus-Assignment
## a)	Prometheus Setup 
##### •	Deploy Prometheus in your Kubernetes cluster. Ensure that it scrapes metrics from the web server deployment created in Assignment 3.
##### •	Visualize key metrics like CPU and memory usage for each pod in the deployment using Prometheus' built-in UI.
## Answer:-
### Step 1:- Install Helm
```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```
### Step 2:- Apply the Deployment
```bash
sudo kubectl apply -f .
sudo kubectl get pods
```
![0001](https://github.com/user-attachments/assets/e3e55ba7-ab65-45ed-9f3e-f89547c20feb)

### Step 3:- Prometheos Install
```bash
sudo helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
sudo helm repo update
sudo helm install prometheus prometheus-community/prometheus
sudo kubectl get pods -A
```
![002](https://github.com/user-attachments/assets/711501b1-8bb2-4f9a-a9ee-ccb0226f41f5)

### Step 4:- Access Prometheus
```bash
sudo kubectl port-forward svc/prometheus-server 9090:80 &
http://localhost:9090
```
![003](https://github.com/user-attachments/assets/9024d989-815f-4e8d-947c-e2f7f3b56599)

### Step 5:- Run Query to get data
```bash
sum(rate(container_cpu_usage_seconds_total{namespace=~"default", pod=~"web-server-deployment-.*"}[5m])) by (pod)
```

![004](https://github.com/user-attachments/assets/6fabe5e7-2650-45b4-aa90-da72eed6860c)

```bash
sum(container_memory_working_set_bytes{namespace=~"default", pod=~"web-server-deployment-.*"}) by (pod)
```
![005](https://github.com/user-attachments/assets/e21b6c43-5f97-4d77-bf9b-ea95735d2404)

---
## b)	Custom Metrics and Alerts
##### •	Create a custom Prometheus alert that triggers when any pod’s CPU usage exceeds 80%.
##### •	Set up an alerting mechanism that sends notifications to a Slack channel or email when the alert triggers.
## Answer:-
### Step 1:- Define the Alert Rule
```bash
sudo helm ls -A
```
![006](https://github.com/user-attachments/assets/817da255-e927-44f6-81ee-fa2534a6f68a)

![007](https://github.com/user-attachments/assets/2d87d475-8be3-43bf-9ccf-0252123ce614)

```bash
sudo helm upgrade prometheus prometheus-community/prometheus -f prometheus-values.yaml
sudo kubectl port-forward svc/prometheus-alertmanager 9093:9093 &
```
### Step 2:- Stress the web pods to test the slack notification
```bash
sudo ./Stress.sh
```
