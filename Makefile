



########## 替换掉k8s CRD开发框架依赖的Makefile。只用于部署使用

helmAppName=fluent1
install:
	-kubectl create ns fluentns
	-touch values.yaml
	helm install ./myhelmfluent2.8/ --namespace fluentns --values ./values.yaml --name-template ${helmAppName}

uninstall:
	helm delete ${helmAppName} --namespace fluentns

