class ChoiceRetriever

    @choices = {happy: "HAPPY",
              friends: "FRIENDLY",
              peaceful: "PEACEFUL",
              grateful: "GRATEFUL",
              selfie: "SELF CENTERED",
              love: "LOVEY",
              nature: "GRANOLA",
              inspiration: "INSPIRED",
              heartbreak: "BROKEN HEARTED",
              fitness: "ACTIVE",
              foodie: "HUNGRY",
              sleepy: "SLEEPY",
              cuteness: "CUTE DEPRIVED",
              bromance: "BRO LOVE",
              wedding: "PINTERESTY",
              wordstoliveby: "LOQUACIOUS"}

  def self.return_all
    @choices
  end

  def self.return_choices
    @choices = @choices.to_a.sample(6)
  end

end