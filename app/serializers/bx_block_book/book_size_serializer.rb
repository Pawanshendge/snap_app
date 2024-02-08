module BxBlockBook
  class BookSizeSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :book_size, :cover_type, :price, :min_limit, :max_limit, :book_size, :created_at, :updated_at
  end
end
