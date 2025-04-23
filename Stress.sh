#!/bin/bash
# add pods names here
web_pods=("web-server-deployment-6fd54b68bf-29pk8" "web-server-deployment-6fd54b68bf-cqn4c" "web-server-deployment-6fd54b68bf-mx8h8")
for pod in "${web_pods[@]}"; do
  # Run stress on 8 CPUs for 10 minutes
  kubectl exec -it $pod -- stress --cpu 8 --timeout 600 
done