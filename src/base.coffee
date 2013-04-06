Base = (I={}) ->
  self = GameObject(I).extend
    addImpulse: (impulse) ->
      I.velocity = I.velocity.add(impulse)

  return self
