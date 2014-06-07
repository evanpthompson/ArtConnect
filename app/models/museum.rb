class Museum < ActiveRecord::Base
  validates :name, :website, presence: true
  validates_uniqueness_of :name
end
