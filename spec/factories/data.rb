FactoryBot.define do
  factory :datum do
    skin_type { Datum::SKIN_TYPES.shuffle.first }
    prefered_color { Datum::COLORS.shuffle.first }
    prefered_scent { Datum::SCENTS.shuffle.first }
    age_group { Datum::AGE_GROUPS.shuffle.first }
    prefered_brand { Datum::BRANDS.shuffle.first }
  end
end
