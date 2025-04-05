enum Routes {
  splash("/"),
  login("/login"),
  register("/register"),
  home("/home");

  final String path;

  const Routes(this.path);
}
