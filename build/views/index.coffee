crud = require './crud'
{readFileSync} = require 'fs'
path = require 'path'
shaman = require 'shaman'
log = require 'node-log'
module.exports = (agent) ->
  
  src  = path.resolve __dirname, "./templates"
  dest = "#{agent.paths.app}/views/"
  mkdir '-p', dest
  shaman.clone src, dest, agent, (err) ->
    return log.error err if err? 
    log.info "#{dest} cloned to"

  ###
  for view, props of agent.views
    # index
    agent.write? 'web/client/index.jade', readFileSync resolve(__dirname, './templates/index.jade')

    if props.crud?
      agent = crud view, props, agent.models[props.crud]


  return agent

    if typeof(val) is 'string'
      views[key] = { "_desc": val }
    else if typeof(val) is 'object'
      views[key] = val
    return views
