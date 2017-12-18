require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  
  test "make sure the login page has the text" do
    visit "/session/new"
    
    assert_selector "h1", text: "Log in"
  end
  
  test "make sure a valid user can log in" do
    visit new_session_path
    
    fill_in "Username", with: "riklomas"
    fill_in "Password", with: "password123"
    
    click_button "Log in"
    
    assert_equal page.current_path, items_path    
    assert_selector "div.success", text: "You are now logged in!"
  end
  
  test "make sure we say it isn't logged in" do
    visit new_session_path
    
    fill_in "Username", with: "badusername"
    fill_in "Password", with: "badpassword"
    
    click_button "Log in"
    
    assert_equal page.current_path, session_path
    assert_selector "div.error", text: "Bad login"
  end
  
end
