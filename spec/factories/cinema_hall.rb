FactoryBot.define do
  factory :cinema_hall do
    name { 'small hall' }
    capacity { 10 }
    not_available { %w[A2, A3] }
    seats {
      [
        %w[A1 A2 A3 A4],
        %w[B1 B2 B3 B4],
        %w[C1 C2 C3 C4]
      ]
    }
  end
end
