class Work < ApplicationRecord
  validates :title, presence: true
  validates :creator, presence: true


  def self.spotlight
    return self.all.sample
  end 

  def votes
    return rand(1..10)
  end 

  def self.top_ten(media)
    category_subset = self.where(category: "#{media}")
    if category_subset.count > 20
      return category_subset.sample(10)
    else 
      half = category_subset.count / 2
      return category_subset.sample(half)
    end 
  end 
end
