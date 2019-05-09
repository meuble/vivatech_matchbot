class Datum < ApplicationRecord
  SKIN_TYPES = %w(pale brown dark yellow green)
  COLORS = %w(red purple blue)
  SCENTS = %w(rose lila)
  AGE_GROUPS = %w(0_15 16_30 31_45 46_60 60+)
  BRANDS = %w(Sephora Marionaud Monoprix YvesRocher)
  
  validates :skin_type, inclusion: { in: SKIN_TYPES,
    message: "%{value} is not a valid skin type" }
  validates :prefered_color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :prefered_scent, inclusion: { in: SCENTS,
    message: "%{value} is not a valid scent" }
  validates :age_group, inclusion: { in: AGE_GROUPS,
    message: "%{value} is not a valid age group" }
  validates :prefered_brand, inclusion: { in: BRANDS,
    message: "%{value} is not a valid brand" }


  def self.skin_type_results
    Datum.select(:skin_type).distinct.map(&:skin_type).map do |skin_type|
      self.skin_type_result(skin_type)
    end
  end
  
  def self.skin_type_result(skin_type)
    {
      title: skin_type,
      scent: self.scent_results(skin_type),
      colors: self.color_results(skin_type)
    }
  end

  def self.scent_results(skin_type)
    Datum.where(skin_type: skin_type).group(:prefered_scent).count
            .sort_by(&:last).reverse.first.first
  end

  def self.color_results(skin_type)
    colors = Datum.where(skin_type: skin_type).group(:prefered_color).count
    colors = COLORS.inject({}) {|a, c| a[c] = 0; a}.merge(colors)
    colors = colors.map {|c, v| {color: c, count: v}}
  end
end
