require "rails_helper"

module Swattr
  RSpec.describe SettingPolicy, type: :policy do
    subject { SettingPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:setting) }

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
