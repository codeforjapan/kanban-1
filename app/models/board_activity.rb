# == Schema Information
#
# Table name: board_activities
#
#  id          :integer          not null, primary key
#  member_id   :integer          not null
#  board_id    :integer          not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BoardActivity < ActiveRecord::Base
  attr_accessible :board_id, :description, :member_id
end