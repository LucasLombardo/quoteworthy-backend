class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :attribution, :owner, :rails_id

  # extract relevant owning user attributes
  def owner
    {owner_id: self.object.user.id, 
     owner_account: self.object.user.email}
  end

  # give id an alias so graphQl doesn't overwrite id
  def rails_id
    self.object.id
  end
end
