class AddAnyonymousToBxBlockReviewsReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews_reviews, :anonymous, :boolean, default: false
  end
end
