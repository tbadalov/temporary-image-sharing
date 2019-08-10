class MainController < ApplicationController
    before_action :set_image

  def index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
        if session[:id]
            @image = Image.find_by(control_hash: session[:id])
            session.delete(:id)
        end
        @image ||= Image.new
    end
end
