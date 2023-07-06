class Image < ApplicationRecord
    validates :prompt, presence: true
    validates :size, presence: true

    broadcasts_to ->(image) { "images" }, inserts_by: :prepend
  end
  