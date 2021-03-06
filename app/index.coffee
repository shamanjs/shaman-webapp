path    = require 'path'
connect = require "connect"
log     = require 'node-log'
views   = require './views'
shaman  = require 'shaman'
require 'shelljs/global'
module.exports = (agent) -> 

  agent.web      ?= {}
  agent.web.port ?= 8080

  src  = path.resolve __dirname, "templates/"
  dest = "#{agent.paths.root}/build/"
  mkdir '-p', dest
  shaman.clone src, dest, agent, (err) ->
    return log.error err if err? 
    log.info "#{dest} cloned to"
  
  # HTTP Server
  Connect = connect()
  Connect.use connect.favicon()
  Connect.use connect.static("#{dest}/webapp/public/")
  try
    agent.web.server = Connect.listen agent.web.port
  catch e
    log.error e
  
  agent.log "WebServer started on #{agent.web.port}"

  # create views
  agent = views agent

  return agent