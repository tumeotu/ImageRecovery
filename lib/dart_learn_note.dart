
/// --------- Một số vấn đề khi về Dart --------------
void main() {
  /// gán giá trị vào chuỗi
  int dautien = 1, thuhai = 2;
  var str = "con so thu ${dautien + thuhai} $thuhai";
  ///------------------------------

  /// Non-dynamic data type (var)
  var b = 1; // khi gán = 1, thì nó sẽ được set là type int
  //b = 1.5;  // Error: A value of type 'double' can't be assigned to a variable of type 'int'
  // Create a function that adds 2.
  //var add2 = makeAdder(2); // lúc này add2 được gán type là function makeAdder(2);
  // và có thể sử dụng print(add2(3)); như 1 function
  ///------------------------------

  /// dynamic data type (dynamic)
  dynamic a= 1;
  a = 1.5;
  ///------------------------------

  /// assert xử dụng như if nhưng khi điều kiện sai nó sẽ throw
  assert(a != null);

  /// Null-aware
  print(null ?? 'Trả về chính nó nếu khác null hoặc trả về dòng này');

  var x = null;
  x ??= 'Syntax sugar của `x = x ?? "Viết gì vào đây bây giờ"`';
  print(x);

  var isNull = null;
  print(isNull?.foo()); // Nếu null thì không thực hiện foo() nữa mà trả về `null`
  ///------------------------------

  ///có thể lồng hàm vào trong hàm
  int thaydoigiatri(int a) {
    a += 2;
    return a;
  }

  a = thaydoigiatri(a);
  ///------------------------------

  /// cách đặt tên
  ///khai báo private _a hay void _concho()
  /// class, enum, tham số: kiểu UpperCamelCase
  /// tên file, library: chữ thường, nối nhau dấu gạch dưới (_)
  /// biến, hằng, object: lowerCamelCase
  ///------------------------------

  /// hằng số:
  /// const là hằng số khi biên dịch không thể gán biến giá trị được
  /// final là hằng số khi được gọi đến
  const conso1 = 10;
  final conso2 = 10 + conso1;
  ///------------------------------

  /// Map: (key, value);

  var mangMap = {"T2": "Thu hai", "T3": "Thu ba"};

  print(mangMap.length);
  var t2 = mangMap["T2"];
  mangMap.putIfAbsent("T5", () => "Thu nam");

  ///------------------------------

  /// phép tính
  /// ~/ lấy phần nguyên
  /// % lấy phần dư
  /// a as conso
  ///------------------------------

  /// vòng lặp
  /// for (var i = 0; i < arr.length - 1; i ++)
  /// for (var item in arr)
  ///------------------------------

  /// lambda or closure
  var x1 = (var a, var b) {
    return a + b;
  }(2, 3);
  var y = (var a, var b) {
    return a - b;
  };
  var z = (var a, var b) => a * b;
  ///------------------------------

  /// khi sử dụng factory tương đương với instance
  /// Chúng ta sử dụng factory khi muốn tạo constructor không chỉ để tạo ra một instance mới của class
  /// mà có thể một instance từ cache, hoặc một subtype instance.
  Singleton._internal().myFunction();
  ///------------------------------

  ///Type test operators
  ///as Operator dùng để ép kiểu
  /// is Return True nếu type checking là đúng
  /// is! Return False nếu type checking là sai
  ///------------------------------

  /// Cascade notation (..)
  /// Nếu không dùng cascade:
  /// var button = querySelector('#confirm');
  /// button.text = 'Confirm';
  /// button.classes.add('important');
  /// button.onClick.listen((e) => window.alert('Confirmed!'));
  /// Sau khi dùng cascade:
  /// querySelector('#confirm')
  /// ..text = 'Confirm' // Use its members.
  /// ..classes.add('important')
  /// ..onClick.listen((e) => window.alert('Confirmed!'));


}
/// cách khai báo Singleton = factory
class Singleton {
  static final Singleton _singleton = new Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
  factory Singleton.next(Singleton prev) => Singleton();

  var insideMain = true;

  ///Nghĩa là "scope" phạm vi của một variable được xác định tĩnh, dựa trên "layout" cấu trúc của code.
  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      /// bên trong đây vẫn gọi được theo cấu trúc code
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }



}


