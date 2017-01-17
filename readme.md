
bundle install
rails generate refinery:back_links
rake db:migrate
rake db:seed
Please restart your rails server.


add to application controller

before_filter :back_links

def back_links
  back_link = Refinery::BackLinks::BackLink.where(:old_link => request.fullpath).first
  if back_link.present? and back_link.new_link.present?
    redirect_to "#{back_link.new_link}", :status => 301
  end
end