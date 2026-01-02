{{/*
Expand the name of the chart.
NOTE:
- 사용자에게 노출되는 name은 Release.Name 기준
- Chart.Name은 내부 구현용
*/}}
{{- define "workloads-deployment.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified app name.
RULE:
- fullname = Release.Name
- fullnameOverride는 비상용(마이그레이션 등)으로만 사용
*/}}
{{- define "workloads-deployment.fullname" -}}
{{- default .Release.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
(INTERNAL METADATA ONLY)
*/}}
{{- define "workloads-deployment.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "workloads-deployment.labels" -}}
helm.sh/chart: {{ include "workloads-deployment.chart" . }}
{{ include "workloads-deployment.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "workloads-deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ include "workloads-deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "workloads-deployment.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "workloads-deployment.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}