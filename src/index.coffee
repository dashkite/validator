import DOM from "@dashkite/dominator"

validate = ( root, html ) ->

  errors = {}

  capture = ( target ) ->
    errors[ target.name ] =
      target: target
      name: target.name
      message: target.validationMessage

  dismiss = ( target ) ->
    delete errors[ target.name ]

  render = ->
    data = DOM.form root
    html { data, errors }

  DOM.activate root, render
    
  DOM.invalid root, ( target ) ->
    errors = capture target
    render()

  DOM.change "form [name]", ( target ) ->
    errors = dismiss target
    render()

export { validate }
export default validate