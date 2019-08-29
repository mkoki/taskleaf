FactoryBot.define do
    factory :task do
        title {'テストを書く'}
        content{'Rspec factorybot capybaraを準備する'}
        user
    end
end