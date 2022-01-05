# The following list contains the names of individuals who are pioneers in the field of computing or that have had a significant influence on the field. The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption called Rot13.


# Input: string 'name'
# - encrypted form, Rot13
# -- every letter has been replaced with the 13th letter after it
# Output: string
# - decrypted 'name'
# -- containing -13th letter before every given letter

# Note
# - ignore non-alpha characters

# DS: array
# ALGO
# 1. create method that takes 1 arg, 'name'
# -- INIT empty string, 'results'
# 2. ITERATE thru given 'name' for each char
# -- - FIND index of curr_char in ALPHABET constant, 'encrypt'
# -- - FIND index of 13th letter BEFORE curr_char, 'decrypt'
# -- - RETURN character at 'decrypt' index in constant, 'letter'
# -- - - ADD 'letter' to empty string, 'results'
# 3. RETURN 'results'

PIONEERS = [ "Nqn Ybirynpr", "Tenpr Ubccre", "Nqryr Tbyqfgvar", "Nyna Ghevat", "Puneyrf Onoontr", "Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv", "Wbua Ngnanfbss", "Ybvf Unvog", "Pynhqr Funaaba", "Fgrir Wbof", "Ovyy Tngrf", "Gvz Orearef-Yrr", "Fgrir Jbmavnx", "Xbaenq Mhfr", "Fve Nagbal Ubner", "Zneiva Zvafxl", "Lhxvuveb Zngfhzbgb", "Unllvz Fybavzfxv", "Tregehqr Oynapu"]

ALPHA = ("a".."z").to_a

def decipher(name)
  results = ""

  name.chars.each do |char|
    if !ALPHA.include?(char.downcase)
      results << char
      next
    end
    
    encrypt = ALPHA.index(char.downcase)
    decrypt = encrypt - 13
    letter = ALPHA.include?(char) ? ALPHA[decrypt] : ALPHA[decrypt].upcase
    results << letter
  end
  results
end

PIONEERS.each do |pioneer|
  puts decipher(pioneer)
end
# Write a program that deciphers and prints each of these names .