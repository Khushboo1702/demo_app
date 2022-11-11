import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/modules/cart_module/repository/cartRepo.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc {
  CartRepo repo = CartRepo();
  final _subject = BehaviorSubject<int>.seeded(
    0,
  );
  final _ListSubject = BehaviorSubject<List<Data>>();

  ValueStream<int> get addedCounterStream => _subject.stream;

  void dispose() {
    _subject.close();
  }

  void plus() {
    var value = _subject.value;
    print(value);
    _subject.add(++value);
  }

  void del() {
    var temp = _subject.value;
    print(temp);
    _subject.add(--temp);
  }

  ValueStream<List<Data>> get addProductToStream => _ListSubject.stream;

  Future<void> addItem(Data data) async {
    List<Data> list = _ListSubject.valueOrNull ?? [];
    final response = await repo.addItem(data);
    _ListSubject.add([...list, response]);
    // final arr = <Data>[];
    // arr.addAll(list);
    // arr.add(response);
    // _ListSubject.add(arr);
  }

//[1, 2, 3, 4, 5]
  Future<void> removeItem(Data data) async {
    List<Data> list2 = _ListSubject.valueOrNull ?? [];
    //list.get(index)
    final response2 = await repo.removeItem(data);
    list2.remove(response2);
    _ListSubject.add(list2);
  }

//TODO: NEEDS TO BE COMPLETED
  Future<void> updateItem(Data data) async {}

  Future<void> getData() async {
    final response3 = await repo.getData();
    _ListSubject.add(response3);
  }
}
