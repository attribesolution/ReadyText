module MessagesHelper
  def sample_marketing_template
    text = <<-TEXT
Hello,
We are offering a deal at #{current_user.restaurant.name}.Offer is valid for limited time.So come earlier & Enjoy!
    TEXT
  end
end
