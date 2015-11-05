require "rails_helper"

module Swattr
  RSpec.describe AttachmentPolicy, type: :policy do
    subject { AttachmentPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:attachment) }

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
