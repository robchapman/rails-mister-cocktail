class Ingredient < ApplicationRecord
  has_many :doses
  before_destroy :check_for_doses_using_this_ingredient

  validates :name, presence: true, uniqueness: true

  def check_for_doses_using_this_ingredient
    status = true
    if doses.count.positive?
      errors.add(:base, message: 'Cannot delete ingredient with active cocktails using it.')
      status = false
    end
    status
  end
end
