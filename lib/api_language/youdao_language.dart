const youdao_code = {
  {'English': 'en'},
  {'auto': 'auto'},
  {'ChineseS': 'zh-CHS'},
  {'Japanese': 'ja'},
  {'Russian': 'ru'},
  {'Korean': 'ko'},
  {'German': 'de'},
  {'Hindi': 'hi'},
  {'Spanish': 'es'},
  {'French': 'fr'},
  {'Arabic': 'ar'},
  {'Bengali': 'bn'},
  {'Portuguese': 'pt'},
  {'Indonesian': 'id'},
  {'Dutch': 'nl'},
  {'Czech': 'cs'},
  {'Greek': 'el'},
  {'Finnish': 'fi'},
  {'Swedish': 'sv'},
  {'Polish': 'pl'},
  {'Estonian': 'et'},
  {'Danish': 'da'},
  {'Italian': 'it'},
}; //以百度未准

class back_youdao_code {
  static language(language) {
    var code;
    for (var i in youdao_code) {
      i.forEach((k, v) async {
        if (k == language) {
          code = v;
        }
      });
    }
    return code;
  }
}
