abstract class RepositoryTemplate<T, S> {
  void saveInStorage(T data);

  Future<T?> getData();

  Future<bool> checkData(S checkValue);

  void deleteData();
}
