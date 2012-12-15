buster.spec.expose()




#@send "startApplication",
#  parameters:
#    id: @application_json.id
#    name: @application_json.name
#    path: @application_json.application_path
#    server_host: URI(@json_url).hostname()
#    server_port: ( URI(@json_url).port() || "80" )
#    bottom_bars:  @application_json.bottom_bars
#    configuration: @application_json.configuration
#    appearance: @application_json.appearance
#    authentication: @application_json.authentication
#    update: @application_json.update