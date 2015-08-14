class Admin::SubjectsController < ApplicationController
  before_action :init_subject, only: [:show, :edit, :update, :destroy]
  
  def index
    @subject = Subject.new
    @subjects = Subject.all
    @q = Subject.ransack params[:q]
    @subjects = @q.result distinct: true
    @q.build_sort if @q.sorts.empty?
  end

  def show
    @tasks = @subject.tasks
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash.now[:success] = t "messages.admin.create.success"
    else
      flash.now[:failed] = t "messages.admin.create.fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
      format.js
    end
  end  

  def update
    if @subject.update_attributes subject_params
      @subject.admin_update_subject_activity current_user
      flash.now[:success] = t "messages.admin.update.success"
    else
      flash.now[:danger] = t "messages.admin.update.fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
      format.js
    end
  end

  def destroy
    if @subject.destroy
      flash.now[:success] = t "messages.admin.destroy.success"
    else
      flash.now[:failed] = t "messages.admin.destroy.fail"
    end
    respond_to do |format|
      format.html {redirect_to admin_subjects_path}
      format.js
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :_destroy]
  end

  def init_subject
    @subject = Subject.find params[:id]
  end
end
