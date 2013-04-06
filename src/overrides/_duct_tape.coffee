Number::truncate = ->
  if this > 0
    Math.floor(this)
  else if this < 0
    Math.ceil(this)
  else
    this

Point::abs = ->
  Point
    x: @x.abs()
    y: @y.abs()

Point::snap = (n) ->
  Point
    x: @x.snap(n)
    y: @y.snap(n)

Point::angle = ->
  Math.atan2(@y, @x)
