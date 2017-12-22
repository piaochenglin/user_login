class Owner < ApplicationRecord
  has_many :houses
  enum sex: [:女, :男]
  enum active: [:無効, :有効]
  scope :by_id, -> (id) {where('id = ?', id) unless id.blank?}
  scope :by_name, -> (name) {where('name = ?', name) unless name.blank?}
  scope :by_email, -> (email) {where('email = ?', email) unless email.blank?}
  scope :by_active, -> (active) {where('active = ?', active) unless active.blank?}
end
