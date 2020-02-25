### Prometheus & Grafana
```yaml
disk_usage: >
  sum by (instance,device) (container_fs_usage_bytes{id="/", device=~"/dev/.*"}) /
  sum by (instance,device) (container_fs_limit_bytes{id="/", device=~"/dev/.*"}) * 100

cpu_usage: >
  sum by (instance) (rate(container_cpu_usage_seconds_total{id="/"}[5m])) / 
  sum by (instance) (machine_cpu_cores{}) * 100

ram_usage: >
  sum by (instance) (container_memory_working_set_bytes{id="/"}) / 
  sum by (instance) (machine_memory_bytes{}) * 100

persistent_volume: >
  sum by (instance,namespace,persistentvolumeclaim) (kubelet_volume_stats_used_bytes{}) / 
  sum by (instance,namespace,persistentvolumeclaim) (kubelet_volume_stats_capacity_bytes{}) * 100
```

