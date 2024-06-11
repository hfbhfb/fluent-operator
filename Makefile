



########## 替换掉k8s CRD开发框架依赖的Makefile。只用于部署使用

helmAppName=fluent1
install:
	-kubectl create ns fluentns
	-touch values.yaml
	helm install ./myhelmfluent2.8/ --namespace fluentns --values ./values.yaml --name-template ${helmAppName}

uninstall:
	helm delete ${helmAppName} --namespace fluentns


# 把特定命名空间的日志导入不同的index组里
forp3:
	kubectl delete -f example/outputp3.yaml
	kubectl apply -f example/outputp3.yaml

clearp3:
	kubectl delete -f example/outputp3.yaml


