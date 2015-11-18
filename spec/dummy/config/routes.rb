Rails.application.routes.draw do
  mount_molecular campaigns: 'custom_molecular/campaigns'
end
