FactoryBot.define do
  factory :activity do
    address1 { 'Plac Europejski 2, Warszawa, Polska' }
    address2 { 'Szprotawska 130, Warszawa, Polska' }
    distance { 1.5 }
    association :user
  end
end
