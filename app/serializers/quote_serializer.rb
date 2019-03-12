class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :attribution, :owner

  # extract relevant owning user attributes
  def owner
    {owner_id: self.object.user.id, 
     owner_account: self.object.user.email}
  end 
end
