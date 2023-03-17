import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/enums/employee_evaluation_status.dart';
import '../../../../../common/styles/colors.dart';
import '../../../../../common/styles/themes.dart';
import '../../../../../common/widget/input_text_form_field.dart';
import '../../../../../common/widget/my_divider.dart';
import '../models/employees_data.dart';
import '../view_model/evaluation_view_model.dart';

class EmployeesEvaluationView extends StatelessWidget {
  const EmployeesEvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    EmployeeModel employee =
        Provider.of<EvaluationsViewModel>(context, listen: false)
            .selectedEmployee;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Evaluations'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70.0),
          child: SizedBox(
            height: 70.0,
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              color: Theme.of(context).colorScheme.brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 21.0,
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              employee.name,
                              style: evTitle(context),
                            ),
                            Text(
                              employee.jobTitle,
                              style: evSubTitle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 20.0,
                        color: textThemeColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(EmployeeEvaluationStatus.values.length + 1,
              (index) {
            if (index == EmployeeEvaluationStatus.values.length) {
              return const InputTextFormFieldWidget(
                isRequired: false,
                labelText: 'Comment',
              );
            }
            return EmployeesEvaluationItemBuilder(
              status: EmployeeEvaluationStatus.values[index],
              value: employee.evaluationStatus,
            );
          }),
        ),
      ),
    );
  }
}

class EmployeesEvaluationItemBuilder extends StatelessWidget {
  const EmployeesEvaluationItemBuilder({
    Key? key,
    required this.status,
    required this.value,
  }) : super(key: key);
  final EmployeeEvaluationStatus status;
  final EmployeeEvaluationStatus value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<EmployeeEvaluationStatus>(
          value: status,
          groupValue: value,
          title: Text(
            status.title,
            style: evRegularTitle(context),
          ),
          activeColor: AppColors.green,
          onChanged: (value) {},
        ),
        const MyDivider(),
      ],
    );
  }
}
