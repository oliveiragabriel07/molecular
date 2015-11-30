Molecular::Campaign.class_eval do
  def recipients
    User.all
  end
end
