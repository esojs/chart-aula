{{/*
Criar as nossas Tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app | quote }}
env: {{ .labels.env | quote }}
live: {{ .labels.live | quote }}
{{- end }}

{{/*
Definir os limites de recursos
*/}}
{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory }}
  cpu: {{ .resources.requests.cpu }}
limits:
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end }}

{{/*
Definir as portas dos container
*/}}
{{- define "app.ports" -}}
{{- range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/*
Definir os configmaps
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-databases-config
data:
  app-config.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}


{{/*
Definir os configmaps observability
*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}
