import 'package:flutter/material.dart';
import 'package:gymbuddy/service/home/home_service.dart';

enum HomeOptions { search, popular, newTraining, myTrainings, recentHistory }

class HomeOption extends StatelessWidget {
  const HomeOption({
    super.key,
    required this.id,
    required this.optionName,
    required this.icon,
  });

  final int id;
  final String optionName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          switch (HomeOptions.values[id]) {
            case HomeOptions.search:
              HomeService.searchWorkouts(context);
              break;
            case HomeOptions.myTrainings:
              HomeService.showMyTrainings(context);
              break;
            case HomeOptions.newTraining:
              HomeService.addNewTraining(context);
              break;
            case HomeOptions.recentHistory:
              HomeService.showRecentHistory(context);
              break;
            case HomeOptions.popular:
              HomeService.showPopularWorkouts(context);
              break;
            default:
              break;
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  optionName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
