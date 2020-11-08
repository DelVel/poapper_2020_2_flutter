# lecture2

오늘을 위젯들에 대해 살펴볼 겁니다.

다양한 위젯들이 있는데, [여기](https://github.com/DelVel/poapper_2020_2_flutter/tree/master/widgets)에서
확하실 수 있습니다.

간단한 어플리케이션을 하나 만들어봅시다.

```Dart
// import를 통해 사용할 위젯들을 불러옵시다.
import 'package:flutter/material.dart';

// 필수인 main함수는 자동적으로 생성됩니다.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // StatelessWidget을 예시로 만들어서 build 내부가 원하는 위젯이 오도록 하면 됩니다.
  @override
  Widget build(BuildContext context) {
    // Material 디자인을 사용해봅시다 (주로 안드로이드가 쓰는 디자인).
    return MaterialApp(
      title: 'Poapper login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 여기서 night mode나 어두운 테마를 설정할 때 나오는 darkTheme을 설정할 수 있습니다.
      // 기본적으로 ThemeData.dark()가 주어지지만 원하신다면 다른 것으로 바꿔도 됩니다.
      darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이 Controller들은 나중에 텍스트 입력을 확인하기 위해 사용합니다.
    var idController = TextEditingController();
    var pwController = TextEditingController();
    // Scaffold는 십중팔구 Material 앱의 최상단 위젯이 됩니다. Material이 지원하는
    // 다양한 기능을 가지기 때문입니다.
    return Scaffold(
      // 포스텍 이미지를 상단에 맞춰 넣기 위해서는 AppBar 내부의 크기 제한을 풀어야 합니다.
      // 이때 PreferredSize를 사용하시면 됩니다.
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          // 여유 공간에 포스텍 이미지를 넣어 봅시다.
          flexibleSpace: Image.network("http://postech.ac.kr/wp-content/uploads/2020/08/header_logo_%EA%B5%AD%EB%AC%B8.png"),
        ),
      ),
      // 이제 대망의 본체를 작성하도록 합시다.
      body: Align(
        // Align은 위젯 설명에 나와있습니다. topCenter를 통해 상단 중앙에 위치시켜보도록 합시다.
        alignment: Alignment.topCenter,
        // 카드는 Material 디자인 요소 중 하나로, 둥근 모서리 사각형에 약간 떠 있는 느낌을 주는
        // 요소입니다.
        child: Card(
          // 떠오른 정도
          elevation: 15,
          // 모서리 둥근 정도
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // 외부에 두를 여유 공간
          margin: EdgeInsets.all(40),
          child: Padding(
            // symmetric을 통해 가로방향과 세로방향의 여유를 줄 수 있습니다.
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            // 세로방향으로 로그인창과 버튼을 묶어봅시다.
            child: Column(
              // 최대 크기로 뻗으려는 습성을 억제합시다.
              mainAxisSize: MainAxisSize.min,
              children: [
                // 가로 방향으로 로그인 이미지와 ID, PW 입력란 묶음을 배치합시다.
                Row(
                  // 얘도 크기를 조절하고
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 이미지의 크기를 80x80으로 조절합니다.
                    SizedBox(
                      width: 80,
                      height: 80,
                      // ClipRRect는 둥근 사각형에 자식을 끼워넣는 위젯입니다.
                      child: ClipRRect(
                        // 바로 이 이미지를 끼워넣게 됩니다. 크기가 적당히 축소되게 됩니다.
                        child: Image.network("https://avatars1.githubusercontent.com/u/19258681?s=200&v=4"),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // 여유를 주기 위해 Container를 사용했습니다. 다만 Container는 크기를 정하지
                    // 않은 쪽은 최대로 뻗습니다! (자식이 없다면)
                    // 그것이 싫다면, SizedBox를 이용하세요. 얘는 뻗지 않습니다.
                    Container(
                      width: 30,
                    ),
                    // 여기서 중요한 점입니다. 먼저 가로 크기를 설정해야 합니다.
                    // 나중에 마저 설명하겠습니다.
                    Container(
                      width: 200,
                      // ID와 PW가 세로로 묶여 있도록 합시다.
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 텍스트필드에 controller를 달아주고 꾸며줍시다.
                          TextField(
                            decoration: InputDecoration(
                              // 경계선을 칠하는 꾸밈입니다.
                              border: OutlineInputBorder(),
                              // 라벨이 ID로 표시됩니다.
                              labelText: "ID",
                            ),
                            controller: idController,
                          ),
                          // 여유를 줍시다.
                          SizedBox(height: 5),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "PW",
                            ),
                            controller: pwController,
                          ),
                          // 앞서 가로 크기를 정한 이유가 이 두 TextField 때문입니다.
                          // Column은 Row의 자식인데, Row는 가로 크기가 제한이 없도록 합니다.
                          // 따라서 Column도 가로 제한이 없다고 자식들에게 전달합니다.
                          // 그런데 TextField는 가능한 최대 길이를 가지고 싶어합니다.
                          // 따라서 Column에 가로 크기를 두지 않으면 오류가 나게 됩니다!
                        ],
                      ),
                    ),
                  ],
                ),
                // 앞서 언급한 간격을 줍시다.
                SizedBox(height: 15),
                Card(
                  elevation: 5,
                  // 이번에는 버튼을 만들 것인데, SnackBar를 표기하고 싶습니다. 이때,
                  // 그걸 만드려면 context 안에 Scaffold가 있어야 하는데, 현재 문맥에서의
                  // context는 Scaffold가 없습니다. 따라서 Builder를 통해
                  // Scaffold가 있는 context를 넘겨줍시다.
                  child: Builder(
                    builder: (BuildContext context) {
                      // InkWell, 버튼입니다.
                      return InkWell(
                        onTap: () {
                          var data = "not identified.";
                          // 여기서 controller들의 진가가 발휘됩니다. 현재 그 필드에 있는
                          // 텍스트가 무엇인지를 알 수 있습니다.
                          if (idController.text == "Poapper" && pwController.text == "flutter") data = "welcome!";
                          // Scaffold에게 SnackBar를 띠우라고 명령합시다.
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(data)));
                        },
                        // 패딩을 적당히 줍시다.
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                          child: Text("log me in!"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // 별다른 기능은 없는 FAB를 넣어봅시다.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 눌렸을 때 콘솔(run이라고 이름이 있을 겁니다)에 FAB!가 출력이 됩니다.
          print("FAB!");
        },
        child: Icon(Icons.add_ic_call),
      ),
      // FAB의 위치를 정하는 곳인데, 이 endDocked는 밑의 NavBar와 간섭하여 딱 들어맞도록 하는
      // 옵션입니다.
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      // 밑 NavBar입니다. 간단하게 Center로 텍스트를 중앙에 두고 Container로 높이를 정하고 있습니다.
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Center(
            child: Text("bottom .."),
          ),
          height: 60,
        ),
      ),
    );
  }
}

```