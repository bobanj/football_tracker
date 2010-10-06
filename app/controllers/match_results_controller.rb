class MatchResultsController < ApplicationController
  # GET /match_results
  # GET /match_results.xml
  def index
    @match_results = MatchResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @match_results }
    end
  end

  # GET /match_results/1
  # GET /match_results/1.xml
  def show
    @match_result = MatchResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match_result }
    end
  end

  # GET /match_results/new
  # GET /match_results/new.xml
  def new
    @match_result = MatchResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match_result }
    end
  end

  # GET /match_results/1/edit
  def edit
    @match_result = MatchResult.find(params[:id])
  end

  # POST /match_results
  # POST /match_results.xml
  def create
    @match_result = MatchResult.new(params[:match_result])

    respond_to do |format|
      if @match_result.save
        format.html { redirect_to(@match_result, :notice => 'MatchResult was successfully created.') }
        format.xml  { render :xml => @match_result, :status => :created, :location => @match_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /match_results/1
  # PUT /match_results/1.xml
  def update
    @match_result = MatchResult.find(params[:id])

    respond_to do |format|
      if @match_result.update_attributes(params[:match_result])
        format.html { redirect_to(@match_result, :notice => 'MatchResult was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /match_results/1
  # DELETE /match_results/1.xml
  def destroy
    @match_result = MatchResult.find(params[:id])
    @match_result.destroy

    respond_to do |format|
      format.html { redirect_to(match_results_url) }
      format.xml  { head :ok }
    end
  end
end
