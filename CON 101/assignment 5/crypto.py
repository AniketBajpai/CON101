def encrypt(plainText, shift): 
  cipherText = ""
  for ch in plainText:
    if ch.isalpha():
      stayInAlphabet = ord(ch) + shift 
      if stayInAlphabet > ord('Z'):
        stayInAlphabet -= 26
      cipherText += chr(stayInAlphabet)
    if ch == " ":
      cipherText += ch
  print "Your ciphertext is: ", cipherText
  return cipherText


for i in range(0, 26):
    encrypt("JRQH WR ZDWFK KDUOHTXLQV.EDFN DW VHYHQ.", i)

for i in range(0, 27):
    encrypt("BPQA PIA JMMV APQNBML JG MQOPB", i)

encrypt("VXKT BT RWTTHT EATPHT", 11)

##print "JANUARY BRINGS THE SNOW"
