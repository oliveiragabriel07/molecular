Molecular::Campaign.class_eval do
  def recipients
    fail NotImplementedError, "Campaign must implement recipients method"
  end
end
