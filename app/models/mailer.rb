class Mailer < ActionMailer::Base

  helper :inquiries
    
  def subject_of_email(inquiry)
    unless inquiry[:subject].blank?
      subject = inquiry[:subject]
    else
      subject = 'General inquiry from web form'
    end
  end
  
  def reply_to_header(inquiry)
    if inquiry[:email]
      header = ''
      if inquiry[:name]
        header += inquiry[:name] + ' '
      end
      header += '<' + inquiry[:email] + '>'
    else
      header = nil
    end
  end
  
  def recipient_header(inquiry)
    header = ''
    unless inquiry[:recipient_email].blank?
      if inquiry[:recipient_name]
        header += inquiry[:recipient_name] + ' '
      end
      header += '<' + inquiry[:recipient_email] + '>'
    else
      header = nil
    end
  end
  
  def bcc_header
    nil
  end
  
  def from_header
    'User Services <noreply@' + DOMAIN + '>'
  end
  
  def web_form_inquiry(inquiry)
    recipients  recipient_header(inquiry)
    if bcc_header
      bcc       bcc_header
    end
    from        from_header
    subject     subject_of_email(inquiry)
    if reply_to_header(inquiry)
      reply_to    reply_to_header(inquiry) # Sender's name and email
    end
    body        :inquiry => inquiry
  end
end
