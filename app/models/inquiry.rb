class Inquiry < ActiveRecord::Base
  
  attr_accessible :recipient_name, :recipient_email, :name, :email, :phone,
    :message, :subject
  
  # Pseudo field to hold subject and intended recipient of email since these
  # values are not saved to the database
  attr_accessor :subject
  attr_accessor :intended_recipient_email
  attr_accessor :intended_recipient_name
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :message
  validates_format_of :email,
    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :allow_blank => true
  
  before_save :set_intended_recipient
  
  
  private
  
  # Don't save email recipient since email hasn't been sent yet, but remember
  # the intended recipient so that it can be saved later upon succesful
  # delivery
  def set_intended_recipient
    write_attribute(:intended_recipient_name, COMPANY_NAME)
    write_attribute(:intended_recipient_email, INQUIRY_EMAIL)
  end
end
