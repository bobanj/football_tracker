class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :league_id
      t.string :name
      t.string :url
      t.integer :played
      t.integer :won
      t.integer :draw
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :points
      t.decimal :goals_for_average, :precision => 6, :scale => 2
      t.decimal :goals_against_average, :precision => 6, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
