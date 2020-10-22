docker build -t wangbaoming/multi-client -f ./client/Dockerfile ./client
docker build -t wangbaoming/multi-server -f ./server/Dockerfile ./server
docker build -t wangbaoming/multi-worker -f ./worker/Dockerfile ./worker

docker push wangbaoming/multi-client
docker push wangbaoming/multi-server
docker push wangbaoming/multi-worker

kubectl apply -f k8s
kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/client-deployment
kubectl rollout restart deployment/worker-deployment