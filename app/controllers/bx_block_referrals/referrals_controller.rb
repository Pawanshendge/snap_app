module BxBlockReferrals
  class ReferralsController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    include JSONAPI::Deserialization
    before_action :validate_json_web_token

    def get_user_referral
      @account = AccountBlock::Account.find_by(id: @token.id)  
      if @account.present?  
         if @account.referral_user.present?
             render json: BxBlockReferrals::ReferralSerializer.new(@account.referral_user).serializable_hash, status: :ok            
         else
            return render json: { message: "Account referral not created" }, status: 422
         end
      else
        return render json: { message: "Account not found" }, status: 422       
      end   
    end

    def add_referral
     @account = AccountBlock::Account.find_by(id: @token.id)  
     @referral = ReferralUser.find_by(referral_code: params[:referral_code])  
     if @referral.present?
        if @account.referral_user.referral_by.nil?
          unless @account.referral_user.referral_code == params[:referral_code]
            @account.referral_user.update(referral_by: params[:referral_code])
            render json: BxBlockReferrals::ReferralSerializer.new(@account.referral_user).serializable_hash, status: :ok 
          else
            return render json: { message: "You can't used this code" }, status: 422
          end
        else 
            return render json: { message: "used already" }, status: 422
        end
     else
       return render json: { message: "referral code not authorized" }, status: 422
     end       
    end

    def create_referral
     @account = AccountBlock::Account.find_by(id: @token.id)  
      if @account.present?
        if @account.referral_user.nil?
          referral_code = attach_shareable_link_to_account
          refferal_user = BxBlockReferrals::ReferralUser.create(account_id: @account.id, referral_code: referral_code)
        else
          return render json: { message: "already create referral code" }, status: 422               
        end
       if refferal_user.save
         # render json: BxBlockReferrals::ReferralSerializer.new(refferal_user).serializable_hash, status: :ok 
         render json: {referral_code: refferal_user.referral_code}, status: :ok 
       else
         return render json: { message: "something wrong" }, status: 422               
       end
      end
    end  

    private

    def attach_shareable_link_to_account
      o = [('a'..'z'), ('A'..'Z'), ('1'..'9')].map(&:to_a).flatten
      @refer_code = (0...10).map { o[rand(o.length)] }.join
      return @refer_code
    end
  end
end
