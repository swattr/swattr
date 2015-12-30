require "rails_helper"

module Swattr
  RSpec.describe ApplicationHelper, type: :helper do
    context "locale attribute" do
      it "returns application locale" do
        expect(helper.locale).to eq("en")
      end
    end
  end
end
