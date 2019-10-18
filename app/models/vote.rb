class Vote < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :work, required: true
end
