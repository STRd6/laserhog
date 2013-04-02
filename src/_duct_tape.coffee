Number::truncate = ->
  if this > 0
    Math.floor(this)
  else if this < 0
    Math.ceil(this)
  else
    this
