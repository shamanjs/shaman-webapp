Todo = dermis.model
  title: ""
  completed: false

Todos = dermis.collection
  all: -> @get 'items'
  add: ({currentTarget}) -> 
    console.log currentTarget
    @push Todo.create
      title: currentTarget.value
      completed: false
    currentTarget.value = ''

define ["templates/#{viewName}"], (ui) ->
  show: ->
    $ ->
      $("#main").html ui()
      Todos.bind $("#main")

