import 'dart:async';

import 'package:example/routes/human_resources_metrics/bloc/human_resources_metrics_bloc.dart';
import 'package:example/routes/human_resources_metrics/widget/card.dart';
import 'package:example/routes/human_resources_metrics/widget/value_editor.dart';
import 'package:example/utils/format_text_for_double.dart';
import 'package:example/widgets/global_text_fields_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HumanResourcesMetricsParentalLeaveRateCard extends StatelessWidget {
  const HumanResourcesMetricsParentalLeaveRateCard({
    super.key,
    required this.title,
    required this.selector,
    required this.editEventBuilder,
    required this.removeEventBuilder,
    required this.addEventBuilder,
  });

  final String title;
  final List<ParentalLeaveRate> Function(HumanResourcesMetricsState state)
      selector;
  final HumanResourcesMetricsEvent Function(int index, ParentalLeaveRate rate)
      editEventBuilder;
  final HumanResourcesMetricsEvent Function(int index) removeEventBuilder;
  final HumanResourcesMetricsEvent Function(ParentalLeaveRate rate)
      addEventBuilder;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HumanResourcesMetricsBloc>();
    final widget = BlocSelector<HumanResourcesMetricsBloc,
        HumanResourcesMetricsState, int>(
      selector: (state) => selector(state).length,
      builder: (context, state) {
        final items = <Widget>[];
        final list = selector(bloc.state);
        for (var i = 0; i < list.length; i++) {
          if (i != 0) {
            items.add(Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 6),
              child: Container(
                width: 217,
                height: 1,
                color: Colors.grey[300],
              ),
            ));
          }
          items.add(_buildItemWidget(context, i, bloc));
        }

        items.add(Padding(
          padding: EdgeInsets.only(top: state == 0 ? 6 : 16, right: 6),
          child: HumanResourcesMetricsValueEditor(
            width: 217,
            showEditIcon: false,
            child: SizedBox(
              height: 20,
              child: Center(
                child: Image.asset(
                  'assets/images/icon_plus.png',
                  width: 8,
                  height: 8,
                ),
              ),
            ),
            onPressed: () {
              _showEditDialog(context, null).then((value) {
                bloc.add(addEventBuilder(value));
              }).onError((error, stackTrace) {
                //
              });
            },
          ),
        ));

        return Column(children: items);
      },
    );
    return HumanResourcesMetricsCard(
      title: title,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 12),
      child: widget,
    );
  }

  Widget _buildItemWidget(
    BuildContext context,
    int index,
    HumanResourcesMetricsBloc bloc,
  ) {
    final child = BlocSelector<HumanResourcesMetricsBloc,
        HumanResourcesMetricsState, ParentalLeaveRate?>(
      selector: (state) =>
          selector(state).length <= index ? null : selector(state)[index],
      builder: (context, state) => Row(
        children: [
          Text(state?.type ?? ''),
          Expanded(
            child: Text(
              '${formatTextForDouble(state?.rate ?? 0)}%',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
    return HumanResourcesMetricsValueEditor(
      width: 217,
      onPressed: () {
        _showEditDialog(context, selector(bloc.state)[index]).then((value) {
          bloc.add(editEventBuilder(
              index, ParentalLeaveRate(type: value.type, rate: value.rate)));
        }).onError((error, stackTrace) {
          debugPrint('$error');
        });
      },
      onDeletePressed: () {
        bloc.add(removeEventBuilder(index));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
    );
  }

  Future<ParentalLeaveRate> _showEditDialog(
    BuildContext context,
    ParentalLeaveRate? parentalLeaveRate,
  ) {
    final completer = Completer<ParentalLeaveRate>();
    showGlobalTextFieldsAlertDialog(
      context,
      title: title,
      items: [
        GlobalTextFieldsItem.stringTextField(
            title: '職種',
            placeholder: '職種を入力してください',
            value: parentalLeaveRate?.type),
        GlobalTextFieldsItem.doubleTextField(
          title: '割合(単位：%)',
          placeholder: '割合を入力してください',
          value: parentalLeaveRate?.rate,
        ),
      ],
      onConfirm: (values) {
        completer.complete(ParentalLeaveRate(
          type: values[0],
          rate: values[1],
        ));
      },
    ).whenComplete(() {
      if (!completer.isCompleted) {
        completer.completeError('Canceled');
      }
    });
    return completer.future;
  }
}
