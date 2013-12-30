require 'spec_helper'

describe ProjectsController do
	let(:user) { FactoryGirl.create(:user)}
	before do
			sign_in(user)
	end
	
	it "displays an error for a missing project" do
		get :show, id: "not-here"
		expect(response).to redirect_to(projects_path)
		message = "The project you were looking for could not be found."
		expect(flash[:alert]).to eql(message)
	end

	

	context "standard users" do
		

		it "cannot access the new action" do
			get :new

			expect(response).to redirect_to('/')
			expect(flash[:alert]).to eql("You must be an admin to do that.")
    end

    it "cannot access the show action without permission" do
		  project = FactoryGirl.create(:project)
		  get :show, id: project.id
		  expect(response).to redirect_to(projects_path)
		  expect(flash[:alert]).to eql("The project you were looking " +
		  	"for could not be found.")
		end
	end

	{ new: :get,
	  create: :post, 
	  edit: :get, 
	  update: :put, 
	  destroy: :delete }.each do |action, method|
	  it "cannot access the #{action} action" do
	  	sign_in(user)
	  	send(method, action, :id => FactoryGirl.create(:project))
	  	expect(response).to redirect_to(root_path)
	  	expect(flash[:alert]).to eql("You must be an admin to do that.")
	  end
  end


end
