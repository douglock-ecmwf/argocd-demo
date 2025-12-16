{{/*
Validate that siteName is set
*/}}
{{- define "nginx-static-site.requireSiteName" -}}
  {{- required "siteName is required. Set it with --set siteName=..." .Values.siteName -}}
{{- end -}}

{{/*
Full name of the app (e.g. my-release-deployment1)
*/}}
{{- define "nginx-static-site.fullname" -}}
{{- printf "%s-%s" .Release.Name .Values.siteName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Name of the service (e.g. deployment1)
*/}}
{{- define "nginx-static-site.serviceName" -}}
{{- .Values.siteName -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "nginx-static-site.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/component: {{ .Values.siteName }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "nginx-static-site.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: {{ .Values.siteName }}
{{- end -}}
