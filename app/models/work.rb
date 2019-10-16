class Work < ApplicationRecord

  def self.spotlight
    return self.all.sample
  end 

  def votes
    return rand(1..10)
  end 

  def self.top_ten(media)
    return Work.where(category: "#{media}").select(10)
  end 
end
