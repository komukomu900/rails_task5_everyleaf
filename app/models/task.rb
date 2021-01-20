class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  enum priority:{low: 0, midium: 1, high: 2}
  scope :search, -> (search_params) do
    return if search_params.blank?
    get_by_name(search_params[:name])
      .get_by_state(search_params[:state])
  end
  scope :get_by_name, ->(name) {where("name like?","%#{name}%")}
  scope :get_by_state, ->(state) {where(state: state)}
end