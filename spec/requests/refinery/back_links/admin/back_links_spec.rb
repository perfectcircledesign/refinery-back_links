# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "BackLinks" do
    describe "Admin" do
      describe "back_links" do
        login_refinery_user

        describe "back_links list" do
          before do
            FactoryGirl.create(:back_link, :old_link => "UniqueTitleOne")
            FactoryGirl.create(:back_link, :old_link => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.back_links_admin_back_links_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.back_links_admin_back_links_path

            click_link "Add New Back Link"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Old Link", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::BackLinks::BackLink.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Old Link can't be blank")
              Refinery::BackLinks::BackLink.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:back_link, :old_link => "UniqueTitle") }

            it "should fail" do
              visit refinery.back_links_admin_back_links_path

              click_link "Add New Back Link"

              fill_in "Old Link", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::BackLinks::BackLink.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:back_link, :old_link => "A old_link") }

          it "should succeed" do
            visit refinery.back_links_admin_back_links_path

            within ".actions" do
              click_link "Edit this back link"
            end

            fill_in "Old Link", :with => "A different old_link"
            click_button "Save"

            page.should have_content("'A different old_link' was successfully updated.")
            page.should have_no_content("A old_link")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:back_link, :old_link => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.back_links_admin_back_links_path

            click_link "Remove this back link forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::BackLinks::BackLink.count.should == 0
          end
        end

      end
    end
  end
end
