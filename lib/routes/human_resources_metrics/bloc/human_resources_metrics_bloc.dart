import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'human_resources_metrics_event.dart';
part 'human_resources_metrics_state.dart';

final class HumanResourcesMetricsBloc
    extends Bloc<HumanResourcesMetricsEvent, HumanResourcesMetricsState> {
  HumanResourcesMetricsBloc(super.initialState) {
    on<EditEmployeeHiringData2>(
      (event, emit) => emit(
        state.copyWith(
          midCareerHiringRatio2: event.data,
        ),
      ),
    );

    on<EditEmployeeHiringData>(
      (event, emit) => emit(
        state.copyWith(
          midCareerHiringRatio: event.data,
        ),
      ),
    );

    on<EditAverageYearsAtCompany>(
      (event, emit) => emit(
        state.copyWith(
          averageYearsAtCompany: max(min(event.value, 100), 0),
        ),
      ),
    );

    on<EditAverageEmployeeAge>(
      (event, emit) => emit(
        state.copyWith(
          averageEmployeeAge: max(min(event.value, 100), 0),
        ),
      ),
    );

    on<EditAverageMonthlyOvertimeHours>(
      (event, emit) => emit(
        state.copyWith(
          averageMonthlyOvertimeHours: max(event.value, 0),
        ),
      ),
    );

    on<EditAverageWorkersOver60Hours>(
      (event, emit) => emit(
        state.copyWith(
          averageWorkersOver60Hours: max(event.value, 0),
        ),
      ),
    );

    on<EditPaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          paternityLeaveUtilizationRate: _replaceParentalLeaveRateInList(
              state.paternityLeaveUtilizationRate, event.rate, event.index),
        ),
      ),
    );

    on<EditMaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          maternityLeaveUtilizationRate: _replaceParentalLeaveRateInList(
              state.maternityLeaveUtilizationRate, event.rate, event.index),
        ),
      ),
    );

    on<RemovePaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          paternityLeaveUtilizationRate:
              List<ParentalLeaveRate>.from(state.paternityLeaveUtilizationRate)
                ..removeAt(event.index),
        ),
      ),
    );

    on<RemoveMaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          maternityLeaveUtilizationRate:
              List<ParentalLeaveRate>.from(state.maternityLeaveUtilizationRate)
                ..removeAt(event.index),
        ),
      ),
    );

    on<AddPaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          paternityLeaveUtilizationRate: _appendParentalLeaveRateToList(
            state.paternityLeaveUtilizationRate,
            event.rate,
          ),
        ),
      ),
    );

    on<AddMaternityLeaveRate>(
      (event, emit) => emit(
        state.copyWith(
          maternityLeaveUtilizationRate: _appendParentalLeaveRateToList(
            state.maternityLeaveUtilizationRate,
            event.rate,
          ),
        ),
      ),
    );
  }

  List<ParentalLeaveRate> _replaceParentalLeaveRateInList(
      List<ParentalLeaveRate> list, ParentalLeaveRate rate, int index) {
    if (list[index].type == rate.type) {
      return List<ParentalLeaveRate>.from(list)..[index] = rate;
    }
    final sameTypeIndex =
        list.indexWhere((element) => element.type == rate.type);
    if (sameTypeIndex == -1) {
      return List<ParentalLeaveRate>.from(list)..[index] = rate;
    } else {
      return List<ParentalLeaveRate>.from(list)..[sameTypeIndex] = rate;
    }
  }

  List<ParentalLeaveRate> _appendParentalLeaveRateToList(
      List<ParentalLeaveRate> list, ParentalLeaveRate rate) {
    final sameTypeIndex =
        list.indexWhere((element) => element.type == rate.type);
    if (sameTypeIndex == -1) {
      return [...list, rate];
    } else {
      return List<ParentalLeaveRate>.from(list)..[sameTypeIndex] = rate;
    }
  }
}
