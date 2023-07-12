class Sound < ApplicationRecord
  has_one_attached :file
  
  broadcasts_to ->(sound) { "sounds" }, inserts_by: :prepend
end
