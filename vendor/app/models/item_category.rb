class ItemCategory < ActiveRecord::Base
  ##
  # The item_category model belongs to category and item:
  #
  # It is used to many to many mapping between item and category
  #
  # category_id: ID of the category
  # item_id: ID of the item
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  ##
  belongs_to :category
  belongs_to :item

  attr_accessible :category_id, :item_id

  validates :category_id, :presence => true, :numericality => { :only_integer => true }
  validates :item_id, :presence => true, :numericality => { :only_integer => true }
end
