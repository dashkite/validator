import Channel from "@dashkite/reactive/channel"
import $ from "@dashkite/zest"

validate = ( root ) ->

  errors = {}
  
  channel = Channel.make()

  capture = ( target ) ->
    errors[ target.name ] =
      target: target
      name: target.name
      message: target.validationMessage
    errors

  dismiss = ( target ) ->
    delete errors[ target.name ]
    errors

  $ root
    .capture()
    .invalid()
    .prevent()
    .apply ( event ) ->
      console.log invalid: event
      errors = capture event.target
      channel.send errors

  $ root
    .listen()
    .change()
    .matches "form [name]"
    .apply ( event ) ->
      errors = dismiss event.target
      channel.send errors

  channel

export { validate }
export default validate