import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/global/value.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/home/home_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/screen_guide_text.dart';

class InterestsDetailScreen extends ConsumerWidget {
  const InterestsDetailScreen({
    super.key,
    required this.interests,
  });

  final List<String> interests;
  final int _least = 3;

  bool _isNextActive(Map<String, List<String>> maps) {
    int totalCount = 0;
    for (var entity in maps.entries) {
      totalCount = totalCount + entity.value.length;
    }
    return totalCount >= _least;
  }

  Future<void> _onNextTap(BuildContext context, WidgetRef ref) async {
    ref.read(userProvider.notifier).updateUserProfileInfo({
      "interests": ref.read(userProvider).value?.interests,
    });
    context.goNamed(HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      onPopInvoked: (didPop) =>
          ref.read(userProvider.notifier).resetAllInterests(),
      child: Scaffold(
        appBar: const ThreadAppBar(isUseBackArrowLeading: true),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: ScreenWidth.sm),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ScreenGuideText(
                    title: "What do you want to see on Twitter?",
                    guideText:
                        "Interests are used to personalize your experience and will be visible on your profile.",
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade200),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey.shade200),
                    itemCount: interests.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 20,
                          bottom: 20,
                        ),
                        child: CategoryList(
                          category: interests[index],
                          details: interestsCategoryMap[interests[index]] ?? [],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 20,
                    bottom: 50,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.5),
                        width: 0.1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundedButton(
                        width: 70,
                        height: 35,
                        text: "Next",
                        fontSize: 14,
                        fontColor: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.w500,
                        backgroundColor:
                            Theme.of(context).colorScheme.inverseSurface,
                        isActive: _isNextActive(
                            ref.watch(userProvider).value!.interests),
                        onTap: () => _onNextTap(context, ref),
                      ),
                    ],
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

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.category,
    required this.details,
  });

  final String category;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: details
              .map(
                (detail) => Consumer(
                  builder: (context, ref, child) {
                    final userInfo = ref.watch(userProvider).value!;
                    final userNotifier = ref.read(userProvider.notifier);
                    final isSelected =
                        userInfo.interests[category]?.contains(detail) ?? false;

                    return CategoryItem(
                      category: category,
                      detail: detail,
                      isSelected: isSelected,
                      onTap: () {
                        if (isSelected) {
                          userNotifier.removeDetail(category, detail);
                        } else {
                          userNotifier.addDetail(category, detail);
                        }
                      },
                    );
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.detail,
    this.isSelected = false,
    this.onTap,
  });

  final String category;
  final String detail;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.inverseSurface,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          child: Text(detail),
        ),
      ),
    );
  }
}
