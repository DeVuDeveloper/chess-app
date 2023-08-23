class Aimage < ApplicationRecord
    validates :prompt, presence: true
    validates :size, presence: true

    broadcasts_to ->(aimage) { "aimages" }, inserts_by: :prepend
  end
  