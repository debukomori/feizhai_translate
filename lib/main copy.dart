import 'dart:isolate';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moe_code/setPage/setPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fy.dart';
import 'LocalStorage.dart';
import 'setPage/setPage.dart';
import 'theme.dart';

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
      theme: light,
      debugShowCheckedModeBanner: false,
      title: '肥宅翻译',
      home: Home(),
    );
  }
}
// ————————————————————————————————————————————

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textField = TextEditingController();
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
                    OutlinedButton(onPressed: () {}, child: const Text('自动')),
                    OutlinedButton(onPressed: () {}, child: const Text('目标')),
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
                          })(_textField.text,
                              'ChineseS'); //传入要翻译的文本、目标语言、原语言（默认auto）

                          //————————翻译从这里结束
                        },
                        child: const Text('翻译')),
                  ],
                ),
                // ButtonBar(
                //   alignment: MainAxisAlignment.center,
                //   children: [
                //     OutlinedButton(
                //         onPressed: () {
                //           setState(() {
                //             _textField.text = '';
                //             data.clear();
                //           });
                //         },
                //         child: const Text('清空')),
                //     OutlinedButton(
                //         onPressed: () {
                //           FlutterClipboard.paste()
                //               .then((v) => _textField.text = v);
                //         },
                //         child: const Text('粘贴')),
                //     OutlinedButton(
                //         onPressed: () {
                //           data.clear();
                //           setState(() {
                //             fy.go(_textField.text, 'ja').then((v) {
                //               setState(() {});
                //             });
                //           });
                //         },
                //         child: const Text('翻译')),
                //   ],
                // ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            trailing: InkWell(
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
