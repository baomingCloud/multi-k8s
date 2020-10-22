docker build -t wangbaoming/multi-client:latest -t wangbaoming/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wangbaoming/multi-server:latest -t wangbaoming/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wangbaoming/multi-worker:latest -t wangbaoming/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wangbaoming/multi-client:latest
docker push wangbaoming/multi-server:latest
docker push wangbaoming/multi-worker:latest

docker push wangbaoming/multi-client:$SHA
docker push wangbaoming/multi-server:$SHA
docker push wangbaoming/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wangbaoming/multi-server:$SHA
kubectl set image deployments/client-deployment client=wangbaoming/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=wangbaoming/multi-worker:$SHA