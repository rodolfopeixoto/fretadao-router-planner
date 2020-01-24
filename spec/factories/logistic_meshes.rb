FactoryBot.define do
  factory :logistic_mesh do
    map { 'SP' }
    routes { ['A B 2', 'A C 3', 'B D 2', 'B A 2', 'B E 5', 'C D 1',
              'C F 6', 'C A 3', 'D E 3', 'D F 5', 'F D 5', 'F C 6',
              'F G 4', 'E B 5', 'E D 3', 'E G 5', 'G F 4', 'G E 5'] }
    trait :fail do
      routes  { ['2 2 2', 'A C 3', 'B D 2', 'B A 2', 'B E 5', 'C D 1',
                'C F 6', '2 1 3', 'D E 3', 'D F 5', 'F D 5', 'F C 6',
                'F G 4', 'E B 5', 'E D 3', 'E G 5', 'G F 4', 'G E 5'] }
    end
  end
end
