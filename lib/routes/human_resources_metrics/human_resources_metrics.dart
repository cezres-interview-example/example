import 'package:example/routes/human_resources_metrics/bloc/human_resources_metrics_bloc.dart';
import 'package:example/routes/human_resources_metrics/widget/card.dart';
import 'package:example/routes/human_resources_metrics/widget/parental_leave_rate_card.dart';
import 'package:example/routes/human_resources_metrics/widget/value_editor.dart';
import 'package:example/utils/format_text_for_double.dart';
import 'package:example/widgets/text_fields_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HumanResourcesMetricsPage extends StatelessWidget {
  const HumanResourcesMetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: Column(
            children: _buildItems(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      _buildEditCard(
        context,
        title: '中途採用比率',
        subTitle: '前年度/2年度前/3年度前',
        selector: (state) => state.midCareerHiringRatio,
        builder: (context, state) => Text(
            "${formatTextForDouble(state.lastYear)}%/${formatTextForDouble(state.twoYearsAgo)}%/${formatTextForDouble(state.threeYearsAgo)}%"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.doubleTextField(
            title: '前年度(単位：%)',
            placeholder: '前年度中途採用比率',
            value: state.lastYear,
          ),
          TextFieldsAlertDialogItem.doubleTextField(
            title: '2年度前(単位：%)',
            placeholder: '2年度前中途採用比率',
            value: state.twoYearsAgo,
          ),
          TextFieldsAlertDialogItem.doubleTextField(
            title: '3年度前(単位：%)',
            placeholder: '3年度前中途採用比率',
            value: state.threeYearsAgo,
          ),
        ],
        editEventBuilder: (editValues) => EditEmployeeHiringData(
          EmployeeHiringData(
            lastYear: editValues[0],
            twoYearsAgo: editValues[1],
            threeYearsAgo: editValues[2],
          ),
        ),
      ),
      _buildEditCard(
        context,
        title: '中途採用比率2',
        subTitle: '前年度/2年度前/3年度前',
        selector: (state) => state.midCareerHiringRatio2,
        builder: (context, state) => Text(
            "${formatTextForDouble(state.lastYear)}%/${formatTextForDouble(state.twoYearsAgo)}%/${formatTextForDouble(state.threeYearsAgo)}%"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.doubleTextField(
            title: '前年度(単位：%)',
            placeholder: '前年度中途採用比率',
            value: state.lastYear,
          ),
          TextFieldsAlertDialogItem.doubleTextField(
            title: '2年度前(単位：%)',
            placeholder: '2年度前中途採用比率',
            value: state.twoYearsAgo,
          ),
          TextFieldsAlertDialogItem.doubleTextField(
            title: '3年度前(単位：%)',
            placeholder: '3年度前中途採用比率',
            value: state.threeYearsAgo,
          ),
        ],
        editEventBuilder: (editValues) => EditEmployeeHiringData2(
          EmployeeHiringData(
            lastYear: editValues[0],
            twoYearsAgo: editValues[1],
            threeYearsAgo: editValues[2],
          ),
        ),
      ),
      _buildEditCard(
        context,
        title: '正社員の平均継続勤務年数',
        selector: (state) => state.averageYearsAtCompany,
        builder: (context, state) => Text("${formatTextForDouble(state)}年"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.doubleTextField(
            title: '正社員の平均継続勤務年数',
            value: state,
          ),
        ],
        editEventBuilder: (editValues) =>
            EditAverageYearsAtCompany(editValues.first),
      ),
      _buildEditCard(
        context,
        title: '従業員の平均年齢',
        selector: (state) => state.averageEmployeeAge,
        builder: (context, state) => Text("${formatTextForDouble(state)}歳"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.doubleTextField(
            title: '従業員の平均年齢',
            value: state,
          ),
        ],
        editEventBuilder: (editValues) =>
            EditAverageEmployeeAge(editValues.first),
      ),
      _buildEditCard(
        context,
        title: '月平均所定外労働時間',
        selector: (state) => state.averageMonthlyOvertimeHours,
        builder: (context, state) => Text("${formatTextForDouble(state)}時間"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.doubleTextField(
            title: '月平均所定外労働時間',
            value: state,
          ),
        ],
        editEventBuilder: (editValues) =>
            EditAverageMonthlyOvertimeHours(editValues.first),
      ),
      _buildEditCard(
        context,
        title: '平均の法定時間外労働60時間以上の労働者の数',
        selector: (state) => state.averageWorkersOver60Hours,
        builder: (context, state) => Text("$state人"),
        textFieldsBuilder: (state) => [
          TextFieldsAlertDialogItem.intTextField(
            title: '平均の法定時間外労働60時間以上の労働者の数',
            value: state,
          ),
        ],
        editEventBuilder: (editValues) =>
            EditAverageWorkersOver60Hours(editValues.first),
      ),
      HumanResourcesMetricsParentalLeaveRateCard(
        title: '育児休業取得率（男性）',
        selector: (state) => state.paternityLeaveUtilizationRate,
        editEventBuilder: (index, rate) => EditPaternityLeaveRate(index, rate),
        addEventBuilder: (rate) => AddPaternityLeaveRate(rate),
        removeEventBuilder: (index) => RemovePaternityLeaveRate(index),
      ),
      HumanResourcesMetricsParentalLeaveRateCard(
        title: '育児休業取得率（女性）',
        selector: (state) => state.maternityLeaveUtilizationRate,
        editEventBuilder: (index, rate) => EditMaternityLeaveRate(index, rate),
        addEventBuilder: (rate) => AddMaternityLeaveRate(rate),
        removeEventBuilder: (index) => RemoveMaternityLeaveRate(index),
      ),
    ];
  }

  Widget _buildEditCard<T>(
    BuildContext context, {
    required String title,
    String? subTitle,
    required T Function(HumanResourcesMetricsState state) selector,
    required Widget Function(BuildContext context, T state) builder,
    required List<TextFieldsAlertDialogItem> Function(T state)
        textFieldsBuilder,
    required HumanResourcesMetricsEvent Function(List editValues)
        editEventBuilder,
  }) {
    return HumanResourcesMetricsCard(
      title: title,
      subTitle: subTitle,
      child: HumanResourcesMetricsValueEditor(
        onPressed: () {
          final textFields = textFieldsBuilder(
            selector(context.read<HumanResourcesMetricsBloc>().state),
          );
          showTextFieldsAlertDialog(
            context,
            title: textFields.length > 1 ? title : null,
            items: textFieldsBuilder(
              selector(context.read<HumanResourcesMetricsBloc>().state),
            ),
            onConfirm: (values) {
              final event = editEventBuilder(values);
              context.read<HumanResourcesMetricsBloc>().add(event);
            },
          );
        },
        child: BlocSelector<HumanResourcesMetricsBloc,
            HumanResourcesMetricsState, T>(
          selector: selector,
          builder: builder,
        ),
      ),
    );
  }
}
