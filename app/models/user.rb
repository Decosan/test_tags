class User < ApplicationRecord
  enum gender: { unanswered: 0, male: 1, female: 2, other: 9 }

  belongs_to :prefecture
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag

  scope :search, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name])
      .gender_is(search_params[:gender])
      .birthday_from(search_params[:birthday_from])
      .birthday_to(search_params[:birthday_to])
      .prefecture_id_is(search_params[:prefecture_id])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :birthday_from, -> (from) { where('? <= birthday', from) if from.present? }
  scope :birthday_to, -> (to) { where('birthday <= ?', to) if to.present? }
  scope :prefecture_id_is, -> (prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present? }

end
