import Channel from "@dashkite/reactive/channel"
import * as DOM from "@dashkite/dominator"

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

  DOM.invalid root, ( target ) ->
    errors = capture target
    channel.send errors

  DOM.change root, "form [name]", ( target ) ->
    errors = dismiss target
    channel.send errors

  channel

export { validate }
export default validate