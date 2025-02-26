import Channel from "@dashkite/reactive/channel"
import DOM from "@dashkite/dominator"

validate = ( root ) ->

  errors = {}
  
  channel = Channel.make()

  capture = ( target ) ->
    errors[ target.name ] =
      target: target
      name: target.name
      message: target.validationMessage

  dismiss = ( target ) ->
    delete errors[ target.name ]

  DOM.invalid root, ( target ) ->
    errors = capture target
    channel.send errors

  DOM.change "form [name]", ( target ) ->
    errors = dismiss target
    channel.send errors

  channel

export { validate }
export default validate