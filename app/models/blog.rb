class Blog < ApplicationRecord
  # Associations
  belongs_to :admin
  belongs_to :category

  # Carrierwave uploader
  mount_uploaders :images, ImageUploader
  serialize :images, JSON # If you use SQLite, add this line.
end

# a.image = Rails.root.join('public/Nutritionist.jpg').open
