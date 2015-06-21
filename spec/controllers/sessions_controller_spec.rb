require 'rails_helper'

describe SessionsController do

  describe "authorization" do    
    let(:user) { FactoryGirl.create(:user, :email_confirmed) }
    let(:create_params) { Hash[ email: '', password: '' ] }
    before { bypass_rescue }

    context "when user is not signed in" do
      it "permits GET to #new" do
        expect { get :new }.to be_permitted
      end

      it "permits POST to #create" do
        expect { post :create, create_params }.to be_permitted
      end

      it "forbids DELETE to #destroy" do
        expect { delete :destroy }.to_not be_permitted
      end
    end

    context "when user is signed in" do
      before { sign_in_as(user, no_capybara: true) }

      it "forbids GET to #new" do
        expect { get :new }.to_not be_permitted
      end

      it "forbids POST to #create" do
        expect { post :create, create_params }.to_not be_permitted
      end

      it "permits DELETE to #destroy" do
        expect { delete :destroy }.to be_permitted
      end
    end
  end
end