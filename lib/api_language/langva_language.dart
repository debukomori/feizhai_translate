const langvaCode = {
  {'auto': 'auto'},
  {'English': 'en'},
  {'ChineseS': 'zh'},
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
};

class LingvaCode {
  static language(language) {
    var code;
    for (var i in langvaCode) {
      i.forEach((k, v) {
        if (k == language) {
          code = v;
          return;
        }
      });
    }
    return code;
  }
}
