# Lecture 1

## [다트 언어를 배워 봅시다(영어)!](https://dart.dev/guides/language/language-tour)

다트는 파이썬과 자바를 섞어놓은 듯 한 언어입니다.
초기 강의에는 수준급의 다트 문법 지식을 요구하지 않기 때문에
대략 어떠한 문법이 있는지를 살펴 봅시다.

```dart
class A{
    A({Key key, this.title}) : super(key: key);
    final string title;
}
```

이 클래스는 멤버 변수로 상수 `title`을  가지고 있고 생성자가 매개변수로
사전같은 것을 받아오고 있습니다. 저러한 생성자는 몇 개의 코드를 하나로
줄인 것인데, `key`와 `title`을 파이썬의 kwargs처럼 받아와 즉시 변수에 할당하라는
뜻이 됩니다. 따라서 `key`변수에는 보내진 `key`에 해당하는 값이 들어가고,
`this.title`에는 전해진 `title`에 해당하는 값이 들어가게 됩니다.
이때 `this`는 생략되어, `title: "asdf"`로 하면 `asdf`가 할당되게 됩니다.

즉 다음 코드는
```dart
A a = A(title: "asdf");
```
`a.title`이 `asdf`인 인스턴스를 생성합니다.

> key는 어디있나요?

`key`에는 아무것도 전달되지 않았습니다. 이때 이러한 것에는 `null`이 들어가게 됩니다.

반드시 넣어야 하는 매개 변수를 나타내고자 하면 `@Required` 어노테이션을 사용하세요.

## 위젯

`StatelessWidget`, `StatefulWidget` 뿐 만 아니라
`Column`, `Row` 와 같은 것도 전부 위젯입니다! 위젯은 화면에 표시되는 모든 요소를
말하고, 따라서 플러터를 코딩하면서 보는 거의 모든 UI 클래스는 위젯입니다.

플러터는 올바른 위젯을 선택하는 것, 위젯을 의도에 맞게 배치하는 것이 가장 중요합니다.

