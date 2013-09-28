class ApplicationController < ActionController::Base
  protect_from_forgery

  # # custom 404
  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from ActiveRecord::RecordNotFound,
  #               ActionController::RoutingError,
  #               ActionController::UnknownController,
  #               ActionController::UnknownAction,
  #               ActionController::MethodNotAllowed do |exception|

  #     # Put loggers here, if desired.

  #     redirect_to :controller => :home, :action => :index
  #   end
  # end

end
