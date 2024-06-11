[Service]
    Http_Server    true
    Parsers_File    parsers.conf
[Input]
    Name    systemd
    Path    /var/log/journal
    DB    /fluent-bit/tail/systemd.db
    DB.Sync    Normal
    Tag    service.*
    Systemd_Filter    _SYSTEMD_UNIT=docker.service
    Systemd_Filter    _SYSTEMD_UNIT=kubelet.service
[Input]
    Name    tail
    Path    /var/log/containers/*.log
    Refresh_Interval    10
    Skip_Long_Lines    true
    DB    /fluent-bit/tail/pos.db
    DB.Sync    Normal
    Mem_Buf_Limit    100MB
    Parser    docker
    Tag    kube.*
[Filter]
    Name    lua
    Match    kube.*
    script    /fluent-bit/config/containerd.lua
    call    containerd
    time_as_table    true
[Filter]
    Name    kubernetes
    Match    kube.*
    Kube_URL    https://kubernetes.default.svc:443
    Kube_CA_File    /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    Kube_Token_File    /var/run/secrets/kubernetes.io/serviceaccount/token
    Labels    false
    Annotations    false
[Filter]
    Name    nest
    Match    kube.*
    Operation    lift
    Nested_under    kubernetes
    Add_prefix    kubernetes_
[Filter]
    Name    modify
    Match    kube.*
    Remove    stream
    Remove    kubernetes_pod_id
    Remove    kubernetes_host
    Remove    kubernetes_container_hash
[Filter]
    Name    nest
    Match    kube.*
    Operation    nest
    Wildcard    kubernetes_*
    Nest_under    kubernetes
    Remove_prefix    kubernetes_
[Filter]
    Name    lua
    Match    service.*
    script    /fluent-bit/config/systemd.lua
    call    add_time
    time_as_table    true
[Output]
    Name    es
    Match_Regex    (?:kube|service)\.(.*)
    Host    elasticsearch.escluster2.svc
    Port    9200
    Buffer_Size    20MB
    Logstash_Format    true
    Logstash_Prefix    ks-logstash-log
    Time_Key    @timestamp
    Generate_ID    true
    Trace_Error    true
[Output]
    Name    es
    Match_Regex    kube.var.log.containers.*_p3_.*-(\w|\.){68}$
    Host    elasticsearch.escluster2.svc
    Port    9200
    Buffer_Size    20MB
    Index    devops-applog-p3-%Y.%m.%d
    Logstash_Format    true
    Logstash_Prefix    p3-logstash-log
    Time_Key    @timestamp
    Generate_ID    true
    Trace_Error    true