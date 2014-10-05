require "spec_helper"

describe "Logging In" do
  it "logs the user in and goes to the todo lists" do
    User.create(name: "Alexander", email: "alexander@example.com", password: "password1", password_confirmation: "password1")
    visit "/"
    click_link "Sign In"
    fill_in "Email", with: "alexander@example.com"
    fill_in "Password", with: "password1"
    click_button "Sign In"
    
    expect(page).to have_content("Alexander")
    expect(page).to have_content("Signed in successfully.")
  end

  it "diplays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email", with: "alexander@example.com"
    fill_in "Password", with: "incorrect"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password.")
    expect(page).to have_field("Email", with: "alexander@example.com")
  end
end