part of 'human_resources_metrics_bloc.dart';

final class HumanResourcesMetricsState {
  const HumanResourcesMetricsState({
    required this.midCareerHiringRatio,
    required this.midCareerHiringRatio2,
    required this.averageYearsAtCompany,
    required this.averageEmployeeAge,
    required this.averageMonthlyOvertimeHours,
    required this.averageWorkersOver60Hours,
    required this.paternityLeaveUtilizationRate,
    required this.maternityLeaveUtilizationRate,
  });

  // 中期招聘比例
  final EmployeeHiringData midCareerHiringRatio;

  // 中期招聘比例2
  final EmployeeHiringData midCareerHiringRatio2;

  // 全职员工平均连续工作年限
  final double averageYearsAtCompany;

  // 员工平均年龄
  final double averageEmployeeAge;

  // 月平均加班时间
  final double averageMonthlyOvertimeHours;

  // 平均法定加班时间超过 60 小时的工人人数
  final int averageWorkersOver60Hours;

  // 育儿假获得率（男性）
  final List<ParentalLeaveRate> paternityLeaveUtilizationRate;

  // 育儿假获得率（女性）
  final List<ParentalLeaveRate> maternityLeaveUtilizationRate;

  factory HumanResourcesMetricsState.example() {
    return HumanResourcesMetricsState(
      midCareerHiringRatio: EmployeeHiringData(
        lastYear: 10,
        twoYearsAgo: 20,
        threeYearsAgo: 30,
      ),
      midCareerHiringRatio2: EmployeeHiringData(
        lastYear: 10,
        twoYearsAgo: 20,
        threeYearsAgo: 30,
      ),
      averageYearsAtCompany: 18.5,
      averageEmployeeAge: 50.5,
      averageMonthlyOvertimeHours: 18,
      averageWorkersOver60Hours: 15,
      paternityLeaveUtilizationRate: [
        ParentalLeaveRate(type: '正社員', rate: 34),
        ParentalLeaveRate(type: '専門職', rate: 50),
      ],
      maternityLeaveUtilizationRate: [
        ParentalLeaveRate(type: '正社員', rate: 34),
        ParentalLeaveRate(type: '専門職', rate: 50),
      ],
    );
  }

  HumanResourcesMetricsState copyWith({
    EmployeeHiringData? midCareerHiringRatio,
    EmployeeHiringData? midCareerHiringRatio2,
    double? averageYearsAtCompany,
    double? averageEmployeeAge,
    double? averageMonthlyOvertimeHours,
    int? averageWorkersOver60Hours,
    List<ParentalLeaveRate>? paternityLeaveUtilizationRate,
    List<ParentalLeaveRate>? maternityLeaveUtilizationRate,
  }) {
    return HumanResourcesMetricsState(
      midCareerHiringRatio: midCareerHiringRatio ?? this.midCareerHiringRatio,
      midCareerHiringRatio2:
          midCareerHiringRatio2 ?? this.midCareerHiringRatio2,
      averageYearsAtCompany:
          averageYearsAtCompany ?? this.averageYearsAtCompany,
      averageEmployeeAge: averageEmployeeAge ?? this.averageEmployeeAge,
      averageMonthlyOvertimeHours:
          averageMonthlyOvertimeHours ?? this.averageMonthlyOvertimeHours,
      averageWorkersOver60Hours:
          averageWorkersOver60Hours ?? this.averageWorkersOver60Hours,
      paternityLeaveUtilizationRate:
          paternityLeaveUtilizationRate ?? this.paternityLeaveUtilizationRate,
      maternityLeaveUtilizationRate:
          maternityLeaveUtilizationRate ?? this.maternityLeaveUtilizationRate,
    );
  }
}

// 雇员招聘数据
class EmployeeHiringData {
  EmployeeHiringData({
    required double lastYear,
    required double twoYearsAgo,
    required double threeYearsAgo,
  })  : lastYear = max(min(lastYear, 100), 0),
        twoYearsAgo = max(min(twoYearsAgo, 100), 0),
        threeYearsAgo = max(min(threeYearsAgo, 100), 0);
  // 上一年
  final double lastYear;
  // 两年前
  final double twoYearsAgo;
  // 三年前
  final double threeYearsAgo;
}

/// 育儿假获得率
class ParentalLeaveRate {
  ParentalLeaveRate({
    required this.type,
    required double rate,
  }) : rate = max(min(rate, 100), 0);
  // 职业类型
  final String type;
  // 获得率
  final double rate;
}
