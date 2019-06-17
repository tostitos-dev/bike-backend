class Station < ApplicationRecord
  after_create :update_searchable_name
  belongs_to :company
  has_many :telemetries

  def update_searchable_name
    return special_searcheable_name unless raw_name.include?('-')

    clean_s = raw_name.split(' - ')
    clean_s.slice!(0)
    update name: clean_s.join(' - ')
  end

  def special_searcheable_name
    clean_s = raw_name.split(' ')
    clean_s.slice!(0)
    update name: clean_s.join(' ')
  end
end
