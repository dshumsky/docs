.PHONY:

helm-fetch:
	helm fetch stable/prometheus --untar

helm-generate:
	rm -rf generated
	mkdir generated
	helm template prometheus \
      --output-dir generated \
      --name prometheus \
      --namespace infra \
      --set alertmanager.enabled=false \
      --set pushgateway.enabled=false \
      --set server.persistentVolume.size=50Gi \
      --set server.statefulSet.enabled=true \
      --set serviceAccounts.alertmanager.create=false \
      --set serviceAccounts.pushgateway.create=false

