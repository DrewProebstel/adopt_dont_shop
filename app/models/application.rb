class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: false
  validates :status, presence: true

  has_many :application_pets
  has_many :pets, through: :application_pets



  def self.pending_applications
    where(:status == "Pending")
  end

  def in_progress?
    status == "In Progress"
  end

  def pending?
    status == "Pending"
  end

  def update_status
    statuses = application_pets.pluck(:status)
    if statuses.include?("Rejected")
      update(status: "Rejected")
    elsif statuses.all?("Approved")
      update(status: "Approved")
    else
      update(status: "Pending")
    end
  end

end
