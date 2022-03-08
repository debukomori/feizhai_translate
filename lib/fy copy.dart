import 'dart:io';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:moe_code/LocalStorage.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'api_language/baidu_language.dart';
import 'api_language/langva_language.dart';
import 'api_language/youdao_language.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

var data = [];

class fy {
  static listAdd(String name, String jieguo) async {
    data.add({
      'sub': name,
      'title': jieguo,
    });
  }

  static baidu(text, too, sotoFrom) async {
    var baiduSwitch = LocalStorage.get('baidu_Switch').toString(); //开关
    //用IF判断第一次的null、开关、待翻译内容、id、key
    if (baiduSwitch != 'null' &&
        baiduSwitch == 'true' &&
        text != '' &&
        LocalStorage.get('baidu_ID') != '' &&
        LocalStorage.get('baidu_KEY') != '') {
      var appid = await LocalStorage.get('baidu_ID');
      var key = await LocalStorage.get('baidu_KEY');
      var q = text;
      var from = await back_baidu_code.language(sotoFrom);
      var to = await back_baidu_code.language(too);
      if (to == null || from == null) {
        listAdd('百度', '不支持翻译此语言');
        return;
      }
      var salt = (DateTime.now().millisecondsSinceEpoch / 1000).round();
      var sign = md5
          .convert(utf8.encode('$appid$q$salt$key'))
          .toString(); //appid+q+salt+密钥 的MD5值

      go() async {
        Dio dio = new Dio();

        String url =
            "https://api.fanyi.baidu.com/api/trans/vip/translate?q=$q&from=$from&to=$to&appid=$appid&salt=$salt&sign=$sign";
        Response response = await dio.get(url);
        var res = json.decode(response.toString());
        var error = res['error_code'] ?? '';
        if (error == '') {
          var jieguo = res['trans_result']?[0]?['dst'];
          listAdd('百度', jieguo);
        } else if (error != '') {
          listAdd('百度', '错误码：$error');
        }
      }

      await go();
    }
  }

