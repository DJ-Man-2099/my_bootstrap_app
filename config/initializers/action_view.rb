# config/initializers/action_view.rb
# Necessary for stopping default rails render behaviour on error
# and use bootstrap showing errors instead
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
