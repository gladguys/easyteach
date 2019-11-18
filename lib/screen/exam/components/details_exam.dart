import 'package:aluco/model/exam.dart';
import 'package:flutter/material.dart';

class DetailsExam extends StatelessWidget {
  const DetailsExam(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          Wrap(
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                exam.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                exam.description ?? '',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Peso: ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(exam.weight?.toString() ?? ''),
              const SizedBox(width: 16),
              const Text(
                'Data de Aplicação: ',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(exam.examDate?.toString() ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}