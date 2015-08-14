RSpec.describe Admin::SubjectsController, type: :controller do
  let!(:admin) {FactoryGirl.create :admin}
  let!(:subject1) {FactoryGirl.create :subject}
  let!(:subject2) {FactoryGirl.create :subject}

  before {sign_in admin}

  describe "#index" do
    before {get :index}
    context "Get index successfully" do
      it {expect(response).to be_success}
      it {expect(assigns :subjects).to match_array([subject1, subject2])}
      it {expect(response).to render_template :index}
      it {expect(response).to have_http_status :ok}
    end
  end

  describe "#show" do
    before {get :show, id: subject1}
    context "Get show successfully" do
      it {expect(response).to be_success}
      it {expect(response).to render_template :show}
      it {expect(response).to have_http_status :ok}
    end
  end

  describe "#create" do
    context "Create with valid attributes" do
      before {post :create, subject: FactoryGirl.attributes_for(:subject)}
      it {expect(Subject.count).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
      it {expect(flash[:success]).to eq "Create successfully"}
    end

    context "Create with invalid attributes with name blank" do
      before {post :create, subject: FactoryGirl.attributes_for(:invalid_name_subject)}
      it {expect(Subject.count).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
      it {expect(flash[:failed]).to eq "Can't create"}
    end

    context "Create with invalid attributes with description blank" do
      before {post :create, subject: FactoryGirl.attributes_for(:invalid_description_subject)}
      it {expect(Subject.count).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
      it {expect(flash[:failed]).to eq "Can't create"}
    end
  end

  describe "#edit" do
    before {get :edit, id: subject1}
    context "Get edit successfully" do
      it {expect(response).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
    end
  end

  describe "#update" do
    context "Update with valid attributes" do
      before {patch :update, id: subject1, subject: FactoryGirl.attributes_for(:subject)}
      it {expect(response).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
    end

    context "Update with invalid attributes with description blank" do
      before {post :create, id: subject1, subject: FactoryGirl.attributes_for(:invalid_description_subject)}
      it {expect(response).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
    end
  end

  describe "#destroy" do
    before {delete :destroy, id: subject1}
    context "Delete successfully" do
      it {expect(response).to redirect_to admin_subjects_path}
      it {expect(response).to have_http_status :found}
    end
  end
end
