.PHONY:

helm-fetch:
	helm fetch stable/datadog --untar

helm-generate:
	rm -rf generated
	mkdir generated
	helm template datadog \
      --output-dir generated \
      --name datadog \
      --namespace kube-system \
      --set datadog.apiKey=$API_KEY \
      --set datadog.appKey=$APP_KEY \
      --set datadog.apmEnabled=true \
      --set datadog.nonLocalTraffic=true \
      --set datadog.logsEnabled=false \
      --set datadog.logsConfigContainerCollectAll=true \
      --set datadog.limits.cpu=1000m \
      --set datadog.limits.memory=512Mi \
      --set datadog.processAgentEnabled=true \
      --set daemonset.useHostPort=true \
      --set clusterAgent.enabled=true \
      --set clusterAgent.metricsProvider.enabled=true

helm-install:
	helm install stable/datadog \
      --name datadog \
      --namespace kube-system \
      --set datadog.apiKey=$API_KEY \
      --set datadog.appKey=$APP_KEY \
      --set datadog.apmEnabled=true \
      --set datadog.nonLocalTraffic=true \
      --set datadog.logsEnabled=false \
      --set datadog.logsConfigContainerCollectAll=true \
      --set datadog.limits.cpu=1000m \
      --set datadog.limits.memory=512Mi \
      --set datadog.processAgentEnabled=true \
      --set daemonset.useHostPort=true \
      --set clusterAgent.enabled=true \
      --set clusterAgent.metricsProvider.enabled=true

delete-all:
	kubectl delete deployment -n kube-system datadog-cluster-agent
	kubectl delete deployment -n kube-system datadog-kube-state-metrics
	kubectl delete svc -n kube-system datadog-cluster-agent
	kubectl delete svc -n kube-system datadog-cluster-agent-metrics-api
	kubectl delete svc -n kube-system datadog-kube-state-metrics
	kubectl delete ClusterRoleBinding datadog
	kubectl delete ClusterRoleBinding datadog-cluster-agent
	kubectl delete ClusterRoleBinding datadog-cluster-agent-external-metrics-reader
	kubectl delete ClusterRoleBinding datadog-cluster-agent:system:auth-delegator
	kubectl delete ClusterRoleBinding datadog-kube-state-metrics
	kubectl delete -n kube-system ServiceAccount datadog
	kubectl delete -n kube-system ServiceAccount datadog-cluster-agent
	kubectl delete -n kube-system ServiceAccount datadog-kube-state-metrics
	kubectl delete ClusterRole datadog-cluster-agent
	kubectl delete ClusterRole datadog-cluster-agent-external-metrics-reader
	kubectl delete ClusterRole datadog-kube-state-metrics
