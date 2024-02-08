module BxBlockBook
  class BookColorSerializer < BuilderBase::BaseSerializer
    include JSONAPI::Serializer
    attributes :id, :book_color, :title_color, :logo_color
  end
end
