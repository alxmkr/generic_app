require 'rails_helper'

describe PasswordReset do
  let(:email)    { 'first.last@example.com' }
  let(:password) { nil }
  before { password_reset.skip_password_validation = true }
  
  subject(:password_reset) { PasswordReset.new(
    email: email,
    password: password,
    password_confirmation: password) }

  [ :email,
    :password,
    :password_confirmation,
    :skip_password_validation,
    :skip_password_validation?,
  ].each do |method|
    it { is_expected.to respond_to method }
  end

  describe "with email that" do
    context "is blank" do
      let(:email) { ' ' }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end

    context "is too long" do
      let(:email) { "#{'a' * 39}@example.com" }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end

    context "is of invalid format" do
      let(:addresses) { %w[
        .starts-with-dot@example.com double..dot@test.org
        double.dot@test..org no_at_sign.net double@at@sign.com
        without@dot,com ends+with@dot. ] }
      
      specify "is invalid and has 1 error" do
        addresses.each do |invalid_address|
          password_reset.email = invalid_address
          expect(password_reset).to be_invalid
          expect(password_reset.errors.count).to eq(1)
        end
      end
    end

    context "is of valid format" do
      let(:addresses) { %w[
        password_reset@example.com first.last@somewhere.COM
        fir5t_la5t@somewhe.re FIRST+LAST@s.omwhe.re ] }
      
      specify "is valid" do
        addresses.each do |valid_address|
          password_reset.email = valid_address
          expect(password_reset).to be_valid
        end
      end
    end
  end

  describe "with password that" do
    before { password_reset.skip_password_validation = false }

    context "is blank" do
      let(:password) { ' ' }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end

    context "is too short" do
      let(:password) { 'a' * 5 }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end

    context "is too long" do
      let(:password) { 'a' * 31 }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end

    context "does not match confirmation" do
      let(:password) { 'qwerty123'}
      before { password_reset.password = 'mismatch' }

      specify "is invalid and has 1 error" do
        expect(password_reset).to be_invalid
        expect(password_reset.errors.count).to eq(1)
      end
    end
  end
end