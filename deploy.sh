docker build -t alexyoungz/multi-client:latest -f -t alexyoungz/multi-client:$SHA ./client/Dockerfile ./client
docker build -t alexyoungz/multi-server:latest -f -t alexyoungz/multi-server:$SHA ./server/Dockerfile ./server
docker build -t alexyoungz/multi-worker:latest -f -t alexyoungz/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push alexyoungz/multi-client:latest
docker push alexyoungz/multi-server:latest
docker push alexyoungz/multi-worker:latest

docker push alexyoungz/multi-client:$SHA
docker push alexyoungz/multi-server:$SHA
docker push alexyoungz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/cl-deployment server=alexyoungz/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexyoungz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexyoungz/multi-worker:$SHA