getMongooseType = (type) ->
  if typeof(type) is 'object' then type = type.type
  type.toString().match( /function (.+)\(\) {/ )[1].toLowerCase()

crudSchema = 
  string:  
    input: (id)  -> "input(id=#{id})"
    display: (val) -> "span #{val}"
  boolean: 
    input: ""
    display: (val) -> "input(type='checkbox',value='#{val}')"

#list = 

##

module.exports = (view, props, model) ->
  for field, props of model
    view += crudSchema[getMongooseType props]
