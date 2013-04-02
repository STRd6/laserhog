Base = (I={}) ->
  self = GameObject(I).extend
    solid: ->
      I.solid

  return self
