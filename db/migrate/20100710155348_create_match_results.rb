class CreateMatchResults < ActiveRecord::Migration
  def self.up
    create_table :match_results do |t|
      t.integer :league_id
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :played_at
      t.string :half_time_result
      t.string :full_time_result
      t.integer :status
      t.string :additional

      t.timestamps
    end
  end

  def self.down
    drop_table :match_results
  end
end
