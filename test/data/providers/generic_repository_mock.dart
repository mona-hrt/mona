import 'package:mockito/mockito.dart';
import 'package:mona/services/repository.dart';

class GenericRepositoryMock<T extends dynamic> extends Mock
    implements Repository<T> {
  final List<T> _items = [];

  List<T> get items => _items;

  @override
  Future<int> insert(T item) async {
    _items.add(item);
    return (item as dynamic).id;
  }

  @override
  Future<void> update(T item, int id) async {
    final index = _items.indexWhere((i) => (i as dynamic).id == id);
    if (index != -1) _items[index] = item;
  }

  @override
  Future<void> delete(int id) async {
    _items.removeWhere((i) => (i as dynamic).id == id);
  }

  @override
  Future<List<T>> getAll() async {
    return List.from(_items);
  }
}
