import 'database_model.dart';

abstract class DatabaseProvider<T extends DatabaseModel> {
  Future<T?> get(int id);
  Future<List<T>?> getAll();
  Future<bool?> update(int id, T model);
  Future<bool?> delete(int id);
  Future<bool?> add(T model);
}
