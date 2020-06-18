docker build -t jtrolle/multi-client:latest -t jtrolle/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jtrolle/multi-server:latest -t jtrolle/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t jtrolle/multi-worker:latest -t jtrolle/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push jtrolle/multi-client:latest
docker push jtrolle/multi-server:latest
docker push jtrolle/multi-worker:latest

docker push jtrolle/multi-client:$SHA
docker push jtrolle/multi-server:$SHA
docker push jtrolle/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jtrolle/multi-server:$SHA
kubectl set image deployments/client-deployment client=jtrolle/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jtrolle/multi-worker:$SHA