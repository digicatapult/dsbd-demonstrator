const config = {
  dsbdApiPort: {{ morello_api_port }},
  dsbdApiHost: '{{ morello_api_host }}',
}

if (!Window.config) {
  Window.config = {}
}

Window.config = Object.keys(config).reduce((out, next) => {
  if (!out.hasOwnProperty(next)) out[next] = config[next]
  return out
}, {})
