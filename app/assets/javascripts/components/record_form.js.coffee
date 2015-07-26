{button, input, div, form} = React.DOM
@RecordForm = React.createClass
  displayName: 'RecordForm'
  getInitialState: ->
    date: ''
    comment: ''
    amount: ''
  render: ->
    form
      className: 'form-inline'
      onSubmit: @handleSubmit
      div
        className: 'form-group'
        input
          type: 'date'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
      div
        className: 'form-group'
        input
          type: 'text'
          className: 'form-control'
          placeholder: 'Comment'
          name: 'comment'
          value: @state.comment
          onChange: @handleChange
      div
        className: 'form-group'
        input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          onChange: @handleChange
      button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create record'
  handleChange: (e) ->
    @setState "#{e.target.name}": e.target.value

  valid: ->
    @state.date && @state.comment && @state.amount

  handleSubmit: (e) ->
    e.preventDefault()
    $.post 'records', { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'
