class Datum < ApplicationRecord
  SKIN_TYPES = %w(Claire Matte Foncées)
  COLORS = ["Rose Gourmand", "Rose Ancien", "Rose Corail", "Rouge Romantique", "Rouge Glamour", "Rouge Cerise"]
  AGE_GROUPS = %w(0_15 16_30 31_45 46_60 60+)
  BRANDS = ["Sephora", "Beautymix", "Monoprix", "Glossier", "Mademoiselle Bio", "Autre"]
  
  validates :skin_type, inclusion: { in: SKIN_TYPES,
    message: "%{value} is not a valid skin type" }
  validates :prefered_color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
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
      colors: self.color_results(skin_type),
      brand: self.brand_results(skin_type),
      age_group: self.age_group_results(skin_type)
    }
  end

  def self.age_group_results(skin_type)
    Datum.where(skin_type: skin_type).group(:age_group).count
            .sort_by(&:last).reverse.first.first
  end

  def self.brand_results(skin_type)
    Datum.where(skin_type: skin_type).group(:prefered_brand).count
            .sort_by(&:last).reverse.first.first
  end

  def self.scent_results(skin_type)
    Datum.where(skin_type: skin_type).order(:created_at, :id).last.prefered_scent
  end

  def self.color_results(skin_type)
    colors = Datum.where(skin_type: skin_type).group(:prefered_color).count
    colors = COLORS.inject({}) {|a, c| a[c] = 0; a}.merge(colors)
    colors = colors.map {|c, v| {color: c, count: v}}
  end
end
