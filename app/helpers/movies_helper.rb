module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def style_for sort_param
    params[:sort] == sort_param ? 'hilite' : ''
  end
end
