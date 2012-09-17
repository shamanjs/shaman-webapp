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
  input = ""
  list  = ""
  t  = "center: h1 #{agent.name}\n"
  t += "#input\n"
  t += "#list"

  agent.write "views/#{view}/#{view}.jade", t

  c  = "define ->\n\t(_, index) ->\n\t\t$('#main').html index()\n\t\t"
  c += "#foo"

  agent.write "views/#{view}/#{view}.coffee", c

  #agent.write app/path data
  #for field, props of model
  #  input += crudSchema[getMongooseType(props)].input(field) + "\n"
    #list  += crudSchema[getMongooseType(props)].display()

  return agent
  #breakr input
