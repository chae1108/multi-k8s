docker build -t chae1108/multi-client:latest -t chae1108/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chae1108/multi-server:latest -t chae1108/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chae1108/multi-worker:latest -t chae1108/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chae1108/multi-client:latest
docker push chae1108/multi-server:latest
docker push chae1108/multi-worker:latest

docker push chae1108/multi-client:$SHA
docker push chae1108/multi-server:$SHA
docker push chae1108/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chae1108/multi-server:$SHA
kubectl set image deployments/client-deployment client=chae1108/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chae1108/multi-worker:$SHA