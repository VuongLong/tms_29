FactoryGirl.define do
  factory :subject do
    name {Faker::Name.name}
    description {Faker::Lorem.sentence}
    
    factory :invalid_name_subject do
      name ""
    end

    factory :invalid_description_subject do
      description ""
    end
  end
end
