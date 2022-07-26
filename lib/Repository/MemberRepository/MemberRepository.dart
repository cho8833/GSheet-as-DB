import 'package:test_application/Model/MemberModel.dart';

abstract class MemberRepository {
  Future<List<Member>> getAllMember();
}
