require 'spec_helper'

module Refinery
  module BackLinks
    describe BackLink do
      describe "validations" do
        subject do
          FactoryGirl.create(:back_link,
          :old_link => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }

        its(:old_link) { should == "Refinery CMS" }

      end
    end
  end
end
