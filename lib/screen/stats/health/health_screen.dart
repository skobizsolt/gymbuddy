import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbuddy/providers/health_provider.dart';
import 'package:gymbuddy/service/health_service.dart';
import 'package:gymbuddy/widgets/utils/no_content_text.dart';
import 'package:gymbuddy/widgets/utils/waiting_spinner_widget.dart';

class HealthScreen extends ConsumerWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HealthService.requestPermissions();
    var healthRef = ref.watch(healthProvider);
    return healthRef.when(
      data: (data) => Center(
          child: RefreshIndicator(
              onRefresh: () async => ref.invalidate(healthProvider),
              child: SingleChildScrollView(child: Text(data.toString())))),
      error: (error, stackTrace) =>
          NoContentText(title: "Error occured: ${error.toString()}"),
      loading: () =>
          const Center(child: WaitingSpinner(title: "Loading health data...")),
    );
  }
}
