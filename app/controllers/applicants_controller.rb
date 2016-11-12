class ApplicantsController < ApplicationController
  def new
  	@applicant = Applicant.new
		puts "new applicant"
	end

  def create
		@applicant = Applicant.new(post_params)
		if @applicant.save
			redirect_to(:back)
		else
			render 'new'	
		end
	end

  def update
    # your code here
  end

  def show
		puts "wazzzap"
	end
	
	def post_params
		params.require(:applicant).permit(:commit)
	end
end
