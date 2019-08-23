class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    @images.each do |image|
        image.file.purge
    end
    Image.destroy_all
    []
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
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

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
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
