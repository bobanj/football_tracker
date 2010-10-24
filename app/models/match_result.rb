class MatchResult < ActiveRecord::Base
  # Associations
  belongs_to :home_team, :class_name => 'Team', :foreign_key => :home_team_id
  belongs_to :away_team, :class_name => 'Team', :foreign_key => :away_team_id
  belongs_to :league

  # Validations
  validates_uniqueness_of :played_at, :scope =>[:home_team_id, :away_team_id, :league_id]
  validates_presence_of :league, :home_team, :away_team, :played_at, :half_time_result, :full_time_result, :status

end
