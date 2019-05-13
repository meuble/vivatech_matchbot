class Datum < ApplicationRecord
  SKIN_TYPES = %w(Claire Matte Foncées)
  COLORS = ["Rose Gourmand", "Rose Ancien", "Rose Corail", "Rouge Romantique", "Rouge Glamour", "Rouge Cerise"]
  AGE_GROUPS = %w(15-24 25-34 35-44 45-54 55+)
  BRANDS = ["Sephora", "Beautymix", "Monoprix", "Glossier", "Mademoiselle Bio", "Autre"]
  
  validates :skin_type, inclusion: { in: SKIN_TYPES,
    message: "%{value} is not a valid skin type" }
  validates :prefered_color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :age_group, inclusion: { in: AGE_GROUPS,
    message: "%{value} is not a valid age group" }
  validates :prefered_brand, inclusion: { in: BRANDS,
    message: "%{value} is not a valid brand" }

  def age=(original_age)
    age = original_age.to_i
    if age < 15
      self.errors.add(:age_group, "#{original_age} is not a valid age and should be over 14")
      return
    end
    
    case
    when age > 14 && age < 25
      self.age_group = "15-24"
    when age > 24 && age < 35
      self.age_group = "25-34"
    when age > 34 && age < 45
      self.age_group = "35-44"
    when age > 44 && age < 55
      self.age_group = "45-54"
    else
      self.age_group = "55+"
    end
  end

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
