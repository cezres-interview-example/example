part of 'human_resources_metrics_bloc.dart';

sealed class HumanResourcesMetricsEvent {}

final class EditEmployeeHiringData extends HumanResourcesMetricsEvent {
  EditEmployeeHiringData(this.data);
  final EmployeeHiringData data;
}

final class EditEmployeeHiringData2 extends HumanResourcesMetricsEvent {
  EditEmployeeHiringData2(this.data);
  final EmployeeHiringData data;
}

final class EditAverageYearsAtCompany extends HumanResourcesMetricsEvent {
  EditAverageYearsAtCompany(this.value);
  final double value;
}

final class EditAverageEmployeeAge extends HumanResourcesMetricsEvent {
  EditAverageEmployeeAge(this.value);
  final double value;
}

final class EditAverageMonthlyOvertimeHours extends HumanResourcesMetricsEvent {
  EditAverageMonthlyOvertimeHours(this.value);
  final double value;
}

final class EditAverageWorkersOver60Hours extends HumanResourcesMetricsEvent {
  EditAverageWorkersOver60Hours(this.value);
  final int value;
}

final class EditPaternityLeaveRate extends HumanResourcesMetricsEvent {
  EditPaternityLeaveRate(this.index, this.rate);
  final int index;
  final ParentalLeaveRate rate;
}

final class EditMaternityLeaveRate extends HumanResourcesMetricsEvent {
  EditMaternityLeaveRate(this.index, this.rate);
  final int index;
  final ParentalLeaveRate rate;
}

final class RemovePaternityLeaveRate extends HumanResourcesMetricsEvent {
  RemovePaternityLeaveRate(this.index);
  final int index;
}

final class RemoveMaternityLeaveRate extends HumanResourcesMetricsEvent {
  RemoveMaternityLeaveRate(this.index);
  final int index;
}

final class AddPaternityLeaveRate extends HumanResourcesMetricsEvent {
  AddPaternityLeaveRate(this.rate);
  final ParentalLeaveRate rate;
}

final class AddMaternityLeaveRate extends HumanResourcesMetricsEvent {
  AddMaternityLeaveRate(this.rate);
  final ParentalLeaveRate rate;
}
