#Finished hw2

class Movie < ActiveRecord::Base

  def self.ratings
    return self.find(:all, :order => "rating", :select => "rating", :conditions => "").map(&:rating).uniq
  end

  def self.getByRating(ratings, order)
    if ratings.length > 0
      condition = ""
      ratings.each do |rating|
        condition += "or rating = '#{rating}'"
      end
      
      condition = condition[3..condition.length-1]
      
      puts condition
      
      #return self.all
      return self.find(:all, :order => order, :conditions => condition)
    else
      #return self.find(:all, :order => "rating")
      return self.find(:all)
    end
  end
end
