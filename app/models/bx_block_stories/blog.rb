module BxBlockStories
	class Blog < ApplicationRecord
		self.table_name = :bx_block_stories_blogs

		has_one_attached :blog_file

		validates :title, :description, :status, presence: true
		validates_uniqueness_of :title
		validates_length_of :title, minimum: 1, maximum: 100

		enum status: %i[active inactive]
		BLOG_CONTENT_TYPE = ['image/bmp', 'image/svg+xml', 'image/webp', 'image/svg', 'image/tiff', 'image/png', 'image/jpg', 'image/jpeg', 'image']
		after_save :save_blog_url

		def save_blog_url
			if self.present? && self.title.present?
				url = (self.title.split.size > 1 ? self.title.downcase.split(" ").join("-") : self.title.downcase)
				self.update_attributes(url: url) if url != self.url
			end
		end
	end
end
