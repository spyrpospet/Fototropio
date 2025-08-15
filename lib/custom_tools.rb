module CustomTools
  @@map = {
    "α" => "a",
    "ά" => "a",
    "Α" => "A",
    "Ά" => "A",
    "β" => "v",
    "Β" => "B",
    "γ" => "g",
    "Γ" => "G",
    "δ" => "d",
    "Δ" => "D",
    "ε" => "e",
    "έ" => "e",
    "Ε" => "E",
    "Έ" => "E",
    "ζ" => "z",
    "Ζ" => "Z",
    "η" => "i",
    "ή" => "i",
    "Η" => "H",
    "Ή" => "H",
    "θ" => "th",
    "Θ" => "TH",
    "ι" => "i",
    "ί" => "i",
    "Ι" => "I",
    "κ" => "k",
    "Κ" => "K",
    "λ" => "l",
    "Λ" => "L",
    "μ" => "m",
    "Μ" => "M",
    "ν" => "n",
    "Ν" => "N",
    "ξ" => "ks",
    "Ξ" => "KS",
    "ο" => "o",
    "ό" => "o",
    "Ο" => "O",
    "Ό" => "O",
    "π" => "p",
    "Π" => "P",
    "ρ" => "r",
    "Ρ" => "R",
    "σ" => "s",
    "ς" => "s",
    "Σ" => "S",
    "τ" => "t",
    "Τ" => "T",
    "υ" => "u",
    "ύ" => "u",
    "Υ" => "Y",
    "φ" => "f",
    "Φ" => "F",
    "χ" => "x",
    "Χ" => "X",
    "ψ" => "ps",
    "Ψ" => "PS",
    "ω" => "o",
    "ώ" => "o",
    "Ω" => "O",
  }
  def convert_cas(string)
    if string.present?
      words     = string.strip.delete("/;.").downcase.split("").reject(&:empty?)
      words.map{ |character| @@map[character] || character }.join("").gsub(' ','-')
    end
  end

  def self.convert_cas_inline(string)
    if string.present?
      words     = string.strip.delete("/;.").downcase.split("").reject(&:empty?)
      words.map{ |character| @@map[character] || character }.join("").gsub(' ','-')
    end
  end
end