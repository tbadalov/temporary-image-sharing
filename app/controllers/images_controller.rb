class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
          session[:id] = @image.control_hash
        format.html { redirect_to root_path(img: @image.control_hash), notice: 'Image was successfully created.' }
        #format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        #format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
        puts "Vallah called"
      @image = Image.find_by(control_hash: params[:control_hash])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
        image_params = params.require(:image)
        expires_at = DateTime.now.next_day 2
        image_params['expires_at'] = expires_at
        puts(image_params)
        image_params.permit(:expires_at, :file)
    end
end
