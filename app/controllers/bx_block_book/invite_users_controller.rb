module BxBlockBook
  class InviteUsersController < BxBlockBook::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, only: [:create]
    def create
      @current_user ||= AccountBlock::Account.find(@token.id)
      email_addresses = params[:emails]

      email_addresses.each do |email|
        @invite_user = BxBlockBook::InviteUser.create(
          unique_identify_id: get_unique_identify_id,
          sharable_link: params[:sharable_link],
          name: params[:name],  # Add name if needed
          email: email,
          account_id: @current_user.id,
          table_books_id: params[:table_books_id]
        )

        @invite_user.update(status: "pending")

        if @invite_user.save
          # Uncomment the following line when you're ready to send emails
          # InviteUserMailer.with(invite_user: @invite_user).send_email.deliver_now
            # InviteUserMailer.send_email(@invite_user).deliver_now
        end
      end

      render json: {
        emails: email_addresses, status: @invite_user.status, sharable_link: @invite_user.sharable_link, unique_identify_id: @invite_user.unique_identify_id, account_id: @invite_user.account_id, owner_book_id: @invite_user.table_books_id
      }, status: :ok
    end

    def request_responses  
      byebug
       @invite =  BxBlockBook::InviteUser.find_by(email: params[:email])
       @invite.update(status: params[:status])
        render json: @invite
    end

    private

    def get_unique_identify_id
      o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
      (0...5).map { o[rand(o.length)] }.join
    end
  end
end
