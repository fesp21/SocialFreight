class Document < ActiveRecord::Base

  belongs_to :user
  belongs_to :patron
  belongs_to :documented, polymorphic: true

  mount_uploader :document_file, DocumentUploader

  attr_accessible :document_date, :document_no, :document_type, :operation, :page_number, :country_id, :city_id,
                  :operation, :documented_type, :documented_id, :owner_reference, :due_date, :status, :document_file, :description

  validates_presence_of :document_date
  validates_presence_of :document_type
  validates_presence_of :user_id
  validates_presence_of :patron_id
  
end
