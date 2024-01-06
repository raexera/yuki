# Author: Mihai Fufezan(https://github.com/fufexan)
lib:
with lib; rec {
  x = c: "#${c}";

  rgba = c: let
    r = toString (hexToDec (__substring 0 2 c));
    g = toString (hexToDec (__substring 2 2 c));
    b = toString (hexToDec (__substring 4 2 c));
    res = "rgba(${r}, ${g}, ${b}, .5)";
  in
    res;

  hexToDec = v: let
    hexToInt = {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      "a" = 10;
      "b" = 11;
      "c" = 12;
      "d" = 13;
      "e" = 14;
      "f" = 15;
      "A" = 10;
      "B" = 11;
      "C" = 12;
      "D" = 13;
      "E" = 14;
      "F" = 15;
    };
    chars = stringToCharacters v;
    charsLen = length chars;
  in
    foldl
    (a: v: a + v)
    0
    (imap0
      (k: v: hexToInt."${v}" * (pow 16 (charsLen - k - 1)))
      chars);

  pow = let
    pow' = base: exponent: value:
      if exponent == 0
      then value
      else if mod exponent 2 == 0
      then pow' (base * base) (div exponent 2) value
      else pow' base (exponent - 1) (value * base);
  in
    base: exponent: pow' base exponent 1;

  xcolors = colors: lib.mapAttrsRecursive (_: x) colors;
  rgbaColors = colors: lib.mapAttrsRecursive (_: rgba) colors;
}
