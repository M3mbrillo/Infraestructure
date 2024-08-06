
## healthcheck-nginx-ingress

Prof the nginx-ingress controler with a simple project

```sh
kubectl config set-context --current --namespace=proof-things

kubectl apply -f ./00_echo-server-deployment.yaml

kubectl apply -f ./01_echo-server-service.yaml

kubectl apply -f ./02_echo-server-ingress.yam
```

Expected result
```sh
$ curl https://echo-server.cluster.local -k

Request served by app-healthcheck-nginx-ingress-7b8959fbdf-wnwbl

GET / HTTP/1.1

Host: echo-server.cluster.local
Accept: */*
User-Agent: curl/7.88.1
X-Forwarded-For: 192.168.0.6
X-Forwarded-Host: echo-server.cluster.local
X-Forwarded-Port: 443
X-Forwarded-Proto: https
X-Forwarded-Scheme: https
X-Real-Ip: 192.168.0.6
X-Request-Id: a1b8e516eda865a797a361d459d2696d
X-Scheme: https
```