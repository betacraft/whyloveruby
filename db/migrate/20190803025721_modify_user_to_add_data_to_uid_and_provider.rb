class ModifyUserToAddDataToUidAndProvider < ActiveRecord::Migration[5.2]
  def change
    provider = "twitter"
    User.find_each do |user|
      user.provider = provider
      user.uid = user.twitter_oauth.split('-')[0]
      user.save
    end
  end
end
