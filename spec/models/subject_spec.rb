RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = "defined"
end

RSpec.describe Subject, type: :model do
  context "has none to begin with" do
    it {expect(Subject.count).to eq 0}
  end

  context "has one after adding one" do
    before {FactoryGirl.create :subject}
    it {expect(Subject.count).to eq 1}
  end

  after(:all) {Subject.destroy_all}
  
  context "is valid with a name, description and day_work" do
    subject {FactoryGirl.create :subject}
    it {expect(subject).to be_valid}
  end
  
  context "is invalid without a name" do
    subject {FactoryGirl.build :invalid_name_subject}
    it {expect(subject).not_to be_valid}
  end

  context "is invalid without a description" do
    subject {FactoryGirl.build :invalid_description_subject}
    it {expect(subject).not_to be_valid}
  end

  context "association" do
    it {expect have_many :tasks}
    it {expect have_many :user_course_subjects}
    it {expect have_many(:user_courses).through :user_course_subjects}
    it {expect have_many :course_subjects}
    it {expect have_many(:courses).through :course_subjects}
  end
end
