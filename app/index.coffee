path    = require 'path'
connect = require "connect"
log     = require 'node-log'
views   = require '../build/views'
shaman  = require 'shaman'
module.exports = (agent) -> 
  agent.web      ?= {}
  agent.web.port ?= 8080

  src  = path.resolve __dirname, "../build/templates/"
  dest = "#{agent.paths.root}/build/"
  mkdir '-p', dest
  shaman.clone src, dest, agent, (err) ->
    return log.error err if err? 
    log.info "#{dest} cloned to"
  
  # HTTP Server
  Connect = connect()
  Connect.use connect.favicon()
  Connect.use connect.static("#{dest}/webapp/public/")
  agent.web.server = Connect.listen agent.web.port
  agent.log "WebServer started on #{agent.web.port}"

  # views
  agent = views agent

  return agent