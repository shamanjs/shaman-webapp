define ->
  rivets.configure 
    adapter:
      subscribe: (o, kp, cb) ->
        console.log o, kp, cb
      unsubscribe: (o, kp, cb) -> cb()
      read: (o, kp) -> 
        console.log o, kp
      publish: (o, kp, val) ->
        console.log o, kp, val

  rivets.configure 
    formatters:
      currency: (value) -> v
      seconds: (value) -> v + " seconds"
      orBlank: (val) -> v or ""
      orZero: (val) -> v or 0