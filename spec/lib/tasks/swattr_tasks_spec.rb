require "rails_helper"

RSpec.describe "Swattr Rake task", type: :rake do
  include_context "rake"

  describe "swattr:version" do
    it "find current version" do
      expect { subject.execute }.to match_stdout Swattr::VERSION
    end
  end
end
