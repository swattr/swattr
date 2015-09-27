require "rails_helper"

module Swattr
  RSpec.describe UserPolicy, type: :policy do
    subject { UserPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:user) }

    context "for a visitor" do
      let(:user) { nil }

      it { should permit(:index) }
      it { should permit(:show) }

      it { should_not permit(:create) }
      it { should_not permit(:new) }
      it { should_not permit(:update) }
      it { should_not permit(:edit) }
      it { should_not permit(:destroy) }
    end

    context "for a user" do
      it { should permit(:index) }
      it { should permit(:show) }

      it { should_not permit(:create) }
      it { should_not permit(:new) }
      it { should_not permit(:update) }
      it { should_not permit(:edit) }
      it { should_not permit(:destroy) }
    end
  end
end
