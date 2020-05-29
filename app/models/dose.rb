class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true
  validates :ingredient, uniqueness: {
    scope: :cocktail,
    message: 'Ingredient is already included in cocktail',
    case_sensitive: false
  }
end
