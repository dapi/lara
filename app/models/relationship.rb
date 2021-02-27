class Relationship < ApplicationRecord
  belongs_to :parent, class_name: 'User'
  belongs_to :children, class_name: 'User'
end
