class RenameUserIdForReservation < ActiveRecord::Migration
  def change
    rename_column :reservations, :user_id, :member_id
  end
end
