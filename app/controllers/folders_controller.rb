class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]
   

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])
    @folders = @folder.children
    @current_folder= Folder.find(params[:id])
    @documents = Document.where(:folder_id => Folder.find(params[:id]))
  end

  # GET /folders/new
  def new
    @folder = Folder.new
    if params[:folder_id]
      @current_folder = Folder.find(params[:folder_id])
      @folder.parent_id = @current_folder.id
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
       flash[:notice] = "Folder was successfully created."
        #format.json { render :show, status: :created, location: @folder }
        
        if @folder.parent
          redirect_to folder_path(@folder.parent_id)
        else
          redirect_to @folder
        end
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
    end
  end 

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder = current_user.folders.find(params[:id])
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = Folder.find(params[:id])
    respond_to do |format|
      format.html { redirect_to folders_url, notice: 'Folder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def browse
    @current_folder = Folder.find(params[:folder_id])
    
    if @current_folder
      
      @folders = @current_folder.children
      
      @documents = @current_folder.all
      
      render :action => "index"
      
    else
      flash[:error] = "Folder does not exist"
      redirect_to root_url 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
