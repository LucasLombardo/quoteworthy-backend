class AttributionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :quote
end
