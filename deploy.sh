# Build all our images, tag each one uniquely, push each to docker hub
docker build -t rawanad/multi-client:latest -t rawanad/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t rawanad/multi-server:latest -t rawanad/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t rawanad/multi-worker:latest -t rawanad/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push rawanad/multi-client:latest
docker push rawanad/multi-server:latest
docker push rawanad/multi-worker:latest

docker push rawanad/multi-client:$GIT_SHA
docker push rawanad/multi-server:$GIT_SHA
docker push rawanad/multi-worker:$GIT_SHA

# Apply all configs in the 'k8s' folder
kubectl apply -f k8s

# Imperatively set latest images on each deployment
kubectl set image deployments/server-deployment server=rawanad/multi-server:$SHA
kubectl set image deployments/client-deployment client=rawanad/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rawanad/multi-worker:$SHA