


# fluent-operator配置和使用            **2738qowc**                 依赖   221qywg
## 操作实践

make install


# 测试1  【查看pod状态和CRD资源】
kubectl get daemonset -A|grep fluent
kubectl get po -A|grep fluent
kubectl get FluentBit -A
kubectl get ClusterFluentBitConfig
kubectl get clusterfilter.fluentbit.fluent.io -A
kubectl get ClusterInput -A
kubectl get ClusterOutput.fluentbit.fluent.io -A





---

## 架构图

![Fluent-operator](docs/images/fluent-operator.svg)


![Fluent Bit workflow](docs/images/fluent-bit-operator-workflow.svg)



![logging stack](docs/images/logging-stack.svg)

