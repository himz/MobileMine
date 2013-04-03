class Item < ActiveRecord::Base
  ##
  # The item model has details of an item including:
  #
  # name: Mandatory parameter
  # description: Description, Mandatory parameter
  # image_url: Image of the item, Mandatory parameter
  # availability: Number of items in stock, Mandatory parameter.
  # price: Price of item in dollars, Mandatory parameter
  # manufacturer: Name of the manufacturer, Mandatory parameter
  # sold_count: Number of items sold to date. Defaults to 0, Mandatory parameter
  # featured: Featured products have this set to true. Defaults to false, Mandatory parameter
  # auction_flag: Whether an item is an auction
  # auction_id: Foreign key to auction
  # activates: boolean to indicate status of item
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  # Each item has many item_categories
  ##
  attr_accessible :availability, :description, :image_url, :name, :price,
                  :manufacturer, :sold_count, :featured, :user_id, :auction_flag, :auction_id, :activated

  has_many :categories, :through => :item_categories
  has_many :item_categories
  has_many :line_items
  has_many :users
  belongs_to :user

  validates :availability, :presence => true
  validates :description, :presence => true
  validates :image_url, :presence => true
  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true
  validates :manufacturer, :presence => true
  validates :sold_count, :presence => true, :numericality => { :only_integer => true }
  validates :featured, :inclusion => { :in => [true, false] }
  validates :user_id, :presence => true

  ## Validate presence of fields in the form
  def validate
    if self.description.nil? || self.description.blank?
      "Please enter the description"
    elsif self.image_url.nil? || self.image_url.blank?
      "Please enter the image_url"
    elsif self.name.nil? || self.name.blank?
      "Please enter the name"
    elsif self.manufacturer.nil? || self.manufacturer.blank?
      "Please enter the manufacturer"
    elsif self.price.nil? || self.price.blank? || self.price.to_f <= 0
      "Please enter the correct price"
    else
      nil
    end
  end

end
