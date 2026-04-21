{{/*
Expand the name of the chart.
*/}}
{{- define "multica.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "multica.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "multica.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "multica.labels" -}}
helm.sh/chart: {{ include "multica.chart" . }}
{{ include "multica.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "multica.selectorLabels" -}}
app.kubernetes.io/name: {{ include "multica.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Backend selector labels
*/}}
{{- define "multica.backendSelectorLabels" -}}
{{ include "multica.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{/*
Frontend selector labels
*/}}
{{- define "multica.frontendSelectorLabels" -}}
{{ include "multica.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "multica.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "multica.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Backend fullname
*/}}
{{- define "multica.backend.fullname" -}}
{{ include "multica.fullname" . }}-backend
{{- end }}

{{/*
Frontend fullname
*/}}
{{- define "multica.frontend.fullname" -}}
{{ include "multica.fullname" . }}-frontend
{{- end }}

{{/*
ConfigMap name
*/}}
{{- define "multica.configMapName" -}}
{{ include "multica.fullname" . }}-config
{{- end }}

{{/*
Secret name
*/}}
{{- define "multica.secretName" -}}
{{ include "multica.fullname" . }}-secrets
{{- end }}

{{/*
Backend PVC name
*/}}
{{- define "multica.backend.pvcName" -}}
{{ include "multica.backend.fullname" . }}-uploads
{{- end }}

{{/*
Get PostgreSQL host
*/}}
{{- define "multica.postgresql.host" -}}
{{- .Values.externalPostgresql.host }}
{{- end }}

{{/*
Get PostgreSQL port
*/}}
{{- define "multica.postgresql.port" -}}
{{- .Values.externalPostgresql.port }}
{{- end }}

{{/*
Get PostgreSQL database name
*/}}
{{- define "multica.postgresql.database" -}}
{{- .Values.externalPostgresql.database }}
{{- end }}

{{/*
Get PostgreSQL username
*/}}
{{- define "multica.postgresql.username" -}}
{{- .Values.externalPostgresql.username }}
{{- end }}

{{/*
Get PostgreSQL secret name
*/}}
{{- define "multica.postgresql.secretName" -}}
{{- if .Values.externalPostgresql.existingSecret }}
{{- .Values.externalPostgresql.existingSecret }}
{{- else }}
{{- include "multica.secretName" . }}
{{- end }}
{{- end }}

{{/*
Get PostgreSQL secret key
*/}}
{{- define "multica.postgresql.secretKey" -}}
{{- .Values.externalPostgresql.existingSecretPasswordKey }}
{{- end }}

{{/*
Get PostgreSQL password from values
*/}}
{{- define "multica.postgresql.passwordValue" -}}
{{- .Values.externalPostgresql.password }}
{{- end }}

{{/*
Build DATABASE_URL
*/}}
{{- define "multica.databaseUrl" -}}
{{- $host := include "multica.postgresql.host" . }}
{{- $port := include "multica.postgresql.port" . }}
{{- $db := include "multica.postgresql.database" . }}
{{- $user := include "multica.postgresql.username" . }}
{{- $extraParams := .Values.externalPostgresql.extraParams }}
{{- if $extraParams }}
postgres://{{ $user }}:$(DATABASE_PASSWORD)@{{ $host }}:{{ $port }}/{{ $db }}?{{ $extraParams }}
{{- else }}
postgres://{{ $user }}:$(DATABASE_PASSWORD)@{{ $host }}:{{ $port }}/{{ $db }}
{{- end }}
{{- end }}

{{/*
Get JWT secret name
*/}}
{{- define "multica.jwt.secretName" -}}
{{- if .Values.secrets.jwt.existingSecret }}
{{- .Values.secrets.jwt.existingSecret }}
{{- else }}
{{- include "multica.secretName" . }}
{{- end }}
{{- end }}

{{/*
Get JWT secret key
*/}}
{{- define "multica.jwt.secretKey" -}}
{{- .Values.secrets.jwt.existingSecretKey }}
{{- end }}

{{/*
Get Google client secret name
*/}}
{{- define "multica.google.secretName" -}}
{{- if .Values.secrets.google.existingSecret }}
{{- .Values.secrets.google.existingSecret }}
{{- else }}
{{- include "multica.secretName" . }}
{{- end }}
{{- end }}

{{/*
Get Resend API key secret name
*/}}
{{- define "multica.resend.secretName" -}}
{{- if .Values.secrets.resend.existingSecret }}
{{- .Values.secrets.resend.existingSecret }}
{{- else }}
{{- include "multica.secretName" . }}
{{- end }}
{{- end }}

{{/*
Get CloudFront private key secret name
*/}}
{{- define "multica.cloudfront.secretName" -}}
{{- if .Values.secrets.cloudfront.existingSecret }}
{{- .Values.secrets.cloudfront.existingSecret }}
{{- else }}
{{- include "multica.secretName" . }}
{{- end }}
{{- end }}
