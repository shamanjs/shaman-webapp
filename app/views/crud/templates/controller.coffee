define ->
  (args, ui) ->
    ui '#main'
    $("##{modelName}Input").submit (e) ->
      console.log e
      e.preventDefault()
      return false