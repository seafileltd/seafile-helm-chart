{{/* Check image use or set by default  */}}
{{- define "seafile.image" -}}
    {{- if .Values.seafile.configs.image }}
        {{- printf "%s" .Values.seafile.configs.image }}
    {{- else }}
        {{- printf "seafileltd/seafile-pro-mc:%s-latest" .Chart.AppVersion }}
    {{- end }}
{{- end }}

{{/* Check volume use or set by default  */}}

{{/* for storage size  */}}
{{- define "seafile.seafileDataVolume.storage" -}}
    {{- if .Values.seafile.configs.seafileDataVolume }}
        {{- if .Values.seafile.configs.seafileDataVolume.storage }}
            {{- printf "%s" .Values.seafile.configs.seafileDataVolume.storage }}
        {{- else }}
            {{- printf "10Gi" }}
        {{- end }}
    {{- else }}
        {{- printf "10Gi" }}
    {{- end }}
{{- end }}

{{/* for storage path  */}}
{{- define "seafile.seafileDataVolume.path" -}}
    {{- if .Values.seafile.configs.seafileDataVolume }}
        {{- if .Values.seafile.configs.seafileDataVolume.hostPath }}
            {{- printf "%s" .Values.seafile.configs.seafileDataVolume.hostPath }}
        {{- else }}
            {{- printf "/opt/seafile/shared" }}
        {{- end }}
    {{- else }}
        {{- printf "10Gi" }}
    {{- end }}
{{- end }}

{{/* Check hostname and MySQL host  */}}
{{- define "seafile.hostname" -}}
    {{- $hostname := "" -}}
    {{- $dbHost := "" -}}
    {{- range .Values.seafile.env }}
        {{- if eq .name "SEAFILE_SERVER_HOSTNAME" }}
            {{- $hostname = .value -}}
        {{- end }}
        {{- if eq .name "SEAFILE_MYSQL_DB_HOST" }}
            {{- $dbHost = .value -}}
        {{- end }}
    {{- end }}

    {{- if eq $hostname "<your hostname>"}}
        {{- fail "SEAFILE_SERVER_HOSTNAME is not specified" -}}
    {{- else }}
        {{- if eq $hostname "" }}
            {{- fail "SEAFILE_SERVER_HOSTNAME is not specified" -}}
        {{- end}}
    {{- end }}

    {{- if eq $dbHost "<your MySQL host>"}}
        {{- fail "SEAFILE_MYSQL_DB_HOST is not specified" -}}
    {{- else }}
        {{- if eq $dbHost "" }}
            {{- fail "SEAFILE_MYSQL_DB_HOST is not specified" -}}
        {{- end}}
    {{- end }}

    {{- $hostname -}}
{{- end }}

{{/* check initMode use and set by default, and check init vars  */}}
{{- define "seafile.cluster.frontendNums" -}}
    {{- $initMode := "true" -}}
    {{- $initAdminEmail := "" -}}
    {{- $initMemcachedHost := "" -}}
    {{- $initESHost := "" -}}
    {{- range .Values.seafile.env }}
        {{- if eq .name "CLUSTER_INIT_MODE" }}
            {{- $initMode = .value -}}
        {{- end }}
        {{- if eq .name "INIT_SEAFILE_ADMIN_EMAIL" }}
            {{- $initAdminEmail = .value -}}
        {{- end }}
        {{- if eq .name "CLUSTER_INIT_MEMCACHED_HOST" }}
            {{- $initMemcachedHost = .value -}}
        {{- end }}
        {{- if eq .name "CLUSTER_INIT_ES_HOST" }}
            {{- $initESHost = .value -}}
        {{- end }}
    {{- end }}
    {{- if eq $initMode "true" }}
        {{- if eq $initAdminEmail "<Seafile admin's email>"}}
            {{- fail "INIT_SEAFILE_ADMIN_EMAIL is not specified in cluster initial mode" -}}
        {{- else }}
            {{- if eq $initAdminEmail "" }}
                {{- fail "INIT_SEAFILE_ADMIN_EMAIL is not specified in cluster initial mode" -}}
            {{- end}}
        {{- end }}

        {{- if eq $initMemcachedHost "<your Memcached server host>"}}
            {{- fail "CLUSTER_INIT_MEMCACHED_HOST is not specified in cluster initial mode" -}}
        {{- else }}
            {{- if eq $initMemcachedHost "" }}
                {{- fail "CLUSTER_INIT_MEMCACHED_HOST is not specified in cluster initial mode" -}}
            {{- end}}
        {{- end }}

        {{- if eq $initESHost "<your ElasticSearch server host>"}}
            {{- fail "CLUSTER_INIT_ES_HOST is not specified in cluster initial mode" -}}
        {{- else }}
            {{- if eq $initESHost "" }}
                {{- fail "CLUSTER_INIT_ES_HOST is not specified in cluster initial mode" -}}
            {{- end}}
        {{- end }}
        {{- printf "0" -}}
    {{- else }}
        {{- if .Values.seafile.configs.seafileFrontendReplicas }}
            {{- printf "%d" .Values.seafile.configs.seafileFrontendReplicas }}
        {{- else }}
            {{- printf "1" }}
        {{- end }}
    {{- end }}
{{- end }}
