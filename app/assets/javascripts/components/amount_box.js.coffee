{div} = React.DOM
@AmountBox = React.createClass
  displayName: 'AmountBox'
  render: ->
    div
      className: 'col-md-4'
      div
        className: "panel panel-#{ @props.type }"
        div
          className: 'panel-heading'
          "#{@props.text}"
        div
          className: 'panel-body'
          "#{@props.amount}"
