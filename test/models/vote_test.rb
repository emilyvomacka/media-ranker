require "test_helper"

describe Vote do
  let (:new_vote) {
    user_a = User.create!(username: "user_a")
    work_a = Work.create!(category: "album", title: "a", creator: "b", publication_year: "1990", description: "e")
    Vote.new(user: user_a, work: work_a)
  }

  it "can be instantiated" do 
    expect(new_vote.valid?).must_equal true
  end 

  it "will have the required fields" do
    vote = Vote.first
    [:user_id, :work_id].each do |field|
      expect(vote).must_respond_to field
    end 
  end 

  describe "relations" do
    before do 
      @vote = votes(:one)
    end 
    it "belongs to a user" do
      expect(@vote.user).must_be_instance_of User
    end

    it "belongs to a work" do
      expect(@vote.work).must_be_instance_of Work
    end 
  end 

  describe "validations" do
    before do 
      @work = Work.create(category: "album", title: "a", creator: "b", publication_year: "1990", description: "e")
      @user = User.create(username: "test")
      @vote = Vote.new(user: @user, work: @work)
    end 

    it "is valid when all fields are present" do
      expect(@vote.valid?).must_equal true
    end 
  end 
end
