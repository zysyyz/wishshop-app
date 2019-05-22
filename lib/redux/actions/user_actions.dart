import '../../models/models.dart';

class GetUserAction {
  final int userId;

  GetUserAction(this.userId);
}
class GetUserSuccessAction {
  final User user;

  GetUserSuccessAction(this.user);
}
class GetUserFailureAction {}
