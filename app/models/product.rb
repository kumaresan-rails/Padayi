class Product < ActiveRecord::Base
	
	has_many :line_items
        has_many :orders, :through => :line_items


	before_destroy :ensure_not_referenced_by_any_line_item

	def ensure_not_referenced_by_any_line_item
		if line_items.count.zero?
			return true
		else
			errors[:base] << "Line Items present"
		return false
		end
	end

	 

   
	def self.find_products_for_sale
         find(:all, :order => "title" )
        end

	validates_presence_of :title, :description, :image_url
	validates_numericality_of :price

	validate :price_must_be_at_least_a_ten
     	protected
		def price_must_be_at_least_a_ten
		errors.add(:price, 'should be at least 10.0') if price.nil? || price <10.0
         end

         validates_uniqueness_of :title
	 validates_format_of :image_url, :with => %r{\.(gif|jpg|png|mp3)}i, :message => 'must be a URL for GIF, JPG' + 'or PNG image.'


	def self.search(search, page)
  		paginate :per_page => 3, :page => page,
           		:conditions => ['name like ?', "%#{search}%"],
           		:order => 'name'
	end
	def self.search(search)
          
  		if search
    			where('title LIKE ?', "%#{search}%")
  		else
    			scoped
  		end
  	end

end
