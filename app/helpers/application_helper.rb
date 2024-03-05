module ApplicationHelper
  def learning_style_color(learning_style)
    case learning_style
    when 'visual'
      'blue'
    when 'aural'
      'red'
    when 'reading'
      'orange'
    when 'kinesthetic'
      'green'
    else
      'black' # Default color or any other fallback color
    end
  end
end
