function fmel = convert2mel(f)

fmel = 2595*log10(1+f./700);