class FileUploadsController < ApplicationController

  def index   
    @file_uploads = FileUpload.all
  end   

  def new   
    @file_upload = FileUpload.new   
  end

  def create
    @file_upload = FileUpload.new(file_upload_params)

    if @file_upload.save   
       redirect_to file_uploads_path, notice: "Successfully uploaded."   
    else   
       render "new"
    end
  end

  def destroy
    @file_upload = FileUpload.find(params[:id])
    @file_upload.destroy
    redirect_to file_uploads_path, notice:  "Successfully deleted."
  end

  def update
    @file_upload = FileUpload.find(params[:id])
    @file_upload.set_genders
    redirect_to file_uploads_path, notice:  "Successfully traversed: #{@file_upload.genders}"
  end

  private
  def file_upload_params
    params.require(:file_upload).permit(:name, :attachment)
  end

end