class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :end_date, :start_date, :status

  before_validation { self.status = "PENDING" if self.status.nil? }

  validates :cat_id, :end_date, :start_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validate :overlapping_approved_requests

  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def overlapping_approved_requests
    overlaps = CatRentalRequest
      .where(cat_id: self.cat_id, status: "APPROVED")
      .select do |rental|
        (rental.start_date <= self.start_date && rental.end_date >= self.start_date) ||
        (rental.start_date <= self.end_date && rental.end_date >= self.end_date)
      end.count

      if overlaps > 0 && self.status == "APPROVED"
        errors.add(:base, "Dates overlap.")
      end
  end

  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save if self.valid?
    end
  end

  def deny!
    self.transaction do
      self.status = "DENIED"
      self.save if self.valid?
    end
  end
end
