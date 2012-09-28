crud = require './crud'
{readFileSync} = require 'fs'
path = require 'path'
shaman = require 'shaman'
log = require 'node-log'
module.exports = (agent) ->
  
  #src  = path.resolve __dirname, "./templates"

  dest = "#{agent.paths.app}/views/"
  mkdir '-p', dest

  #shaman.clone src, dest, agent, (err) ->
  #  return log.error err if err? 
  #  log.info "#{dest} cloned to"

  for view, props of agent.views
    mkdir '-p', "#{dest}/#{view}"
    #agent.write "#{dest}/#{view}/"
    if props.crud?
      agent = crud agent, view, props, agent.models[props.crud]
      #breakr agent
     
  return agent
