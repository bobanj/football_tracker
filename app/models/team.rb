class Team < ActiveRecord::Base
  # Associations
  belongs_to :league
  has_many :home_matches, :class_name => 'MatchResult', :foreign_key => :home_team_id, :order => 'played_at desc'
  has_many :away_matches, :class_name => 'MatchResult', :foreign_key => :away_team_id, :order => 'played_at desc'

  # Validations
  validates_uniqueness_of :name
  validates_presence_of :league, :name

  # Public methods
  def matches
    home_matches + away_matches
  end
end
