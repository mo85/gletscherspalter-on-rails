class AddMarcoKistler < ActiveRecord::Migration
  def self.up
    user = User.create(:login => "marco.kistler", :firstname => "marco", :lastname => "kistler", :is_player => true)
    user.password = "secret"
  end

  def self.down
    User.find_by_login("marco.kistler").delete
  end
end
