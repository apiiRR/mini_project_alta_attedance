import 'package:mini_project_alta_attedance/models/api/data_api.dart';
import 'package:mini_project_alta_attedance/view_model/auth_view_model.dart';
import 'package:test/test.dart';

void main() {
  var auth = AuthViewModel();
  test('get all data', () async {
    final signin =
        await auth.signIn("ramadhanarafi437@gmail.com", "083866379756");
    if (signin == true) {
      final datas =
          DataAPI.getData(auth.token, auth.userId) as Map<String, dynamic>;
      expect(datas.isNotEmpty, true);
    }
  });
}
