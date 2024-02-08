module BxBlockStories
	class Story < ApplicationRecord
		self.table_name = :bx_block_stories_stories

		STORY_CONTENT_TYPE = ['image/bmp', 'image/svg+xml', 'image/webp', 'image/svg', 'image/tiff', 'image/png', 'image/jpg', 'image/jpeg', 'image']

		has_one_attached :story_file
		enum story_type: ['story', 'blog']
		# validates :story_file, attached: true
		validates :valid_till, presence: true
		validates :description, :link, :title, presence: true, if: -> {self.story_type == "blog"}
		validates_length_of :description, minimum: 1, maximum: 400, if: -> {self.story_type == "blog" || self.description.present?}
		validate :story_file_size_image
		validate :check_valid_date

		private

		def story_file_size_image
			if story_file&.attachment.present?
				if BxBlockStories::Story::STORY_CONTENT_TYPE.include?(story_file&.content_type)
					if story_file.blob.byte_size > 2.megabytes
						errors[:story_file] << "should be less than 2 MB"
					end
				end
			end
		end

		def check_valid_date
			if self.valid_till.present?
				errors.add(:valid_till, "Please enter a valid date and time") if Time.zone.now > valid_till
			end
		end
	end
end