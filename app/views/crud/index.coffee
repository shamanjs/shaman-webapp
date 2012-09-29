getMongooseType = (type) ->
  if typeof(type) is 'object' then type = type.type
  type.toString().match( /function (.+)\(\) {/ )[1].toLowerCase()

##

path   = require 'path'
shaman = require 'shaman'

module.exports = (agent, view, props, model) ->
  tmplPath  = path.resolve __dirname, 'templates'
  viewPath  = "views/#{view}"
  modelName = props.crud
  
  input = "form(id='#{modelName}Input')\n"
  for field, props of model  
    input += "  "
    input +=
      shaman.interpolate( 
        cat "#{tmplPath}/#{getMongooseType(props)}/input.jade"
      , {id: "Todo_#{field}", field: field})
    input += "\n"
  agent.write "#{viewPath}/#{modelName}Input.jade", input

  ## ui.jade
  shaman.clone (cat "#{tmplPath}/ui.jade")
  , "#{viewPath}/#{view}.jade"
  , {agent: agent, modelName: modelName}

  ## controller.coffee
  shaman.clone (cat "#{tmplPath}/controller.coffee")
  , "#{viewPath}/#{view}.coffee"
  , {modelName: modelName}

  return agent 