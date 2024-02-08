module BxBlockBook
  class InviteUserSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :email, :status, :sharable_link, :unique_identify_id, :account_id, :table_books_id    
  end
end
