getMongooseType = (type) ->
  if typeof(type) is 'object' then type = type.type
  type.toString().match( /function (.+)\(\) {/ )[1].toLowerCase()

crudSchema = 
  string:  
    input: (id)  -> "input(type='text',id='new#{id}')"
    display: (val) -> "span #{val}"
  boolean: 
    input: (id) -> "input(type ='checkbox')"
    display: (val) -> "input(type='checkbox',value='#{val}')"

#list = 

##

module.exports = (agent, view, props, model) ->
  modelName = props.crud
  input = ""
  list  = ""  
  main  = "center: h1 #{agent.name}\n"
  main += "#input\n"
  main += "#list"
  agent.write "views/#{view}/#{view}.jade", main

  c  = "define ->\n\t(_, index) ->\n\t\t$('#main').html index()\n\t\t"
  #c += "$('#foo"

  agent.write "views/#{view}/#{view}.coffee", c

  #agent.write app/path data
  for field, props of model
    input += crudSchema[getMongooseType(props)].input(modelName) + "\n"
    list  += crudSchema[getMongooseType(props)].display(modelName)

  return agent
  #breakr input
