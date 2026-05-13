import 'package:mockito/mockito.dart';
import 'package:mona/services/repository.dart';
import 'package:uuid/uuid.dart';

class GenericRepositoryMock<T extends dynamic> extends Mock
    implements Repository<T> {
  final List<T> _items = [];
  final T Function(T, String) withId;

  GenericRepositoryMock({required this.withId});

  List<T> get items => _items;

  @override
  Future<int> insert(T item) async {
    final id = (item as dynamic).id ?? const Uuid().v4();
    final newItem = withId(item, id);
    _items.add(newItem);
    return 1; // Return value of insert is usually rowId in sqflite, but for mock it's less important
  }

  @override
  Future<void> update(T item, dynamic id) async {
    final index = _items.indexWhere((i) => (i as dynamic).id == id);
    if (index != -1) _items[index] = item;
  }

  @override
  Future<void> delete(dynamic id) async {
    _items.removeWhere((i) => (i as dynamic).id == id);
  }

  @override
  Future<List<T>> getAll() async {
    return List.from(_items);
  }
}
