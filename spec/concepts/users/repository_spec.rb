# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::Repository do
  describe ".offline_user" do
    let!(:fake_user) { create :fake_user }
    let(:instance) { described_class.new }

    it "returns fake user" do
      expect(instance.offline_user).to eq(fake_user)
    end
  end
end
