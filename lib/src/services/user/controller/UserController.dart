import 'package:e_pod/src/components/utils/Request.dart';

class UserController {
  Future<List<Map<String, dynamic>>> getIndexUser() async {
    Map<String, dynamic> params = {};

    params['param[limit]'] = 100;
    params['param[offset]'] = 0;
    params['param[filter]'] = {};
    params['param[order]'] = 'ASC';
    params['param[valid]'] = 1;

    final request = Request(
      endpoint: '/user/api/user/get-index-user', 
      method: 'POST',
      body: params
    );

    final response = await request.fetchData();
    final List users = response['rows'];

    return users.cast<Map<String, dynamic>>();
  }
}
