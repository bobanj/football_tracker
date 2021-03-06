require 'rubygems'
require 'nokogiri'
require 'open-uri'

namespace :get do
  desc "Parse Data"
  task :teams => :environment do
    # Leagues are inserted into database after initalizing the project
    # using the rake task rake db:seed

    #Going trough each of the leagues
    League.all.each do |league|
      #Opens the requested url and parses the page
      league_html = Nokogiri::HTML(open(PARSE_SITE_URL + "/league.php?league=#{league.url_param}", :proxy => nil))
      if league_html
        #Gets the results table and each row is parsed
        league_html.css('table.borrsoft')[2].css('tr').each do |row|
          # Checks rows number of columns
          if row.css('td').size == 11
            # Goes trough every column
            row.css('td').each_with_index do |column, index|
              if column[:class] != 'loc1' #not the first row
                case index
                  when 1
                    #gets the team url from the anchor href attribute
                    team_url = '/' + column.css('a').first[:href]
                    # gets team name from the column inner text
                    team_name = column.text.strip
                    #Checks if that team already exist
                    @team = Team.find_by_name team_name
                    if @team
                      break;
                    else
                      #if the team doesen't exists a team with the collected data is created
                      @team = Team.new :name => team_name, :url => team_url, :league => league
                    end
                  when 2
                    # gets number of played matches from the second column
                    @team.played = column.text.to_i
                  when 3
                    # gets number of won matches from the third column
                    @team.won = column.text.to_i
                  when 4
                    @team.draw = column.text.to_i
                  when 5
                    @team.lost = column.text.to_i
                  when 6
                    goals = column.text.split(' : ')
                    @team.goals_for = goals[0].strip
                    @team.goals_against = goals[1].strip
                  when 8
                    @team.points = column.text.to_i
                  when 9
                    @team.goals_for_average = column.text.to_f
                  when 10
                    @team.goals_against_average = column.text.to_f
                end
              end
              if @team
                # Saves the team in the database
                @team.save
                #p @team.errors.first if @team.errors.size > 0
              end
            end
          end
        end
      end
    end
  end
  desc "Parse Matches"
  task :matches => :environment do
    Team.all.each do |team|
      match_html = Nokogiri::HTML(open(PARSE_SITE_URL + team.url, :proxy => nil))
      if match_html
        match_html.css('table.borrsoft')[2].css('tr').each do |row|
          if row.css('td').size == 7
            row.css('td').each_with_index do |column, index|
              if column[:class] != 'loc1' #not the first row
                case index
                  when 0
                    column.css('a').first[:href].match(/league=(.*)/)
                    league = League.find_by_url_param $1
                    if league
                      @match_result = MatchResult.new :league => league
                    else
                      break
                    end
                  when 1
                    played_at = Date.parse(column.text) rescue nil
                    if played_at
                      @match_result.played_at = played_at
                    else
                      break
                    end
                  when 2
                    @match_result.home_team = Team.find_by_name(column.text.strip) rescue nil
                  when 3
                    @match_result.away_team = Team.find_by_name(column.text.strip) rescue nil
                  when 4
                    @match_result.full_time_result = column.text.strip
                    result = column.text.split('-')
                    result[0] = result[0].to_i
                    result[1] = result[1].to_i
                    if result[0] > result[1]
                      @match_result.status = 1
                    elsif result[0] < result[1]
                      @match_result.status = 2
                    else
                      @match_result.status = 0
                    end
                  when 5
                    column.text.match /\( (.*) \)/
                    @match_result.half_time_result = $1.strip
                  when 6
                    @match_result.additional = column.text.strip
                end
              end
              if @match_result
                @match_result.save
                #p @match_result.errors.first if @match_result.errors.size > 0
              end
            end
          end
        end
      end
    end
  end
end
