class DocumentsController < ApplicationController

  before_filter :require_login
  respond_to :html, :js, :json

  def index
    @documents = current_patron.documents.all
    respond_with @documents
  end

  def show
    @document = current_patron.documents.find(params[:id])
    respond_with @document
  end

  def new
    @documented = find_documented
    @document = @documented.documents.build()
    @document.owner_reference = @documented.to_s
    @document.operation = @documented.operation if @documented.respond_to?("operation")
    respond_with @document
  end

  def edit
    @document = current_patron.documents.find(params[:id])
    respond_with @document
  end

  def create
    #@documented = find_documented
    #@document = @documented.documents.build(params[:document])
    @document = current_patron.documents.build(params[:document])
    @document.user_id  = current_user.id
    #@document.patron_id  = current_patron.id
   
    @document.save!
    respond_with @document, :success => "Document saved successfully"
  end

  def update
    @document = current_patron.documents.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def find_documented
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end