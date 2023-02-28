// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/extensions/data_formates.dart';
import '../../../../styles/colors.dart';
import '../../../../widget/input_text_form_field.dart';
import '../view_model/time_off_view_model.dart';

class TimeOffItemDetails extends StatelessWidget {
  const TimeOffItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TimeOffViewModel data = Provider.of<TimeOffViewModel>(context);
    Duration duration =
        data.selectedRequest.endData.difference(data.selectedRequest.startData);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Off Requests'),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70.0),
          child: SizedBox(
            height: 70.0,
            width: double.infinity,
            // Programmer Info
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              child: ListTile(
                minLeadingWidth: 5.0,
                leading: const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: AppColors.primaryColor,
                ),
                title: Text(
                  'Mohab Mahmoud',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: const Text('Junior progammer'),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimeOffListTileWidget(
              isRequired: true,
              label: 'Type',
              value: data.selectedRequest.title,
            ),
            const TimeOffListTileWidget(
              isRequired: true,
              label: 'Day Part',
              value: 'Multi Day',
            ),
            TimeOffListTileWidget(
              label: 'Dutarion',
              value:
                  '${duration.inDays} days (${data.selectedRequest.startData.dateFormateToddMMMyy()} - ${data.selectedRequest.endData.dateFormateToddMMMyy()})',
            ),
            const TimeOffListTileWidget(
              isRequired: true,
              label: 'Request Message',
              value: 'Approved by John Smith. Covered by Jane Doe.',
            ),
            TimeOffListTileWidget(
              isRequired: true,
              label: 'Submitted On',
              value: data.selectedRequest.postDate.dateFormateToddMMMyy(),
            ),
            const InputTextFormFieldWidget(
              isRequired: false,
              labelText: 'Enter Comment',
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.0,
        child: Row(
          children: [
            Expanded(
              child: TimeOffActionButton(
                title: 'Dneny',
                onTap: () {},
                color: AppColors.buPurple,
              ),
            ),
            Expanded(
              child: TimeOffActionButton(
                title: 'Approve',
                onTap: () {},
                color: AppColors.buGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------------
class TimeOffActionButton extends StatelessWidget {
  const TimeOffActionButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: color,
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class TimeOffListTileWidget extends StatelessWidget {
  const TimeOffListTileWidget({
    Key? key,
    required this.label,
    required this.value,
    this.isRequired = false,
  }) : super(key: key);

  final String label;
  final String value;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (isRequired)
              Text(
                '*',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Divider(),
        const SizedBox(height: 5.0),
      ],
    );
  }
}
