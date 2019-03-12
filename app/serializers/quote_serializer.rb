class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :attribution
end
