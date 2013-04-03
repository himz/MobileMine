class NotifyUser < ActionMailer::Base
	default :from => "cmugivemea@gmail.com"
	
	def registration_confirmation(user)
		@user = user
		mail(:to => user.email, :subject => "Registered")
	end
end
