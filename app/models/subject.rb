class Subject < ActiveRecord::Base
  include InitActivity
  has_many :tasks, dependent: :destroy
  has_many :user_course_subjects, dependent: :destroy
  has_many :user_courses, through: :user_course_subjects
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects

  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank?}

  validates :name, presence: true
  validates :description, presence: true  

  def admin_update_subject_activity user
    create_activity user.id, self.id, 
      Settings.activities.admin_update_subject
  end
end
