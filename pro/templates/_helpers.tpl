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
            {{- printf "/opt/seafile-data" }}
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
