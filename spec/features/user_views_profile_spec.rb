feature "User views profile" do
  let(:jerry){ Fabricate(:user, name: "Jerry", company: "NSS") }

  scenario "viewing profile when not signed in" do
    visit root_path
    page.should_not have_link("NSS")
  end

  scenario "viewing profile when signed in" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: jerry.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("NSS")
    click_on "NSS"
    current_path.should == user_path(jerry)
    page.should have_content("NSS's Profile")
    page.should have_content(jerry.street1)
    page.should have_content(jerry.street2)
    page.should have_content(jerry.city)
    page.should have_content(jerry.state)
    page.should have_content(jerry.zip)
    page.should have_content(jerry.name)
    page.should have_content(jerry.email)
    page.should have_link("Edit")
  end
end