{{/*
Return the name of the chart
*/}}
{{- define "swimlane-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the full name of the chart
*/}}
{{- define "swimlane-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create standard labels
*/}}
{{- define "swimlane-app.labels" -}}
helm.sh/chart: {{ include "swimlane-app.chart" . }}
{{ include "swimlane-app.selectorLabels" . }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create standard selector labels
*/}}
{{- define "swimlane-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "swimlane-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the chart
*/}}
{{- define "swimlane-app.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}
