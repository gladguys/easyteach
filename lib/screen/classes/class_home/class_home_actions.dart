import 'package:aluco/screen/classes/class_home/class_students/class_students_screen.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ClassHomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'users',
                  weight: IconWeight.Solid,
                ),
                text: 'Alunos da Turma',
                route: ClassStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'history',
                  weight: IconWeight.Solid,
                ),
                text: 'Histórico de Chamadas',
                route: ListStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'clipboard-list',
                  weight: IconWeight.Solid,
                ),
                text: 'Quadro de Notas',
                route: ListStudentsScreen(),
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'book',
                  weight: IconWeight.Solid,
                ),
                text: 'Planos de Aulas',
                route: ListStudentsScreen(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}