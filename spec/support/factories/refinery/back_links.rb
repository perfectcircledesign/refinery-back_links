
FactoryGirl.define do
  factory :back_link, :class => Refinery::BackLinks::BackLink do
    sequence(:old_link) { |n| "refinery#{n}" }
  end
end

