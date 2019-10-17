require "test_helper"

describe User do
  describe "relations" do 
    it "has many votes" do 
      user_a = users(:a)
      expect(user_a.votes.count).must_equal 3
      expect(user_a.votes.first).must_be_instance_of Vote
      expect(user_a.votes.last).must_be_instance_of Vote
    end 
    
    it "can register additional votes" do 
      user = users(:a)
      new_vote = Vote.create(work: works(:okc), user: users(:a))
      expect(user.votes.count).must_equal 4
      expect(user.votes).must_include new_vote
    end 
  end 
  
  describe "validations" do
    before do 
      @user = User.new(username: "test_user")
    end 
    #validations: all passing
    it "is valid when all fields are present" do
      expect(@user.valid?).must_equal true
    end 
    #validations: each missing
    it 'is invalid without a username' do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end 
  end 
end
