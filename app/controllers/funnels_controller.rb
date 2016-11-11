class FunnelsController < ApplicationController
  def index
    @funnel = {} # your code goes here
		start_date = params[:start_date].gsub!(/\s|"|'/, '')
		end_date   = params[:end_date].gsub!(/\s|"|'/, '')
		
		@entries = Applicant.where("DATE(created_at) >= ? AND DATE(created_at) <= ?", start_date, end_date)		
		@buckets = Hash.new
		@entries.each do |c|
			start_of_week = c.created_at.at_beginning_of_week.strftime("%Y-%m-%d")
			end_of_week   = c.created_at.at_end_of_week.strftime("%Y-%m-%d")
			key = start_of_week + "-" + end_of_week
			if @buckets.has_key?(key)
				@buckets[key]['applied'] += 1
				if !@buckets[key].has_key?(c.workflow_state)
					@buckets[key][c.workflow_state] = 1
				else
					@buckets[key][c.workflow_state] += 1
				end	
			else
				create_new_key(c, key)
			end
		end
		hash = @buckets.to_json
		@funnel = JSON.parse(hash)
		respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
	end

  private
	def create_new_key(applicant, key)
		@buckets[key] = Hash.new
		@buckets[key]['applied'] = 1;
		@buckets[key][applicant.workflow_state] = 1;
	end
  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end
end
