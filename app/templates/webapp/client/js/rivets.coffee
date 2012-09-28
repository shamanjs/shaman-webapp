define ["app/lock"], (lock)->
  rivets.configure 
    adapter:
      subscribe: (o, kp, cb) ->
        lock.on 'sync', (r) -> cb r[kp.replace(/,/g,'.')]
      unsubscribe: (o, kp, cb) -> cb()
      read: (o, kp) -> o[kp.replace(/,/g,'.')]
      publish: (o, kp, val) ->
        lock.atomic(->
          @set kp.replace(/,/g,'.'), val
          @done()
        ).run()

  rivets.configure 
    formatters:
      currency: (value) -> v
      seconds: (value) -> v + " seconds"
      orBlank: (val) -> v or ""
      orZero: (val) -> v or 0