class Tag < ActiveRecord::Base
  belongs_to :entries
  belongs_to :users

  def tags
    self.body.scan(/#(\w+)/).flatten
  end


end