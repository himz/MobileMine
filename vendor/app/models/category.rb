class Category < ActiveRecord::Base
  ##
  # The Category model has:
  # name : mandatory parameter
  # image_url which contains the image for the category.
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  # Each category has many item_categories
  ##
  attr_accessible :name, :image_url
  has_many :items, :through => :item_categories
  has_many :item_categories
  validates :name, :presence => true
end
