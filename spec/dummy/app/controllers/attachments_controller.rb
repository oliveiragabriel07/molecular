class AttachmentsController < ApplicationController
  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    respond_to do |format|
      if @attachment.save
        json = {url: Refile.attachment_url(@attachment, :file)}.to_json
        format.json { render json: json, status: :created }
      else
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def attachment_params
      params.require(:attachment).permit(:file)
    end
end
