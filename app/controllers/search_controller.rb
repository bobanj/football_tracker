class SearchController < ApplicationController
  def index
    if SEARCH_TYPES.include?(params[:type])
        @result = case params[:type]
          when 'Team'
             Team.find :all, :conditions => ["name like ?","%#{params[:name]}%"]
          when 'League'
            League.find :all, :conditions => ["name like ?","%#{params[:name]}%"]
          when 'Result'
            MatchResult.find :all, :conditions => ["half_time_result = ? OR full_time_result = ?",params[:name],params[:name]]
          else
            []
        end
    else
      @result = []
    end
    @result = @result.paginate :page => params[:page], :per_page => RESULTS_PER_PAGE
  end
end
