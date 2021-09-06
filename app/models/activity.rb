class Activity < ApplicationRecord
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :address1, :address2, presence: true,
                                  format: { with: /.+,.+,.+/i, message: 'please enter adress in correct format (street, city, country)' }

  geocoded_by :address1
  geocoded_by :address2

  belongs_to :user

  def address
    [street, city, state, country].compact.join(', ')
  end
end
