import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/enums/call_status.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/model/student_absence.dart';
import 'package:aluco/model/student_call.dart';
import 'package:aluco/repository/api/call_repository.dart';
import 'package:aluco/repository/api/class_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends BlocBase {
  final dateController = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final studentsCallController = BehaviorSubject<List<StudentCall>>.seeded([]);
  final studentsAbsencesController =
      BehaviorSubject<List<StudentAbsence>>.seeded([]);
  final _classRepository = G<ClassRepository>();
  final _callRepository = G<CallRepository>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> initializeClassStudentsFromDate(
      int classId, DateTime callDate) async {
    studentsCallController.add([]);
    final studentsCalls = <StudentCall>[];
    try {
      final date = dateFormat.format(callDate);
      final callsOnDate =
          await _callRepository.getClassStudentsCallOnDate(classId, date);

      final classStudents = await _classRepository.getStudentsByClass(classId);

      if (callsOnDate == null || callsOnDate.isEmpty) {
        for (Student student in classStudents) {
          studentsCalls.add(
            StudentCall(
              classId: classId,
              studentName: student.name,
              date: date,
              status: CallStatus.NENHUMA,
              studentId: student.id,
            ),
          );
        }
      } else {
        studentsCalls.addAll(callsOnDate);
        final studentCallIds =
            studentsCalls.map((studentCall) => studentCall.studentId).toList();
        final studentsWithNoCall = classStudents
            .where((classStudent) => !studentCallIds.contains(classStudent.id));
        for (Student student in studentsWithNoCall) {
          studentsCalls.add(
            StudentCall(
              classId: classId,
              studentName: student.name,
              date: date,
              status: CallStatus.NENHUMA,
              studentId: student.id,
            ),
          );
        }
      }
      studentsCallController.add(studentsCalls);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> initClassAbsences(int classId) async {
    studentsAbsencesController.add(await _classRepository.getAbsences(classId));
  }

  Future<List<StudentCall>> getClassStudentsCallOnDate(
      int classId, String date) {
    return _callRepository.getClassStudentsCallOnDate(classId, date);
  }

  Future<void> handleStudentCallChanged(StudentCall student, int status) async {
    try {
      final studentsCalls = studentsCallController.value;
      final index =
          studentsCalls.indexWhere((studentCall) => studentCall == student);
      final copyStudent = studentsCalls[index];

      final newStudentCall = StudentCall(
          studentId: copyStudent.studentId,
          studentName: copyStudent.studentName,
          status: getCallStatusFromInt(status),
          date: copyStudent.date,
          classId: copyStudent.classId,
          id: copyStudent.id);
      studentsCalls.removeAt(index);
      studentsCalls.insert(index, newStudentCall);

      await _callRepository.changeStudentCall(newStudentCall);
      studentsCallController.add(studentsCalls);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    dateController.close();
    super.dispose();
  }
}
