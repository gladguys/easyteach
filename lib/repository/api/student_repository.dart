import 'package:aluco/model/student.dart';

import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/core/abstract_student_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class StudentRepository implements AbstractStudentRepository {
  final _dio = DioBuilder.getDio();

  @override
  Future<List<Student>> getAll() async {
    try {
      final response = await _dio.get<dynamic>(STUDENT);
      return List.generate(
        response.data.length,
        (i) => Student.fromJson(
          response.data[i],
        ),
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> save(Student student) async {
    try {
      if (student.id == null) {
        await _dio.post<dynamic>(STUDENT, data: student.toJson());
      } else {
        await _dio.put<dynamic>(STUDENT, data: student.toJson());
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await _dio.delete<dynamic>('$STUDENT/$id');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}