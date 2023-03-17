import 'package:flutter/material.dart';

import '../../../../../common/styles/colors.dart';
import '../../../../../common/styles/themes.dart';
import '../../../../router/tab_navigator.dart';
import '../models/evaluation_monthly_data.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluations'),
      ),
      endDrawer: const Drawer(),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: monthlyEvData.length,
        itemBuilder: (context, index) {
          return EvaluationViewItemBuilder(
            data: monthlyEvData[index],
            onTap: () {
              Navigator.pushNamed(
                context,
                TabNavigatorRoutes.evaluationPlan,
              );
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      ),
    );
  }
}

class EvaluationViewItemBuilder extends StatelessWidget {
  const EvaluationViewItemBuilder({
    Key? key,
    required this.onTap,
    required this.data,
  }) : super(key: key);
  final VoidCallback onTap;
  final MonthlyEvaluationData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.boGrey,
            width: 1,
          ),
          color: Theme.of(context).colorScheme.brightness == Brightness.dark
              ? AppColors.darkModePrimaryColor
              : Colors.white,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.month,
              style: evTitle(context),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.title,
                  style: evSubTitle(),
                ),
                Text(
                  '${data.percent.round()}%',
                  style: evHintTitle(context),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            LinearProgressIndicator(
              backgroundColor: AppColors.boGrey,
              color: AppColors.boGreen,
              value: data.percent / 100,
            ),
          ],
        ),
      ),
    );
  }
}
