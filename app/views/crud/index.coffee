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

  ## input
  
  input = "form(id='{modelName}Input')\n"
  for field, props of model  
    input += "  "
    input +=
      shaman.interpolate( 
        cat "#{tmplPath}/#{getMongooseType(props)}/input.jade"
      , {id: "Todo_#{field}", field: field})
    input += "\n"
  agent.write "#{viewPath}/#{modelName}Input.jade", input
  # controller
  shaman.clone "#{viewPath}/#{view}.coffee", cat("#{tmplPath}/inputController.coffee")

  ## main template

  tmpl  = shaman.interpolate (cat "#{tmplPath}/ui.jade"), agent
  tmpl += "\n"
  tmpl += "  include #{modelName}Input\n"
  #tmpl += "include '#{modelName}List'\n"
  agent.write "#{viewPath}/#{view}.jade", tmpl
  # controller
  shaman.clone "#{viewPath}/#{view}.coffee", cat("#{tmplPath}/controller.coffee")


  agent 

