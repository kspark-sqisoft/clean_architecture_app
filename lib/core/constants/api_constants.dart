/// API 엔드포인트 상수
///
/// **역할:**
/// - API 경로를 한 곳에서 관리합니다
/// - 하드코딩을 방지하고 유지보수를 쉽게 합니다
class ApiConstants {
  // Base paths
  static const String todos = '/todos';
  static const String products = '/products';
  static const String auth = '/auth';
  static const String users = '/users';

  // Todo endpoints
  static String todoById(int id) => '$todos/$id';
  static String todosByUser(int userId) => '$todos/user/$userId';
  static const String addTodo = '$todos/add';
  static const String randomTodo = '$todos/random';

  // Product endpoints
  static String productById(int id) => '$products/$id';
  static String productsByCategory(String category) =>
      '$products/category/$category';
  static const String productCategories = '$products/categories';
  static const String productCategoryList = '$products/category-list';
  static const String addProduct = '$products/add';
  static String searchProducts(String query) => '$products/search?q=$query';

  // Auth endpoints
  static const String login = '$auth/login';
  static const String refresh = '$auth/refresh';
  static const String me = '$auth/me';
}
