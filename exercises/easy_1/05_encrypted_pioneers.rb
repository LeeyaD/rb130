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

ALPHA = ("a".."z").to_a


def decrypt_name(name)
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


p decrypt_name("Nqn Ybirynpr") == "Ada Lovelace"
p decrypt_name("Tenpr Ubccre") == "Grace Hopper"
p decrypt_name("Nqryr Tbyqfgvar") == "Adele Goldstine"
p decrypt_name("Nyna Ghevat") == "Alan Turing"
p decrypt_name("Puneyrf Onoontr") == "Charles Babbage"
p decrypt_name("Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv") == "Abdullah Muhammad bin Musa al-Khwarizmi"
p decrypt_name("Wbua Ngnanfbss") == "John Atanasoff"
p decrypt_name("Ybvf Unvog") == "Lois Haibt"
p decrypt_name("Pynhqr Funaaba") == "Claude Shannon"
p decrypt_name("Fgrir Wbof") == "Steve Jobs"
p decrypt_name("Ovyy Tngrf") == "Bill Gates"
p decrypt_name("Gvz Orearef-Yrr") == "Tim Berners-Lee"
p decrypt_name("Fgrir Jbmavnx") == "Steve Wozniak"
p decrypt_name("Xbaenq Mhfr") == "Konrad Zuse"
p decrypt_name("Fve Nagbal Ubner") == "Sir Antony Hoare"
p decrypt_name("Zneiva Zvafxl") == "Marvin Minsky"
p decrypt_name("Lhxvuveb Zngfhzbgb") == "Yukihiro Matsumoto"
p decrypt_name("Unllvz Fybavzfxv") == "Hayyim Slonimski"
p decrypt_name("Tregehqr Oynapu") == "Gertrude Blanch"

# Write a program that deciphers and prints each of these names .