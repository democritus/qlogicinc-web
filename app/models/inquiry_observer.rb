class InquiryObserver < ActiveRecord::Observer
  def after_create(inquiry)
    # Only send if there is an email to send to
    unless inquiry[:intended_recipient_email].blank?
      Mailer.deliver_web_form_inquiry(inquiry)
      # Update record's recipient fields upon successful delivery
      inquiry.recipient_email = inquiry[:intended_recipient_email]
      inquiry.recipient_name = inquiry[:intended_recipient_name]
      inquiry.save!
    end
  end
end
