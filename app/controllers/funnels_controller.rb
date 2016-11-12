class FunnelsController < ApplicationController
  def index
    @funnel = {} # your code goes here
		start_date = DateTime.parse(params[:start_date].gsub!(/\s|"|'/, ''))
		end_date   = DateTime.parse(params[:end_date].gsub!(/\s|"|'/, ''))
		@buckets = Hash.new
		# Get the first bucket
		first_bucket = get_bucket(start_date)
		
		# Get the last bucket
		last_bucket = get_bucket(end_date)
		
		# Initial pull of first bucket entries
		@buckets[first_bucket] = get_entries_for_week(start_date.at_beginning_of_week, start_date.at_end_of_week)
		while first_bucket != last_bucket do
			# Increment our first_bucket
			start_date = start_date.next_week
			# Add the entries to the next bucket
			first_bucket = get_bucket(start_date)
			entries = get_entries_for_week(start_date.at_beginning_of_week, start_date.at_end_of_week)
			if entries.count != 0
				@buckets[first_bucket] = get_entries_for_week(start_date.at_beginning_of_week, start_date.at_end_of_week)
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
	# Returns the work flow data for the given week
	def get_entries_for_week(start_date, end_date)
		return Applicant.group(:workflow_state).where("DATE(created_at) >= ? AND DATE(created_at) <= ?", start_date, end_date).count
	end

	# Returns the bucket notation of the current date
	def get_bucket(date)
		return date.at_beginning_of_week.strftime("%Y-%m-%d") + "-" + date.at_end_of_week.strftime("%Y-%m-%d")
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
