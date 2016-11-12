class ApplicantsController < ApplicationController
  def new
  	@applicant = Applicant.new
		session[:id] = @applicant.id
	end

  def create
		@applicant = Applicant.new
		session[:id] = @applicant.id
		@applicant.first_name = params[:first_name]
		@applicant.last_name = params[:last_name]
		@applicant.phone = params[:phone_number]
		@applicant.phone_type = params[:phone_type]
		@applicant.email = params[:email]
		@applicant.region = params[:region]
		@applicant.workflow_state = 'applied'
		session[:first_name] = @applicant.first_name
		session[:last_name] = @applicant.last_name
		session[:phone] = @applicant.phone
		session[:phone_type] = @applicant.phone_type
		session[:email] = @applicant.email
		session[:region] = @applicant.region
		@applicant.save
	end

  def update
		Applicant.find(session[:id]).reload
	end

  def show
		puts Applicant.count
	end
	
end
