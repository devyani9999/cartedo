require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "POST /create" do
    context "only admin can create a task" do
      user = User.new(name: "John Doe", email: "john@abc.com", role: 0)
      user.password = "hello123"
      user.save

      it "passes when admin creates a task" do
        let(:task_params) { { title: "abc", description: "alphabet", created_by: user } }

      end

      it "fails when mon-admin creates a task" do

      end
    end
  end
end
