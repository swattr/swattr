require "rails_helper"

module Swattr
  RSpec.describe ProjectPolicy, type: :policy do
    subject { ProjectPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:project) }

    context "for a user" do
      it { should permit(:index) }
      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:new) }
      it { should permit(:update) }
      it { should permit(:edit) }
      it { should permit(:destroy) }
    end
  end
end
