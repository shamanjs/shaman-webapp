define ["routes/Todo"], (Todo) ->
  (args, ui) ->
    ui '#main'
    console.log "todo"
    Todo()