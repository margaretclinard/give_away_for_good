feature "User edits profile" do

  let(:joe){ Fabricate(:user, name: "Joe", company: "NSS") }
  let(:john){ Fabricate(:user, name: "John", company: "BBBS") }

  scenario "logged out user can't edit profile" do
    visit user_path(joe)
    page.should_not have_link("Edit")
  end

  scenario "different user can't edit profile" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: joe.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    visit user_path(john)
    page.should_not have_link("Edit")
  end

  scenario "happy path user edits profile" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: joe.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    click_on "NSS"
    click_on "Edit Profile"
    current_path.should == edit_user_path(joe)
    field_labeled("Name").value.should == "Joe"
    field_labeled("Bio").value.should == joe.bio
    field_labeled("Email").value.should == joe.email
    fill_in "Name", with: "Gerald"
    fill_in "Bio", with: "Edited description"
    fill_in "Email", with: "b@c.com"
    click_on "Save Changes"
    page.should have_content("NSS's profile has been updated.")
    page.should have_content("Gerald")
    page.should have_content("Edited description")
    page.should have_content("b@c.com")
    page.should have_link("Edit Profile")
  end

  scenario "sad path user edits profile" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: john.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    click_on "BBBS"
    click_on "Edit Profile"
    fill_in "Name", with: "Johnathan"
    fill_in "Bio", with: "Edited description"
    fill_in "Email", with: ""
    click_on "Save Changes"
    save_and_open_page
    page.should have_content("Please fix the errors below to continue.")
    field_labeled("Name").value.should == "Johnathan"
    field_labeled("Bio").value.should == "Edited description"
    field_labeled("Email").value.should == ""
    page.should have_css(".email .error", text: "can't be blank")
  end
end