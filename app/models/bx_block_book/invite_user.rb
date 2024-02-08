module BxBlockBook
  class InviteUser < BxBlockBook::ApplicationRecord
    self.table_name = :invite_users
    serialize :emails, Array
    belongs_to :account, class_name: 'AccountBlock::Account' 
    belongs_to :books, class_name: 'BxBlockBook::Book'
    enum status: {
      accepted: 0,
      rejected: 1
    }
  end
end
