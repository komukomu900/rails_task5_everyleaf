class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum priority:{low: 0, midium: 1, high: 2}
  scope :search, -> (search_params) do
    return if search_params.blank?
    get_by_title(search_params[:title])
      .get_by_state(search_params[:state])
  end
  scope :get_by_title, ->(title) {where("title like?","%#{title}%") if title.present? }
  scope :get_by_state, ->(state) {where(state: state) if state.present? }
  scope :label_is, -> (labels) { joins(:labels).where(labels: { id: labels }) if labels.present? }
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end