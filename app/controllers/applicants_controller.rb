class ApplicantsController < ApplicationController
  def new
  	@applicant = Applicant.new
	end

  def create
		@applicant = Applicant.new(params[:applicant])
	end

  def update
    # your code here
  end

  def show
    # your code here
  end
end
