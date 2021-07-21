module SessionsHelper
  def display_flash(key)
    content_tag :p, flash[:alert], class: 'flash alert' unless flash[key].nil?
  end
end
