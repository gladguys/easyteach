import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/core/abstract_call_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:dio/dio.dart';

import 'API.dart';

class CallRepository implements AbstractCallRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date) async {
    try {
      final response =
          await _dio.get<dynamic>('$CALL/$SINGLE_CLASS/$classId?$DATE=$date');
      return List.generate(response.data.length,
          (int i) => StudentCall.fromJson(response.data[i]));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StudentCall> changeStudentCall(StudentCall studentCall) async {
    Response response;
    try {
      if (studentCall.id == null) {
        response = await _dio.post<dynamic>(CALL, data: studentCall.toJson());
      } else {
        response = await _dio.put<dynamic>(CALL, data: studentCall.toJson());
      }
      return StudentCall.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentCall>> getStudentCalls(int studentId, int classId) async {
    try {
      final response = await _dio
          .get<dynamic>('$CALL/$SINGLE_STUDENT/$studentId?classId=$classId');
      return List.generate(response.data.length,
          (int i) => StudentCall.fromJson(response.data[i]));
    } catch (e) {
      rethrow;
    }
  }
}
