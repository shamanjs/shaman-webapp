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
  input = ""
  for field, props of model  
    input +=
      shaman.interpolate( 
        cat "#{tmplPath}/#{getMongooseType(props)}/input.jade"
      , {id: "Todo_#{field}", field: field, list: "#{modelName}List"})
    input += "\n"
  agent.write "#{viewPath}/#{modelName}Input.jade", input

  ## ui.jade
  agent.write "#{viewPath}/#{view}.jade",
    shaman.interpolate (cat "#{tmplPath}/ui.jade")
    , {agent: agent, modelName: modelName}

  ## controller.coffee
  agent.write "#{viewPath}/#{view}.coffee",
    shaman.interpolate (cat "#{tmplPath}/controller.coffee")
    , {modelName: modelName, viewName: view}

  return agent 