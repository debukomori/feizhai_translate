import 'package:flutter/material.dart';

List<String> toList_zh = [
  "英语",
  "中文",
  "日本语",
  "俄语",
  "韩语",
  "德语",
  "印地语",
  "西班牙语",
  "法语",
  "阿拉伯语",
  "孟加拉语",
  "葡萄牙语",
  "印度尼西亚语",
  "荷兰语",
  "捷克语",
  "希腊语",
  "芬兰语",
  "瑞典语",
  "波兰语",
  "爱沙尼亚语",
  "丹麦语",
  "意大利语",
];
Future<Map<String, String>?> toSwitch_zh(result) async {
  switch (result) {
    case '英语':
      return {'英语': 'English'};
    case '中文':
      return {'中文': 'ChineseS'};
    case '日本语':
      return {'日本语': 'Japanese'};
    case '俄语':
      return {'俄语': 'Russian'};
    case '韩语':
      return {'韩语': 'Korean'};
    case '德语':
      return {'德语': 'German'};
    case '印地语':
      return {'印地语': 'Hindi'};
    case '西班牙语':
      return {'西班牙语': 'Spanish'};
    case '法语':
      return {'法语': 'French'};
    case '阿拉伯语':
      return {'阿拉伯语': 'Arabic'};
    case '孟加拉语':
      return {'孟加拉语': 'Bengali'};
    case '葡萄牙语':
      return {'葡萄牙语': 'Portuguese'};
    case '印度尼西亚语':
      return {'印度尼西亚语': 'Indonesian'};
    case '荷兰语':
      return {'荷兰语': 'Dutch'};
    case '捷克语':
      return {'捷克语': 'Czech'};
    case '希腊语':
      return {'希腊语': 'Greek'};
    case '芬兰语':
      return {'芬兰语': 'Finnish'};
    case '瑞典语':
      return {'瑞典语': 'Swedish'};
    case '波兰语':
      return {'波兰语': 'Polish'};
    case '爱沙尼亚语':
      return {'爱沙尼亚语': 'Estonian'};
    case '丹麦语':
      return {'丹麦语': 'Danish'};
    case '意大利语':
      return {'意大利语': 'Italian'};

    default:
      return null;
  }
}

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

class Dialog_To {
  static Future<Map<String, String>?> show(context) async {
    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('目标语言'),
          children: <Widget>[
            Column(
              children: List.generate(
                toList_zh.length,
                (index) {
                  return SimpleDialogOption(
                    child: ListTile(
                      title: Text(
                        toList_zh[index],
                        textScaleFactor: 1.1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, toList_zh[index]);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );

    Map<String, String>? code = await toSwitch_zh(result);

    return code;
  }
}
