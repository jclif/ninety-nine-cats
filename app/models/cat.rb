class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex

  validates :age, numericality: true
  validates :color, inclusion: { in: %w(black white grey magenta green) }
  validates :sex, length: { maximum: 1}, inclusion: { in: %w(M F) }
  validates :sex, :name, presence: true

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )
end
