require 'spec_helper'

describe FriendshipController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'approve'" do
    it "returns http success" do
      get 'approve'
      response.should be_success
    end
  end

  describe "GET 'ignore'" do
    it "returns http success" do
      get 'ignore'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

end
