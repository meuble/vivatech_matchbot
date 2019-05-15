class Datum < ApplicationRecord
  SKIN_TYPES = %w(Claire Matte Foncée)
  COLORS = ["Rose Ancien", "Rose Corail", "Rose Gourmand", "Rouge Cerise", "Rouge Glamour", "Rouge Romantique", "Aucun"]
  AGE_GROUPS = %w(15-24 25-34 35-44 45-54 55+)
  BRANDS = ["Sephora", "Beautymix", "Monoprix", "Glossier", "Mademoiselle Bio", "Autre"]
  GENDERS = %w(Male Female Undefined)
  
  validates :skin_type, inclusion: { in: SKIN_TYPES,
    message: "%{value} is not a valid skin type" }
  validates :prefered_color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :age_group, inclusion: { in: AGE_GROUPS,
    message: "%{value} is not a valid age group" }
  validates :prefered_brand, inclusion: { in: BRANDS,
    message: "%{value} is not a valid brand" }, allow_nil: true
  validates :gender, inclusion: { in: GENDERS,
    message: "%{value} is not a valid gender" }, allow_nil: true

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
    items_count = Datum.where(skin_type: skin_type).count
    {
      title: skin_type.parameterize,
      count: items_count,
      scent: self.scent_results(skin_type),
      colors: self.color_results(skin_type),
      top_color: self.top_color_results(skin_type),
      brands: self.brand_results(skin_type, items_count),
      age_group: self.age_group_results(skin_type),
      female_percentage: self.female_percentage_results(skin_type, items_count),
      zipcode_percentage: self.zipcode_results(skin_type, items_count)
    }
  end

  def self.zipcode_results(skin_type, items_count)
    d = Datum.where(skin_type: skin_type).group(:zipcode).count.inject({}) do |a, pair| 
      a[pair.first[0..1]] ||= 0.0
      a[pair.first[0..1]] += pair.last
      a
    end.sort_by(&:last)
    d = d.map {|d, v| {count: (v / items_count * 100).round, name: d}}
  end

  def self.female_percentage_results(skin_type, items_count)
    ((Datum.where(skin_type: skin_type).where(gender: "Female").count + 0.0) / 
      items_count * 100).round
  end

  def self.age_group_results(skin_type)
    Datum.where(skin_type: skin_type).group(:age_group).count
            .sort_by(&:last).reverse.first.first
  end

  def self.brand_results(skin_type, items_count)
    Datum.where(skin_type: skin_type).group(:prefered_brand).count
            .sort_by(&:last).reverse[0..1].map {|b, v| {name: b, count: ((v + 0.0) / items_count * 100).round}}
  end

  def self.scent_results(skin_type)
    Datum.where(skin_type: skin_type).order(:created_at, :id).last.prefered_scent
  end
  
  def self.top_color_results(skin_type)
    Datum.where(skin_type: skin_type).group(:prefered_color).count
            .sort_by(&:last).reverse.first.first
  end

  def self.color_results(skin_type)
    colors = Datum.where(skin_type: skin_type).group(:prefered_color).count
    colors = COLORS.inject({}) {|a, c| a[c] = 0; a}.merge(colors)
    colors = colors.map {|c, v| {color: c, count: v}}
  end
end
