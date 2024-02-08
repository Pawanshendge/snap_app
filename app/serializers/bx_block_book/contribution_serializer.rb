module BxBlockBook
  class ContributionSerializer < BuilderBase::BaseSerializer
  
    attribute :count do |object, params|
      count = 0
      account = AccountBlock::Account.find_by(id: object.friend_id)
      if (account.id == object.friend_id)
        count += 1
      end
      # count
    end

     attributes :user_id,
                :friend_id,
                :shared_link,
                :unique_identify_id 


    attribute :images do |object, params|
      if object.images.attached?
        object.images.map { |image|
          {
            # count: Array.new(AccountBlock::Account.where(id: object.friend_id)).count,
            username: AccountBlock::Account.find_by(id: object.friend_id).email,
            id: AccountBlock::Account.find_by(id: object.friend_id).id,

            url: image.service_url, only_path: true
          }
        }
      end
    end
  end
end
