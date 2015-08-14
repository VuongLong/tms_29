RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = "defined"
end

RSpec.describe Subject, "subject management" do
  feature "subject index" do
    let!(:subject1) {FactoryGirl.create :subject}
    let!(:subject2) {FactoryGirl.create :subject}
    let!(:subject3) {FactoryGirl.create :subject}
    let!(:admin) {FactoryGirl.create :admin}

    before do
      visit "users/sign_in"      
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Login"
    end

    scenario "User see all subject" do
      click_link "Subjects"

      expect(page).to have_content subject1.name
      expect(page).to have_link "Delete"
      expect(page).to have_link "Edit"
    end

    scenario "User can see subject details" do
      visit "admin/subjects/#{subject2.id}"

      expect(page).to have_content subject2.name 
      expect(page).to have_content subject2.description
    end

    scenario "redner edit subject" do
      click_link "Subjects"
      within("tr#subject-#{subject3.id}") do
        click_link("Edit")
      end

      expect(page).to have_content subject3.name
    end
  end
  after(:all) {Subject.destroy_all}
end
