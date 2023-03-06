import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widget/dropdown_widget.dart';
import '../../../../../common/widget/input_text_form_field.dart';
import '../view_model/time_off_view_model.dart';

class AddTimeOffRequestView extends StatefulWidget {
  const AddTimeOffRequestView({super.key});

  @override
  State<AddTimeOffRequestView> createState() => _AddTimeOffRequestViewState();
}

class _AddTimeOffRequestViewState extends State<AddTimeOffRequestView> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<TimeOffViewModel>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TimeOffViewModel viewModel =
        Provider.of<TimeOffViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Off Request'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              DropDownWidget(
                multiSelection: false,
                data: viewModel.timeOffTypes.map((e) => e.vlaue).toList(),
                isRequired: true,
                labelText: 'Type',
                loadData: () async {
                  return;
                },
                onScrollEnd: (_) async {
                  return;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please, select item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              InputTextFormFieldWidget(
                controller: viewModel.dateController,
                isRequired: true,
                labelText: 'Date',
                validator: (value) {
                  if (value!.isEmpty) {
                    return ';kgjfsk;gs;lfg';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              DropDownWidget(
                multiSelection: false,
                data: const [
                  'Mohab',
                  'Mahmoud',
                  'Mansour',
                  'Ayman',
                  'Eslam',
                  'Ashraf',
                ],
                isRequired: true,
                labelText: 'Names',
                loadData: () async {
                  return;
                },
                onScrollEnd: (_) async {
                  return;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please, select item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    Provider.of<TimeOffViewModel>(context, listen: false).disposeT();
    super.deactivate();
  }
}
