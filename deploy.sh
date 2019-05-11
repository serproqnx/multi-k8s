docker build -t serproqnx/multi-client:latest -t serproqnx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t serproqnx/multi-server:latest -t serproqnx/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t serproqnx/multi-worker:latest -t serproqnx/mutli-worker:$SHA -f ./worker/Dockerfile ./worker

docker push serproqnx/multi-client:latest
docker push serproqnx/multi-server:latest
docker push serproqnx/multi-worker:latest

docker push serproqnx/multi-client:$SHA
docker push serproqnx/multi-server:$SHA
docker push serproqnx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=serproqnx/multi-server:$SHA
kubectl set image deployments/client-deployment client=serproqnx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=serproqnx/multi-worker:$SHA
