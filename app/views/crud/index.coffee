getMongooseType = (type) ->
  if typeof(type) is 'object' then type = type.type
  type.toString().match( /function (.+)\(\) {/ )[1].toLowerCase()

##
path   = require 'path'
shaman = require 'shaman'

module.exports = (agent, view, props, model) ->
  tmplPath = path.resolve __dirname, 'templates'
  viewPath = "views/#{view}/#{view}"
  
  modelName = props.crud

  # controller
  shaman.clone "#{viewPath}.coffee", cat("#{tmplPath}/controller.coffee")

  # main template
  tmpl  = shaman.interpolate (cat "#{tmplPath}/ui.jade"), agent
  tmpl += "\n"
  #tmpl += "include '#{modelName}Input'\n"
  #tmpl += "include '#{modelName}List'\n"

  agent.write "#{viewPath}.jade", tmpl

  # input
  input = ""

  for field, props of model  
    input += 
      shaman.interpolate( 
        cat "#{tmplPath}/#{getMongooseType(props)}/input.jade"
      , "#{model}Input")
    input += "\n"

  breakr input

  agent 

