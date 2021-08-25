docker build -t savieman/multi-client:latest -t savieman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t savieman/mutli-server:latest -t savieman/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t savieman/mutli-worker:latest -t savieman/mutli-worker:$SHA -f ./worker/Dockerfile ./worker
docker push savieman/multi-client:latest
docker push savieman/multi-server:latest
docker push savieman/multi-worker:latest

docker push savieman/multi-client:$SHA
docker push savieman/multi-server:$SHA
docker push savieman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=savieman/multi-server:$SHA
kubectl set image deployments/client-deployment client=savieman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=savieman/multi-worker:$SHA