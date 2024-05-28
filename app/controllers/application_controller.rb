class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Pagy::DEFAULT[:items] = 5 # items per page
end
