import 'dart:isolate';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moe_code/setPage/setPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dialog/Dialog_To.dart';
import 'Dialog/Dialog_From.dart';
import 'fy.dart';
import 'LocalStorage.dart';
import 'setPage/setPage.dart';
import 'theme.dart';
import 'package:share_plus/share_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initSP();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light().copyWith(useMaterial3: true),
      darkTheme: dark,
      debugShowCheckedModeBanner: false,
      title: '肥宅翻译',
      home: Home(),
    );
  }
}
// ————————————————————————————————————————————
// ————————————————————————————————————————————
// ————————————————————————————————————————————

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textField = TextEditingController();

  String? main_to;
  String? main_to_value;

  String? main_from;
  String? main_from_value;

  @override
  void initState() {
    super.initState();
    setState(() {});

    main_to = LocalStorage.get('main_to') ?? '目标语言';
    main_to_value = LocalStorage.get('main_to_value') ?? 'ChineseS';

    main_from = LocalStorage.get('main_from') ?? '自动';
    main_from_value = LocalStorage.get('main_from_value') ?? 'auto';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: [
              IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Get.to(() => setPage())),
            ],
            title: const Text('肥宅翻译'),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _textField,
                  maxLines: 8,
                  minLines: 2,
                  autofocus: true,
                  decoration: InputDecoration(
                    suffixIcon: Wrap(
                      direction: Axis.vertical,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _textField.text = '';
                                data.clear();
                              });
                            },
                            icon: const Icon(Icons.clear)),
                        IconButton(
                            onPressed: () {
                              FlutterClipboard.paste()
                                  .then((v) => _textField.text = v);
                            },
                            icon: const Icon(Icons.paste)),
                      ],
                    ),
                    hintText: '请输入文本',
                    border: OutlineInputBorder(),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Dialog_From.show(context).then((key) {
                            setState(() {
                              key!.forEach((key, value) {
                                main_from = key;
                                LocalStorage.save('main_from', key);
                                main_from_value = value;
                                LocalStorage.save('main_from_value', value);
                              });
                            });
                          });
                        },
                        child: Text(main_from ?? 'auto')),
                    OutlinedButton(
                        onPressed: () {
                          Dialog_To.show(context).then((key) {
                            setState(() {
                              key!.forEach((key, value) {
                                main_to = key;
                                LocalStorage.save('main_to', key);
                                main_to_value = value;
                                LocalStorage.save('main_to_value', value);
                                //每次更换语言的时候对 显示语言 和 真实值 持久化
                              });
                            });
                          });

                          //拿回目标，
                          //让按钮文本变更并持久化
                        },
                        child: Text(main_to ?? '目标语言')),
                    OutlinedButton(
                        onPressed: () {
                          data.clear();
                          FocusScope.of(context).unfocus();
                          //翻译从这里开始————————

                          ((text, to, [from = 'auto']) {
                            Future(() => fy.baidu(text, to, from))
                                .then((_) => setState(() {}));
                            Future(() => fy.youdao(text, to, from))
                                .then((_) => setState(() {}));
                            Future((() => fy.lingva(text, to, from)))
                                .then((_) => setState(() {}));
                          })(_textField.text, main_to_value,
                              main_from_value); //传入要翻译的文本、目标语言、原语言（默认auto）

                          //————————翻译从这里结束
                        },
                        child: const Text('翻译')),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                          child: ListTile(
                            trailing: Wrap(
                              direction: Axis.vertical,
                              children: [
                                InkWell(
                                  child: Icon(Icons.copy),
                                  onTap: () {
                                    FlutterClipboard.copy(data[index]['title']);
                                    FlutterClipboard.paste().then((v) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('已复制：\n$v'),
                                      ));
                                    });
                                  },
                                ),
                                InkWell(
                                  child: Icon(Icons.share),
                                  onTap: () {
                                    Share.share(data[index]['title']);
                                  },
                                ),
                              ],
                            ),
                            //   trailing: InkWell(
                            //   child: Icon(Icons.copy),
                            //   onTap: () {
                            //     Share.share(data[index]['title']);
                            //     FlutterClipboard.copy(data[index]['title']);
                            //     FlutterClipboard.paste().then((v) {
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(SnackBar(
                            //         content: Text('已复制：\n$v'),
                            //       ));
                            //     });
                            //   },
                            // ),

                            subtitle: Text(data[index]['sub']),
                            title: SelectableText(data[index]['title']),
                          ),
                        );
                      }),
                )
              ],
            ),
          )),
    );
  }
}
