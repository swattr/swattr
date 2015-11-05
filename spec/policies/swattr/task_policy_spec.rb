require "rails_helper"

module Swattr
  RSpec.describe TaskPolicy, type: :policy do
    subject { TaskPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:task) }

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
