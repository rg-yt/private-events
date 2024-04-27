class CreateAttendance < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.timestamps
    end
    add_reference :attendances, :user
    add_reference :attendances, :event
  end
end
