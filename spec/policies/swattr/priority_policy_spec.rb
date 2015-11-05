require "rails_helper"

module Swattr
  RSpec.describe PriorityPolicy, type: :policy do
    subject { PriorityPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:priority) }

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
