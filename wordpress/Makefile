.PHONY:

helm-fetch:
	helm fetch stable/wordpress --untar

helm-generate:
	rm -rf generated
	mkdir generated
	helm template wordpress \
      --output-dir generated \
      --name wordpress \
      --namespace default \
      --set image.tag=5.3.2-r2 \
      --set mariadb.enabled=false \
      --set externalDatabase.host=mysql-host \
      --set externalDatabase.user=w_user \
      --set externalDatabase.password=CHANGE_ME \
      --set externalDatabase.database=wordpress \
      --set wordpressSkipInstall=true \
      --set wordpressEmail=dshumsky@gmail.com \
      --set wordpressUsername=user \
      --set wordpressPassword=CHANGE_ME \
      --set wordpressScheme=https \
      --set persistence.size=8Gi \
      --set service.type=NodePort
