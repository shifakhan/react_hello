class Record
  include Mongoid::Document

  field :comment
  field :amount, type: Float
  field :date, type: Date

end