[여기](https://github.com/DelVel/poapper_2020_2_flutter/blob/master/widgets/README.md)에서 많은 위젯을 알아 볼 수 있습니다.

## 크기 및 위치

[원본 링크(영어)](https://flutter.dev/docs/development/ui/layout/constraints)

플러터 프레임워크에서 위젯의 크기와 위치가 정해지는 규칙은 3문장입니다.

- 제한은 아래로,
- 크기는 위로,
- 부모가 위치를 정한다.

제한이란 위젯이 가질 수 있는 크기의 범위입니다. 다음 이미지를 봅시다.

![위젯 레이아웃](https://flutter.dev/assets/ui/layout/children-e91446e3717f0acbe225c7055416b520a2a9a232f7da3f98fe277729bb7047da.png)

일어나는 과정:

위젯(연노랑): "부모, 내 제한은 얼마지?"

부모: "가로로는 80\~300, 세로로는 30\~85, 픽셀."

위젯: "음, 5픽셀짜리 패딩을 넣어야 하니까 내 자식들은 가로 최대 290, 세로 최대 75 픽셀이겠네."

위젯: "첫째야(파랑), 가로로 0\~290, 세로로 0\~75 픽셀 가능하다."

첫째: "확인, 가로 290, 세로 20 픽셀로 정함."

위젯: "둘째는 첫째 밑에 놓아야 하니까 세로 최대 55픽셀뿐이구만."

위젯: "둘째(초록)야, 가로 0\~290, 세로 0\~55 픽셀 가능하다."

둘째: "확인, 가로 140, 세로 30 픽셀로 정함."

위젯: "그러면, 첫째는 (5, 5), 둘째는 (80, 25)에 있게 되겠네."

위젯: "부모야 크기 다 정했다. 가로 300, 세로 60 픽셀이다."

이러한 과정의 한계점은

- 위젯이 자기 크기를 마음대로 정할 수 없음.
- 자기 위치를 고르는 것은 부모이므로, 정작 위젯 자신은 자기 위치를 모름.
- 부모 또한 지 부모에게서 제한을 받아오므로, 트리 전체를 분석하지 않는 한 정밀한 위치/크기 분석이 불가능.

이제 사이징 예제를 몇 개 봅시다.

### 예제

```dart
Container(color: Colors.red)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-1-fb8690f6afa0b5be2482b2d3bfa25e6f8e0ce1b8071e0ecc1a955483f64a4e0f.png>
</p>

스크린이 이 컨테이너의 부모이고, 스크린은 tight 제한이니 스크린 전부를 채우도록
컨테이너가 확장됩니다.

```dart
Container(width: 100, height: 100, color: Colors.red)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-2-fb8690f6afa0b5be2482b2d3bfa25e6f8e0ce1b8071e0ecc1a955483f64a4e0f.png>
</p>

컨테이너가 (100, 100) 크기를 가지고 싶어하지만 소용없습니다.
스크린의 제한을 이기지 못하고 스크린 전부를 채웁니다.

```dart
Center(
   child: Container(width: 100, height: 100, color: Colors.red)
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-3-df5731994b8421e33b6ad257760fecd642e09e84bceab888c894cca76701273b.png>
</p>

센터는 스크린을 채웁니다. 센터는 loose 제한이므로 컨테이너는 원하는 크기를
가질 수 있습니다.

```dart
Align(
   alignment: Alignment.bottomRight,
   child: Container(width: 100, height: 100, color: Colors.red),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-4-3ebf906d14afdb521d897c9c5f6e36ad31444e499c3fc43bfa63b7f5c95acbdc.png>
</p>

얼라인은 스크린을 채웁니다. 또한 loose 제한이므로 컨테이너는 원하는 크기를
가지고, 우측 하단에 배치됩니다.

```dart
Center(
   child: Container(
      color: Colors.red,
      width: double.infinity,
      height: double.infinity,
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-5-b34df2c23d906b88a230a4b6425aab18516e7f7ec8b65ce765113e6d31a3ebeb.png>
</p>

센터는 스크린을 채우고, 컨테이너는 크기 무한을 원하나 최대 제한에 걸립니다.
따라서 컨테이너는 센터를 채웁니다.

```dart
Center(child: Container(color: Colors.red))
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-6-fb70ac7fed5b51cc8902da4bf4b4427affe182508e73c6cd6003b9cc81c16eb6.png>
</p>

센터는 스크린을 채우고(이제 생략하겠습니다) 컨테이너는 원하는 크기가 없습니다.
이때 컨테이너는 가능한 최대 크기로 채워집니다.
그 이유는 그냥 그렇게 구현되어서 그렇습니다.
[doc](https://api.flutter.dev/flutter/widgets/Container-class.html)를 참조하세요.

```dart
Center(
   child: Container(
      color: Colors.red,
      child: Container(color: Colors.green, width: 30, height: 30),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-7-9c42d813b165ab5a18849316e597b0d3784c7dade87a11baa3f92c034207d8b6.png>
</p>

이번 컨테이너는 자식이 있습니다. 따라서 바깥 컨테이너는 자식과 같은 크기가
되기를 원합니다. 그 이유는 그냥 그렇게 구현되어서 그렇습니다.
따라서 자식은 센터가 주는 최대 크기를 제한으로 가지고, 마침 원하는 크기가
잘 부합하니 (30, 30)을 가집니다. 부모 컨테이너도 그에 맞춰 (30, 30)이
됩니다. 중요한 점은, 자식 위젯이 나중에 그려지기 때문에 빨간 것은 가려집니다.

```dart
Center(
   child: Container(
     color: Colors.red,
     padding: const EdgeInsets.all(20.0),
     child: Container(color: Colors.green, width: 30, height: 30),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-8-921cec73226d7778ff10b7424ad3d90088361e417e69790b12b471332be85fdf.png>
</p>

위랑 같지만 패딩으로 20픽셀이 추가되었습니다. 따라서 자식보다 양 방향으로
20픽셀 큰 (70, 70)이 부모 컨테이너의 크기가 됩니다.

```dart
ConstrainedBox(
   constraints: BoxConstraints(
      minWidth: 70,
      minHeight: 70,
      maxWidth: 150,
      maxHeight: 150,
   ),
   child: Container(color: Colors.red, width: 10, height: 10),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-9-0fdac80cd5d63906e0af3dc1574fb79f22577cf69cfc0a17b3823f5b2bfa999c.png>
</p>

`ConstrainedBox`의 제한 사항을 따라간다고 생각하는 실수를 할 수 있습니다.
그러나 그것은 단지 부모의 제한 사항에 추가적으로 붙는 것이기 때문에, 화면
전체를 채우라는 제한 사항이 우선됩니다. 따라서 컨테이너는 스크린을 가득
채웁니다.

```dart
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
         minWidth: 70,
         minHeight: 70,
         maxWidth: 150,
         maxHeight: 150,
      ),
      child: Container(color: Colors.red, width: 10, height: 10),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-10-2c9c649734ece975f3b3657a1bc2a0f68b40ef8b685281a3bbea3902f1dbf550.png>
</p>

이제 센터로 인해 loose 제한을 받게 됩니다. `ConstrainedBox`의 하한을 지켜야
하기 때문에 컨테이너는 원하는 크기 대신 (70, 70)을 채우게 됩니다.

```dart
Center(
  child: ConstrainedBox(
     constraints: BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
        ),
     child: Container(color: Colors.red, width: 1000, height: 1000),
  )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-11-0115f92a631039f739b875ebbad4ffe1fbedfd3f349a091d880702e313abd8af.png>
</p>

위와 같지만 크기가 상한을 넘은 것이 다릅니다. 따라서 상한인 (150, 150)을 채우게
됩니다.

```dart
Center(
   child: ConstrainedBox(
      constraints: BoxConstraints(
         minWidth: 70,
         minHeight: 70,
         maxWidth: 150,
         maxHeight: 150,
      ),
      child: Container(color: Colors.red, width: 100, height: 100),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-12-0f2cb699dde20b1806865a05eb84b2d3965383848ce3f672007fcab9b5c4f7ca.png>
</p>

위와 같지만 크기가 제한에 부합합니다. 따라서 (100, 100)을 채우게 됩니다.

```dart
UnconstrainedBox(
   child: Container(color: Colors.red, width: 20, height: 50),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-13-4af5c2b2ce474423788afea331d3986b91d0e6ef7223eee26aec94c2d7ad636d.png>
</p>

`UnconstrainedBox`는 제한을 없애버립니다. 따라서 (20, 50)을 채웁니다.

```dart
UnconstrainedBox(
   child: Container(color: Colors.red, width: 4000, height: 50),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-14-085dca2bee09a89166cb9a4ba6282a34390b17df385d5197a72862ddc0f5b9ae.png>
</p>

위와 같지만 가로가 너무 큰 것이 다릅니다. 부모는 제한을 완전히 없애버렸으니,
컨테이너는 저 크기를 가지게 되고, 화면을 뚫어버립니다.

양 옆 빗금은 위젯이 크기를 뚫어버렸다는 표시입니다.

```dart
OverflowBox(
   minWidth: 0.0,
   minHeight: 0.0,
   maxWidth: double.infinity,
   maxHeight: double.infinity,
   child: Container(color: Colors.red, width: 4000, height: 50),
);
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-15-65ec6b539407249cf4c9bbb5f89c0b03e41daa35ff1b6165cdf2888736438523.png>
</p>

위랑 비슷하지만 `OverflowBox`는 위와 같은 경고를 표시하지 않습니다.

```dart
UnconstrainedBox(
   child: Container(
      color: Colors.red,
      width: double.infinity,
      height: 100,
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-16-c13febe7293ed75b30fbf0bf8c5a9e332f84ac5658dcefb18c22b95a9e3b87ec.png>
</p>

제대로 보신 겁니다! 여기서 컨테이너는 가로 크기가 무한합니다. 플러터는 무한한
크기의 위젯을 렌더링할 수 없습니다. 따라서 콘솔에 에러가 뜰 겁니다.

`BoxConstraints forces an infinite width.`

```dart
UnconstrainedBox(
   child: LimitedBox(
      maxWidth: 100,
      child: Container(
         color: Colors.red,
         width: double.infinity,
         height: 100,
      )
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-17-df5731994b8421e33b6ad257760fecd642e09e84bceab888c894cca76701273b.png>
</p>

이제 `LimitedBox`로 인해 가로 최대 크기가 100이 되었습니다. 따라서 컨테이너는
(100, 100)을 채우게 됩니다.

`LimitedBox`와 `ConstrainedBox`의 차이점은 전자는 제한이 무한일 때에만
적용되고, 후자는 이미 있는 제한에 추가된다는 것입니다.

```dart
FittedBox(
   child: Text('Some Example Text.'),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-18-0107b2fe23a694309f30dc304f82e79f4c57df0d3bebdcf95a123fc849803b9e.png>
</p>

텍스트가 폰트, 글꼴 등을 고려해 자기 크기를 다 정한 후에 부모에게 알려줍니다.
이때 부모는 텍스트를 그대로 확대시켜서 자기에게 맞추도록 합니다.

```dart
Center(
   child: FittedBox(
      child: Text('Some Example Text.'),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-19-c4f402392c3f58be9e4736c6f25f56e46de18676ea0747397e7d6f6f38002766.png>
</p>

피팃박스는 loose제한을 받습니다. 따라서 텍스트의 크기와 같아집니다.

```dart
Center(
   child: FittedBox(
      child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.'),
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-20-ea5c674f367efd08d70d26dc58b8236bbfd9288d1e1f98c73e6ada0c35e536d6.png>
</p>

텍스트가 스크린보다 큽니다. 피팃박스는 텍스트의 크기를 알아냈지만, 자기가 가질 수 있는 최대 크기보다 크다는 것을 깨닫습니다. 따라서 피팃박스는 텍스트를 그대로 축소시킵니다.

```dart
Center(
   child: Text('This is some very very very large text that is too big to fit a regular screen in a single line.'),
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-21-c2e996b3279017121e858c22e54ae31c2fb16e2fb08c6a4c70c22159e9701b02.png>
</p>

이 경우에는 텍스트가 이전과 달리 한 줄로 출력되지 않고 크기 제한에 맞춰 줄바꿈을
알아서 삽입합니다. 따라서 피팃박스는 제한이 무한임을 알 수 있습니다.

```dart
FittedBox(
   child: Container(
      height: 20.0,
      width: double.infinity,
   )
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-22-b0b49b714b8a6eff6a96cf6a9786b0a3fab4e6729178622e4813160c72040fb2.png>
</p>

피팃박스는 무한한 크기가 아닌 위젯만 받을 수 있습니다. 따라서 이 경우는 자식이
무한하게 크므로 렌더링이 안되고, 오류가 뜰 것입니다.

```dart
Row(
   children:[
      Container(color: Colors.red, child: Text('Hello!')),
      Container(color: Colors.green, child: Text('Goodbye!')),
   ]
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-23-fe00e3ffac04946864dfc966a27a48848d148028c442b13790995fca80e5b261.png>
</p>

`Row`는 자식에게 무한 제한을 주고 자식이 크기를 정하면 그것을 가로로 이어붙입니다.
이때 남은 공간은 그냥 빈 공간이 됩니다.

```dart
Row(
   children:[
      Container(color: Colors.red, child: Text('This is a very long text that won’t fit the line.')),
      Container(color: Colors.green, child: Text('Goodbye!')),
   ]
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-24-4454bdbd965fee9a822e75685e8ee7b5225b89e751c13a99a30e99690a124b5e.png>
</p>

제한이 무한이니, 자식이 크기를 뚫어버릴 수 있습니다. 이때도 경고가 표시됩니다.

```dart
Row(
   children:[
      Expanded(
         child: Container(color: Colors.red, child: Text('This is a very long text that won’t fit the line.'))
      ),
      Container(color: Colors.green, child: Text('Goodbye!')),
   ]
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-25-49b4e8dfe3d26ff2b9ffe95b7e6c63fb7065851c64be464e8d699689fd3f1027.png>
</p>

여기서 Flex 개념이 등장합니다. `Row`, `Column`과 같은 것은 Flex를 사용하는데,
`Flexible` 또는 `Expanded`가 해당됩니다. Flex가 아닌 것을 먼저 배치하고, 그 후
남는 공간을 전부, 혹은 비율에 맞춰 Flex에게 줍니다. 따라서 이 경우에는 Goodbye!가
먼저 배치된 후 `Expanded`가 남은 가로를 전부 차지합니다. `Expanded`는 가로 제한이
tight하므로, 텍스트가 자동적으로 줄바꿈되어 있는 것을 볼 수 있습니다.

```dart
Row(
   children:[
      Expanded(
         child: Container(color: Colors.red, child: Text(‘This is a very long text that won’t fit the line.’)),
      ),
      Expanded(
         child: Container(color: Colors.green, child: Text(‘Goodbye!’),
      ),
   ]
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-26-60f15230f36de8d73f5aae6263869fc11bfe983e083d15066887154728cc63b5.png>
</p>

Flex가 두 개 이상인 경우에는 각각의 flex 비율에 맞춰 공간을 가집니다.
그러나 `Expanded`는 default flex 값이 1이므로, 공간을 반씩 가집니다.

```dart
Row(children:[
  Flexible(
    child: Container(color: Colors.red, child: Text('This is a very long text that won’t fit the line.'))),
  Flexible(
    child: Container(color: Colors.green, child: Text(‘Goodbye!’))),
  ]
)
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-27-70877a21876501a9ea0c2077d8159fe25251b4ec6bae9da918122f8e3a9a4294.png>
</p>

플렉시블은 `Expanded`와 다르게 loose한 가로 제한을 줍니다. 플렉시블과
`Expanded` 둘 다 자기 크기를 정할 때 자식의 가로 크기는 무시합니다.

참고: 이것은 자식의 길이에 따라 확장시키는 것이 블가능하다는 것을 알려줍니다.
`Row`는 자식의 가로 그대로의 크기를 쓰거나 `Expanded` 또는 플랙시블을 통해
완전히 무시합니다.

```dart
Scaffold(
   body: Container(
      color: blue,
      child: Column(
         children: [
            Text('Hello!'),
            Text('Goodbye!'),
         ]
      )))
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-28-cccd3fe6ca8e4c5142bf89d858add639f383a56c90e97e5439b91621c5c01505.png>
</p>

컨테이너는 loose 제한을 받았습니다. 또한 `Scaffold`는 `body`를 좌상단에
배치합니다.

```dart
Scaffold(
body: SizedBox.expand(
   child: Container(
      color: blue,
      child: Column(
         children: [
            Text('Hello!'),
            Text('Goodbye!'),
         ],
      ))))
```

<p align="center">
    <img src=https://flutter.dev/assets/ui/layout/layout-29-aa278887b434649b7dd5d1e3d71782cfa501371c57703f7494af9497b59fc2ee.png>
</p>

`Sizedbox.expand`는 최대 제한을 받아 tight 제한으로 바꿉니다. 따라서 항상
주어진 최대 크기로 그려지게 됩니다.

### Tight 제한과 Loose 제한

Tight 제한은 가로와 세로 모두 최대와 최소가 동일한 제한입니다.

Loose 제한은 가로와 세로 모두 최소가 0인 제한입니다.
