RegExp baseRegex = RegExp(r"^[ㄱ-ㅎ가-힣0-9a-zA-Z\s+]*$", unicode: true);
RegExp passwordRegex = RegExp(r"([a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)]){8,16}");//영문 대소문자 + 숫자 + 특수문자 8~16자
RegExp englishRegex = RegExp(r"([a-zA-Z])");
RegExp koreanRegex = RegExp(r"([가-힣])", unicode: true);
RegExp numberRegex = RegExp(r"([0-9])");

bool validatePassword(String text){
  return passwordRegex.allMatches(text).length == 1;
}

bool validateNickname(String text){
  var length = englishRegex.allMatches(text).length + koreanRegex.allMatches(text).length * 2 + numberRegex.allMatches(text).length;
  return 4 <= length && length <= 16;
}