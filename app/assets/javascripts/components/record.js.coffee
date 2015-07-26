{tr, td, a, input} = React.DOM
@Record = React.createClass
  displayName: 'Record'
  getInitialState: ->
    edit: false
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
  recordRow: ->
    tr null,
      td null, @props.record.date
      td null, @props.record.comment
      td null, @props.record.amount
      td null,
        a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  recordForm: ->
      tr null,
        td null,
          input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.date
            ref: 'date'
        td null,
          input
            className: 'form-control'
            type: 'text'
            defaultValue: @props.record.comment
            ref: 'comment'
        td null,
          input
            className: 'form-control'
            type: 'number'
            defaultValue: @props.record.amount
            ref: 'amount'
        td null,
          a
            className: 'btn btn-default'
            onClick: @handleEdit
            'Update'
          a
            className: 'btn btn-danger'
            onClick: @handleToggle
            'Cancel'
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record._id['$oid'] }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record
  handleEdit: (e) ->
    e.preventDefault()
    data =
      comment: React.findDOMNode(@refs.comment).value
      date: React.findDOMNode(@refs.date).value
      amount: React.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record._id['$oid'] }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
