{{/*
Return a replica object based on given presets
Example usage:
{{ include "replicas.preset" (dict "node" "proxy" "size" "small") -}}
*/}}
{{- define "replicas.preset" }}
  {{- $presetSizes := dict
    "proxy" (dict
      "small" 1
      "medium" 4
      "large" 8
    )
    "db" (dict
      "small" 1
      "medium" 1
      "large" 1
    )
    "api" (dict
      "small" 1
      "medium" 4
      "large" 8
    )
    "manager" (dict
      "small" 1
      "medium" 4
      "large" 8
    )
    "guac" (dict
      "small" 1
      "medium" 2
      "large" 3
    )
    "rdp" (dict
      "small" 1
      "medium" 2
      "large" 3
    )
    "share" (dict
      "small" 1
      "medium" 2
      "large" 3
    )
    "redis" (dict
      "small" 1
      "medium" 1
      "large" 1
    )
  }}
  {{- if hasKey $presetSizes .node }}
    {{- if hasKey (get $presetSizes .node) .size }}
      {{- dig .node .size "" $presetSizes | toYaml -}}
    {{- else }}
      {{- printf "ERROR: Preset key '%s' invalid. Allowed values are %s" .size (join "," (keys (get $presetSizes .node))) | fail }}
    {{- end }}
  {{- else }}
    {{- printf "ERROR: Preset key '%s' invalid. Allowed values are %s" .node (join "," (keys $presetSizes)) | fail }}
  {{- end }}
{{- end }}