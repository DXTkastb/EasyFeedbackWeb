class UserLoggedInData {
  final int _id;
  final String _name;

  const UserLoggedInData(
    this._id,
    this._name,
  );

  String get name => _name;

  int get id => _id;
}
