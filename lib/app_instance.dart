

class AppInstance 
{
  static final AppInstance instance = AppInstance._internal();
  factory AppInstance() { return instance; }
  AppInstance._internal();
}
