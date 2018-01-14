class Game < ApplicationRecord
  belongs_to :user, optional: true
  #  dependent?
  #  when a user deletes their account, do we want to delete the games or convert them to guest games?
end
