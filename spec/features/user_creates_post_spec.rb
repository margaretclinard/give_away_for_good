feature "user creates post" do
  # As a user
  # In order to share the non-profit's needs with the community
  # I want to publish a post

  # Acceptance Criteria:
  # * Post must have company info, category, date posted, deadline date, description, drop off location
  # * Post must be publicly visible once saved

  scenario "logged out users can't create posts" do
    visit root_path
    page.should_not have_content("Add Need")
    visit new_post_path
    should_be_denied_access
  end

  scenario "happy path" do
    me = Fabricate(:user, name: "Bob", company: "Nashville Software School")
    signin_as me
    click_on "Add Need"
    fill_in "Category", with: "Canned Goods"
    fill_in "Description", with: "This is the description."
    # Need to work on dates within form
    # fill_in "Date Posted", with: "June 16, 2015"
    # fill_in "Deadline", with: "September 30, 2015"
    click_on "Publish Need"
    page.should have_notice("Your need has been published.")
    current_path.should == user_posts_path(me)
    page.should have_link "Canned Goods"
    click_on "Canned Goods"
    # page.should have_css(".date", text: "June 16, 2015")
    page.should have_css(".company", text: "Nashville Software School")
    save_and_open_page
  end

  scenario "sad path" do
    me = Fabricate(:user, name: "Bob", company: "Nashville Software School")
    signin_as me
    click_on "Add Need"
    fill_in "Category", with: ""
    # Need to work on dates within form
    # fill_in "Date Posted", with: ""
    # fill_in "Deadline", with: "September 30, 2015"
    click_on "Publish Need"
    page.should have_alert("Your need could not be published. Please correct the errors below.")
    page.should have_error("can't be blank", on: "Category")
    # page.should have_error("can't be blank", on: "Date Posted")
  end
end