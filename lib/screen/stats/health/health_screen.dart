import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/components/custom_snackbars.dart';
import 'package:gymbuddy/providers/health_provider.dart';
import 'package:gymbuddy/screen/stats/charts/heart_rate_line_chart.dart';
import 'package:gymbuddy/screen/stats/charts/weight_line_chart.dart';
import 'package:gymbuddy/service/stats/health_service.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var permissionRef = ref.watch(healthPermissionsProvider);
    if (permissionRef.isLoading) {
      return const WaitingSpinner(title: "Loading health data...");
    }
    bool isPermitted = permissionRef.value ?? false;
    if (!isPermitted) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NoContentText(
                title: 'Connect to Google Fit to use this feature 🛡️'),
            ElevatedButton.icon(
              onPressed: () => ref.refresh(healthPermissionsProvider),
              icon: const Icon(Icons.login),
              label: const Text('Use my Google Fit account'),
            )
          ],
        ),
      );
    }
    var healthRef = ref.watch(healthProvider);
    return healthRef.when(
      data: (healthData) => RefreshIndicator(
        onRefresh: () async => ref.refresh(healthProvider),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: const ButtonStyle().copyWith(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColorDark),
                      ),
                      onPressed: () => changeAccount(context, ref),
                      icon: const Icon(Icons.logout),
                      label: const Text('Use different account'),
                    ),
                  ),
                ),
                HeartRateLineChart(healthDataPoints: healthData.bloodRateData),
                WeightLineChart(weightsData: healthData.weightData)
              ],
            ),
          ),
        ),
      ),
      error: (error, stackTrace) =>
          NoContentText(title: "Error occured: ${error.toString()}"),
      loading: () => Container(
        alignment: Alignment.center,
        child: const WaitingSpinner(title: "Loading health data..."),
      ),
    );
  }

  changeAccount(BuildContext context, WidgetRef ref) async {
    await HealthService().changeAccount().then(
      (value) {
        ref.invalidate(healthPermissionsProvider);
        showSuccessSnackBar(
          context,
          'You logged out from this account successfully!',
        );
      },
    );
  }
}
