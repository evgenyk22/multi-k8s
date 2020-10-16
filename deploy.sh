docker build -t evgenik22/multi-client:latest -t evgenyk22/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t evgenik22/multi-server:latest -t evgenyk22/mylti-server:$SHA -f ./server/Dockerfile ./server
docker build -t evgenik22/multi-worker:latest -t evgenik22/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push evgenik22/multi-client:latest
docker push evgenik22/multi-server:latest
docker push evgenik22/multi-worker:latest

docker push evgenik22/multi-client:$SHA
docker push evgenik22/multi-server:$SHA
docker push evgenik22/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client=evgenik22/multi-client:$SHA
kubectl set image deployments/server-deployment server=evgenik22/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=evgenik22/multi-worker:$SHA
