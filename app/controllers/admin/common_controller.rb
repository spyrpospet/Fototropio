class Admin::CommonController < ApplicationController
  layout :layout_by_resource

  before_action :authenticate_admin!

  private

  def current_admin
    @current_admin ||= current_admin
  end

  def layout_by_resource
    if turbo_frame_request?
      false
    else
      "admin/application"
    end
  end
end
