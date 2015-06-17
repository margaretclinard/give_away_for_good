feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy Path" do
    page.should_not have_link("Sign Up")
    fill_in "Name", with: "Joe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    fill_in "Company", with: "Nashville Software School"
    fill_in "Bio", with: Faker::Lorem.paragraph
    fill_in "Street1", with: "123 Plus Park Blvd"
    fill_in "Street2", with: "Suite 1"
    fill_in "City", with: "Nashville"
    fill_in "State", with: "Tennessee"
    fill_in "Zip", with: "37209"
    click_button "Sign Up"
    page.should have_content("Welcome, Joe")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Welcome back, Joe")
  end

  scenario "Error Path" do
    fill_in "Name", with: ""
    fill_in "Email", with: "joeexample.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "food"
    fill_in "Company", with: "Nashville Software School"
    fill_in "Bio", with: Faker::Lorem.paragraph
    fill_in "Street1", with: "123 Plus Park Blvd"
    fill_in "Street2", with: "Suite 1"
    fill_in "City", with: "Nashville"
    fill_in "State", with: "Tennessee"
    fill_in "Zip", with: "37209"
    click_on "Sign Up"
    page.should have_css(".alert", text: "Please fix the errors below to continue.")

    page.should have_css(".user_name .error", text: "can't be blank")
    page.should have_css(".user_email .error", text: "must be an email address")
    page.should have_css(".user_password_confirmation .error", text: "doesn't match Password")


    fill_in "Name", with: "Sally"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"
    click_on "Sign Up"
    page.should have_content("Welcome, Sally")
  end
end