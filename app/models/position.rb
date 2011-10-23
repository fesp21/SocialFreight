class Position
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :reference
  field :operation
  field :direction
  field :paid_at
  belongs_to :patron
  field :patron_token
  belongs_to :branch
  field :master_reference
  field :master_type
  field :master_date
  belongs_to :transporter, :class_name => "Company", :inverse_of => :transporter_positions
  belongs_to :forwarder, :class_name => "Company", :inverse_of => :forwarder_positions
  belongs_to :agent, :class_name => "Company", :inverse_of => :agent_positions
  field :voyage
  field :vessel
  field :driver
  field :vessel2
  field :driver2
  belongs_to :load_place, :class_name => "Place", :inverse_of => :load_place
  field :load_date, type: Date
  belongs_to :unload_place, :class_name => "Place", :inverse_of => :unload_place
  field :unload_date, type: Date
  field :freight_price, type: Float, default: 0;
  field :freight_curr
  field :agent_price, type: Float, default: 0;
  field :agent_curr
  field :opsiyon_date, type: Date
  field :opsiyon_wg, type: Float, default: 0;
  field :status
  field :contract_no
  field :agent_reference
  field :other_reference
  field :description
  slug :reference

  has_many :loadings, dependent: :nullify
  #embeds_many :transfers
  #embeds_many :multimodals

  before_create :set_initials

  #attr_accessible 

  #validates_confirmation_of :password
  #validates_presence_of :reference, :on => :create
  validates_presence_of :operation #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :direction #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :patron #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :patron_token #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :branch #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  #validates_uniqueness_of :reference, :case_sensitive => false #burada patron_id değerine göre unique key olmalı
  #validates_presence_of :load_place #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  #validates_presence_of :unload_place #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :load_date #, :message => I18n.t('tasks.errors.name.cant_be_blank')
  validates_presence_of :unload_date #, :message => I18n.t('tasks.errors.name.cant_be_blank')

  private
  def set_initials
    self.reference = self.operation + "." + self.direction + ".015442"
    self.patron_token = current_patron.token if self.patron_token.blank?
  end

  class << self
    def direction_types()
      direction_types = {
        'E' => 'Export',
        'I' => 'Import',
        'T' => 'Transit'
      }
    end
  end

  class << self
    def payment_types()
      payment_types = {
        'PP' => 'PrePaid',
        'CC' => 'CustomCollect'
      }
    end
  end

  class << self
    def master_types()
      master_types = {
        'MO' => 'Master Only',
        'CO' => 'Consolidated'
      }
    end
  end

end
