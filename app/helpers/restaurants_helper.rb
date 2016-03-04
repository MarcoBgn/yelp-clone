module RestaurantsHelper
  
  def average_rating(restaurant)
    if @value 
    "\u2605" * @value[restaurant].to_i 
    else
      "N/A"
    end
  end
end
