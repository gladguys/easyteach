import 'package:aluco/model/class.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:aluco/repository/api/class_repository.dart';

class GradeBoardBloc {
  final _classRepository = ClassRepository(CLASS, Class());

  Future<List<StudentGrades>> getGradesBoard(int classId) async {
    try {
      return await _classRepository.getGradesBoard(classId);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}