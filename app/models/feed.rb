class Feed < ActiveRecord::Base
  require 'uri_validator'
  attr_accessible :favicon, :feed_url, :last_updated, :latest_post_title, :name, :url, :user_id
  #validates_format_of :url, :with => URI::regexp(%w(http https)), :if => :can_validate? 
  validates :url, :presence => true, :allow_nil => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix } 

    def can_validate
      true
    end
  
  
  belongs_to :user

end


