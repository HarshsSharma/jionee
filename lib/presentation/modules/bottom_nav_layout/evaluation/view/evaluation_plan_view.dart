// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/styles/colors.dart';
import '../../../../../common/styles/themes.dart';
import '../../../../../common/widget/my_divider.dart';
import '../../../../router/tab_navigator.dart';
import '../models/employees_data.dart';
import '../view_model/evaluation_view_model.dart';

class EvaluationPlanView extends StatelessWidget {
  const EvaluationPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EvaluationsViewModel>(
      builder: (context, provider, _) {
        return WillPopScope(
          onWillPop: provider.selectedEmployess.isNotEmpty
              ? () async {
                  provider.unSelectAll();
                  return false;
                }
              : null,
          child: Scaffold(
            appBar: provider.selectedEmployess.isNotEmpty
                ? AppBar(
                    title: Text('${provider.selectedEmployess.length}'),
                    leading: IconButton(
                      onPressed: () => provider.unSelectAll(),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  )
                : AppBar(
                    title: const Text('Evaluation Plan Oct 2019'),
                    leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
            endDrawer:
                provider.selectedEmployess.isNotEmpty ? null : const Drawer(),
            body: ListView.separated(
              itemCount: employeesData.length,
              itemBuilder: (context, index) {
                return EvaluationPlanItemBuilder(
                  isSelectionMode: provider.selectedEmployess.isNotEmpty,
                  data: employeesData[index],
                  isSelcted: provider.isSelcted(employeesData[index]),
                  onLongPress: () =>
                      provider.addToSelectedEmployess(employeesData[index]),
                  onTap: () {
                    provider.selectEmployee(employeesData[index]);
                    Navigator.pushNamed(
                      context,
                      TabNavigatorRoutes.employeesEvaluation,
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => const MyDivider(),
            ),
          ),
        );
      },
    );
  }
}

class EvaluationPlanItemBuilder extends StatelessWidget {
  const EvaluationPlanItemBuilder({
    Key? key,
    required this.data,
    required this.onTap,
    required this.onLongPress,
    required this.isSelcted,
    required this.isSelectionMode,
  }) : super(key: key);
  final EmployeeModel data;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool isSelcted;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      child: ListTile(
        onTap: isSelcted || isSelectionMode ? onLongPress : onTap,
        onLongPress: isSelcted ? null : onLongPress,
        leading: CircleAvatar(
          radius: 21.0,
          backgroundColor: isSelcted ? AppColors.selectedCircleColor : null,
          child: isSelcted ? const Icon(Icons.done, size: 30.0) : null,
        ),
        title: Text(
          data.name,
          style: evTitle(context),
        ),
        subtitle: Text(
          data.jobTitle,
          style: evSubTitle(),
        ),
        trailing: Text(
          '${data.department}\n${data.country}',
          textAlign: TextAlign.right,
          style: evSubTitle(),
        ),
      ),
    );
  }
}
