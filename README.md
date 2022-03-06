# to run the app

From the root directory run:

1. kubectl apply -f k8s
2. kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml

# To see which port Ingress uses

kubectl get ingress

# To visit the app:

http://localhost/80
Use either port 80 or 4434, depending on if you are using http or https connection.
