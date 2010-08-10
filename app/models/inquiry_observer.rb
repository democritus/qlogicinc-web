class InquiryObserver < ActiveRecord::Observer
  def after_create(inquiry)
    # Only send if there is an email to send to
    unless inquiry[:recipient_email].blank?
      Mailer.deliver_web_form_inquiry(inquiry)
    end
  end
end
