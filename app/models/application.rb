class Application < ApplicationRecord
  validates :name, presence: false
  validates :street_address, presence: false
  validates :city, presence: false
  validates :state, presence: false
  validates :zip_code, presence: false
  validates :description, presence: false
  validates :status, presence: false

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
