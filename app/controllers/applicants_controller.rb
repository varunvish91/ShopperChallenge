class ApplicantsController < ApplicationController
  def new
  	@applicant = Applicant.new
		puts "new applicant"
	end

  def create
		@applicant = Applicant.new
		@applicant.first_name = params[:first_name]
		@applicant.last_name = params[:last_name]
		@applicant.phone = params[:phone_number]
		@applicant.phone_type = params[:phone_type]
		@applicant.email = params[:email]
		@applicant.region = params[:region]
		if @applicant.save
			render :status => 200
		else
			render :status => 400
		end
	end

  def update
    # your code here
  end

  def show
		puts "wazzzap"
	end
	
	def destroy
		head :ok
	end	
end
