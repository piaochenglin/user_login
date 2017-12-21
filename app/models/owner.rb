class Owner < ApplicationRecord
  scope :by_name, -> (name) {where('name = ?', name) unless name.blank?}
  scope :by_email, -> (email) {where('email = ?', email) unless email.blank?}
  scope :by_active, -> (active) {where('active = ?', active) unless active.blank?}
end
