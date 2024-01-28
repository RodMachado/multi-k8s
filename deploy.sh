docker build -t rodmachado/multi-client:latest -t rodmachado/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rodmachado/multi-server:latest -t rodmachado/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rodmachado/multi-worker:latest -t rodmachado/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rodmachado/multi-client:latest
docker push rodmachado/multi-client:$SHA
docker push rodmachado/multi-server:latest
docker push rodmachado/multi-server:$SHA
docker push rodmachado/multi-worker:latest
docker push rodmachado/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rodmachado/multi-server:$SHA
kubectl set image deployments/client-deployment client=rodmachado/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rodmachado/multi-worker:$SHA