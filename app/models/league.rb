class League < ActiveRecord::Base
  # Associations
  has_many :teams, :order => 'points desc'
  has_many :match_results

  # Validations
  validates_uniqueness_of :name
  validates_presence_of :name, :url_param
end
