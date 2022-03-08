const baidu_code = {
  {'auto': 'auto'},
  {'ChineseS': 'zh'}, //中文简体
  {'English': 'en'}, //英语
  {'Cantonese': 'yue'}, //粤语
  {'classical Chinese': 'wyw'}, //文言文
  {'Japanese': 'jp'}, //日语
  {'Korean': 'kor'}, //韩语
  {'French': 'fra'}, //法语
  {'Spanish': 'spa'}, //西班牙语
  {'Thai': 'th'}, //泰语
  {'Arabic': 'ara'}, //阿拉伯语
  {'Russian': 'ru'}, //俄语
  {'Portuguese': 'pt'}, //葡萄牙语
  {'German': 'de'}, //德语
  {'Italian': 'it'}, //意大利语
  {'Greek': 'el'}, //希腊语
  {'Dutch': 'nl'}, //荷兰语
  {'Polish': 'pl'}, //波兰
  {'Bulgarian': 'bul'}, //保加利亚
  {'Estonian': 'est'}, //爱沙尼亚
  {'Danish': 'dan'}, //丹麦
  {'Finnish': 'fin'}, //芬兰
  {'Czech': 'cs'}, //捷克
  {'Romanian': 'rom'}, //罗马尼亚
  {'Slovenian': 'slo'}, //斯洛文尼亚
  {'Swedish': 'swe'}, //瑞典
  {'Hungarian': 'hu'}, //匈牙利语
  {'ChineseT': 'cht'}, //繁体中文
  {'Vietnamese': 'vie'}, //越南语
};

class back_baidu_code {
  static language(language) {
    var code;
    for (var i in baidu_code) {
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