  static youdao(text, too, sotoFrom) async {
    var youdaoTemp = LocalStorage.get('youdao_Switch').toString(); //开关
    //用IF判断第一次的null、开关、待翻译内容、id、key
    if (youdaoTemp != 'null' &&
        youdaoTemp == 'true' &&
        text != '' &&
        LocalStorage.get('youdao_ID') != '' &&
        LocalStorage.get('youdao_KEY') != '') {
      var appKey = await LocalStorage.get('youdao_ID');
      var key = await LocalStorage.get('youdao_KEY');
      var q = text;
      var salt = DateTime.now().millisecondsSinceEpoch;
      var curtime = (salt / 1000).round();
      var from = await back_youdao_code.language(sotoFrom);
      var to = await back_youdao_code.language(too);

      if (to == null || from == null) {
        listAdd('有道', '不支持翻译此语言');
        return;
      }
      String truncate(String q) {
        var len = q.length;
        if (len <= 20) return q;
        // return q.substring(0, 10) + len + q.substring(len - 10, len);
        return '${q.substring(0, 10)}${len}${q.substring(len - 10, len)}';
      }

      var str1 = "$appKey${truncate(q)}$salt$curtime$key";
      var sign = sha256.convert(utf8.encode(str1));

      go() async {
        Dio dio = new Dio();
        FormData formData = FormData.fromMap({
          'q': q,
          'appKey': appKey,
          'salt': salt,
          'from': from,
          'to': to,
          'sign': sign,
          'signType': "v3",
          'curtime': curtime,
        });
        String url = "https://openapi.youdao.com/api";

        Response response = await dio.post(url, data: formData);
        var res = json.decode(response.toString());
        var jieguo = res['translation'][0];
        listAdd('有道', jieguo);
      }

      await go();
    } //有道

//—————有道—————————————————————————————————
    // var youdaoTemp = LocalStorage.get('youdao_Switch').toString(); //开关
    // //用IF判断第一次的null、开关、待翻译内容、id、key
    // if (youdaoTemp != 'null' &&
    //     youdaoTemp == 'true' &&
    //     text != '' &&
    //     LocalStorage.get('youdao_ID') != '' &&
    //     LocalStorage.get('youdao_KEY') != '') {
    //   var appKey = LocalStorage.get('youdao_ID');
    //   var key = LocalStorage.get('youdao_KEY');
    //   var q = text;
    //   var salt = DateTime.now().millisecondsSinceEpoch;
    //   var curtime = (salt / 1000).round();
    //   var from = form;
    //   var to = too;
    //   String truncate(String q) {
    //     var len = q.length;
    //     if (len <= 20) return q;
    //     // return q.substring(0, 10) + len + q.substring(len - 10, len);
    //     return '${q.substring(0, 10)}${len}${q.substring(len - 10, len)}';
    //   }
    //   var str1 = "$appKey${truncate(q)}$salt$curtime$key";
    //   var sign = sha256.convert(utf8.encode(str1));
    //   go() async {
    //     Dio dio = new Dio();
    //     FormData formData = FormData.fromMap({
    //       'q': q,
    //       'appKey': appKey,
    //       'salt': salt,
    //       'from': from,
    //       'to': to,
    //       'sign': sign,
    //       'signType': "v3",
    //       'curtime': curtime,
    //     });
    //     String url = "https://openapi.youdao.com/api";
    //     Response response = await dio.post(url, data: formData);
    //     var res = json.decode(response.toString());
    //     var jieguo = res['translation']
    //         .toString()
    //         .substring(1, res['translation'].toString().length - 1);
    //     listAdd('有道', jieguo);
    //   }
    //   await go();
    // } //有道

//——————————————————————————————————————
//     (() {
//       var tx = LocalStorage.get('txCould_Switch').toString(); //开关
//       //用IF判断第一次的null、开关、待翻译内容、id、key
//       if (tx != 'null' &&
//           tx == 'true' &&
//           text != '' &&
//           LocalStorage.get('txCould_ID') != '' &&
//           LocalStorage.get('txCould_KEY') != '') {
//         String SecretId = LocalStorage.get('txCould_ID');
//         String SecretKey = LocalStorage.get('txCould_KEY');
//         String Timestamp = (DateTime.now().millisecondsSinceEpoch / 1000)
//             .round()
//             .toString(); //时间戳
//         String nyr = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]); //日期
//         var kDate = Hmac(sha256, utf8.encode('TC3$SecretKey'))
//             .convert(utf8.encode(nyr));
//         var kService = Hmac(sha256, utf8.encode(kDate.toString()))
//             .convert(utf8.encode('tmt'));
//         var kSigning = Hmac(sha256, utf8.encode(kService.toString()))
//             .convert(utf8.encode('tc3_request'));
//         //hmac     Hmac(256,key).convert(date)   key,date =  utf8.encode
// //-----------------------------------------------------------
//         Map<String, dynamic> headers = {
//           'Authorization':
//               'TC3-HMAC-SHA256 Credential=$SecretId/$nyr/tmt/tc3_request, SignedHeaders=content-type;host, Signature={签名摘要}',
//           'Content-Type': 'application/json',
//           'X-TC-Action': 'TextTranslate',
//           'X-TC-Timestamp': Timestamp,
//           'X-TC-Version': '2018-03-21',
//           'X-TC-Region': 'ap-guangzhou',
//         };
//         // go() async {
//         //   Dio dio = new Dio();
//         //   FormData formData = FormData.fromMap({
//         //     "SourceText": text,
//         //     "Source": form,
//         //     "Target": too,
//         //     "ProjectId": 0
//         //   });
//         //   String url = "https://tmt.tencentcloudapi.com";
//         //   Response response = await dio.post(url, data: formData);
//         //   var res = json.decode(response.toString());
//         //   var jieguo = res['Response']['TargetText']
//         //       .toString()
//         //       .substring(1, res['Response']['TargetText'].toString().length - 1);
//         //   listAdd('腾讯云', jieguo);
//         // }
//         // await go();
//       }
//     })();

//—————腾讯云—————————————————————————————————

//百度
  }

  static lingva(text, too, sotoFrom) async {
    bool on = LocalStorage.get('LingvaSwitch');
    String txt = text.replaceAll('/', '.');

    var from = await LingvaCode.language(sotoFrom);
    var to = await LingvaCode.language(too);
    if (from == null || to == null) {
      listAdd('Lingva', '不支持翻译此语言');
      return;
    }

    if (on == true && txt != '') {
      Uri url = Uri.https(
        "lingva.ml",
        "/api/v1/$from/$to/$txt",
      );
      try {
        var response = await http.get(url).timeout(const Duration(seconds: 6));

        if (response.statusCode == 200) {
          var result = convert.jsonDecode(response.body);
          listAdd('Lingva', result['translation']);
        } else {
          var result = convert.jsonDecode(response.body);
          listAdd('Lingva',
              '错误：\n可能是网络有问题 或\n目标语言不支持 或\n文本里有奇怪的符号\ntatusCode: ${response.statusCode}\nerror: ${result['error']}');
        }
      } catch (e) {
        print(e);
        listAdd('Lingva', '超时了');
      }
    } //http
  }
}
