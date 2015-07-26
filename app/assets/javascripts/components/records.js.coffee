{div, h2, table, thead, hr, tbody, tr, th, td} = React.DOM

@Records = React.createClass
  displayName: 'Records'
  getInitialState: ->
    records: @props.data
  getDefaultProps: ->
    records: []
  addRecord: (record) ->
    # records = @state.records.slice()
    # records.push record
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records
  deleteRecord: (record) ->
    # records = @state.records.slice()
    index = @state.records.indexOf record
    # records.splice index, 1
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records
  render: ->
    div
      className: 'records'
      h2 
        className: 'title'
        'Records'
      React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
      React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
      React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
      React.createElement RecordForm, handleNewRecord: @addRecord
      hr null
      table
        className: 'table table-bordered'
        thead null
          tr null
            th null, 'Date'
            th null, 'Comment'
            th null, 'Amount'
            th null, 'Actions'
        tbody null,
          for record in @state.records
            React.createElement Record,
              key: record._id['$oid'], 
              record: record,
              handleDeleteRecord: @deleteRecord
              handleEditRecord: @updateRecord
  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  balance: ->
    @debits() + @credits()