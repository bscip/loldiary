class Champion < ActiveRecord::Base
  attr_accessible :riot_id, :riot_key, :name, :redis_key
end
