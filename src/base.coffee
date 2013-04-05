Base = (I={}) ->
  self = GameObject(I).extend
    solid: ->
      I.solid

    addImpulse: (impulse) ->
      I.velocity = I.velocity.add(impulse)

  return self
