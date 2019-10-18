require "test_helper"

describe Work do
  let (:new_work) { 
    Work.new(title: "AMSP", creator: "Radiohead", publication_year: "2016")
  }
  
  it "can be instantiated" do 
    expect(new_work.valid?).must_equal true
  end 
  
  it "will have the required fields" do
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end 
  end 

  describe "relationships" do 
    it "can have many votes" do 
      work = works(:okc)
      expect(work.votes.count).must_equal 2
      expect(work.votes.first).must_be_instance_of Vote
      expect(work.votes.last).must_be_instance_of Vote
    end 
    
    it "can register additional votes" do 
      work = works(:okc)
      new_vote = Vote.create(work: works(:okc), user: users(:a))
      expect(work.votes.count).must_equal 3
      expect(work.votes).must_include new_vote
    end 
  end 
  
  describe "validations" do
    before do 
      @work = Work.new(category: "album", title: "a", creator: "b", publication_year: "1990", description: "e")
    end 
    
    it "is valid when all fields are present" do
      expect(@work.valid?).must_equal true
    end 
    
    it 'is invalid without a title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it 'is invalid without a creator' do
      @work.creator= nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
    end 
  end 
  
  describe "custom methods" do
    describe "top_ten" do
      before do
        @top_ten = Work.top_ten("album")
      end 
      it 'returns 10 items when the list of works is greater than 20' do
        25.times do 
          work = Work.create(category: "album", title: "a", creator: "b", publication_year: "1990", description: "e")
        end 
        expanded_pool_top_ten = Work.top_ten("album")
        expect(expanded_pool_top_ten.length).must_equal 10
      end 
      
      it 'returns a list of length Work.count / 2, when Work.count < 10' do
        expect(@top_ten.length).must_equal 2
      end 
      
      it 'returns a list ordered by vote count' do
        assert_operator @top_ten.first.votes.count, :>, @top_ten.last.votes.count
      end 

      it 'returns works with a tied number of votes in alphabetical order by title' do
        puts @top_ten
        assert_operator @top_ten[1].title, :>, @top_ten[2].title
      end
    end
  end 

  describe 'category_desc_by_vote_count' do
    before do
      @best_albums = Work.category_desc_by_vote_count("album") 
    end 
    it 'returns a list of all works in a given category ordered by vote count' do
      expect(@best_albums.length).must_equal 4
      expect(@best_albums[0].title).must_equal "OK Computer"
      expect(@best_albums[-1].title).must_equal "Amnesiac"
    end 

    it 'orders by vote count, and breaks ties by alphabetizing by title' do
      expect(@best_albums[1].title).must_equal "Hail To The Thief"
      expect(@best_albums[2].title).must_equal "Kid A"
    end 

    it 'also includes titles with zero votes' do
      expect(@best_albums[-1].votes.count).must_equal 0
    end  
  end 
  
  # describe "spotlight method" do 
  #   it 'returns a Work object' do
  #     spotlight = Work.spotlight
  #     expect(spotlight).must_be_instance_of Work
  #   end
  
  #   it 'returns the most recently upvoted work in the subset of works with the most votes' do
  #     expect(Work.spotlight).must_equal works(:httt)
  # end 

end 