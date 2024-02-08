module BxBlockCustomUserSubs
  class UserSubscriptionsController < ApplicationController

    # def index
    #   render json: BxBlockCustomUserSubs::SubscriptionSerializer.new(user_subscriptions, params: {user: current_user}).serializable_hash
    # end

    # def show
    #   subscription = user_subscriptions.find(params[:id])
    #   render json: BxBlockCustomUserSubs::SubscriptionSerializer.new(subscription, params: {user: current_user}).serializable_hash
    # end

    def create
      user_subscription = BxBlockCustomUserSubs::UserSubscription.create(subscription_id: params[:id], account_id: current_user.id)
      subscription = user_subscription.subscription
      render json: BxBlockCustomUserSubs::SubscriptionSerializer.new(subscription, params: {user: current_user}).serializable_hash
    end

    private

    # def user_subscriptions
    #   BxBlockCustomUserSubs::Subscription.joins(:user_subscription).where('user_subscription.account_id = ?', current_user.id)
    # end

  end
end
