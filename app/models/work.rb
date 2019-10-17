class Work < ApplicationRecord
  has_many :votes
  
  validates :title, presence: true
  validates :creator, presence: true
  
  def self.spotlight
    return nil if self.count == 0
    if self.count > 5
      popular_stuff = self.all.max_by(5) { |work| work.votes.count}
    else 
      popular_stuff = self.all.max_by(self.count / 2) { |work| work.votes.count}
    end 
    return popular_stuff.sort_by { |work| work.votes.last.created_at }.last
  end 
  
  def self.top_ten(media)
    return nil if self.count == 0
    category_subset = self.where(category: media)
    if category_subset.count > 20
      return category_subset.max_by(10) { |x| x.votes.count}
    else 
      return category_subset.max_by(category_subset.count / 2) { |x| x.votes.count}
    end 
  end 
  
  def self.category_desc_by_vote_count(media)
    return nil if self.count == 0
    category_subset = self.where(category: media)
    return category_subset.max_by(category_subset.length) { |work| work.votes.count }
  end 
end
