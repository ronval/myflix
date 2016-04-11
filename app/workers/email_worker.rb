class EmailWorker 
  include Sidekiq::Worker

  def perform(object_id)
    
    user = User.find(object_id)
    AppMailer.send_welcome_email(user).deliver
  end
end 