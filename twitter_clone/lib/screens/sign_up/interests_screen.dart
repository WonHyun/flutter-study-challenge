import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/global/breakpoint.dart';
import 'package:twitter_clone/global/value.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/sign_up/interests_detail_screen.dart';
import 'package:twitter_clone/screens/sign_up/widgets/screen_guide_text.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  static const String routeName = "interests";
  static const String routePath = "/interests";

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final int _least = 3;

  final List<String> _interests = [];

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InterestsDetailScreen(interests: _interests),
      ),
    );
  }

  void _onSelect(String interest) {
    final index = _interests.indexOf(interest);
    if (index < 0) {
      setState(() {
        _interests.add(interest);
      });
    } else {
      setState(() {
        _interests.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThreadAppBar(),
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
                      "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade200),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: interestsCategoryMap.keys
                        .map(
                          (value) => InterestCategory(
                            width: 160,
                            height: 70,
                            category: value,
                            isSelected: _interests.contains(value),
                            onTap: () => _onSelect(value),
                          ),
                        )
                        .toList(),
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _interests.length < _least
                          ? "${_interests.length} of 3 selected"
                          : "Great work 🎉",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .inverseSurface
                            .withOpacity(0.6),
                      ),
                    ),
                    RoundedButton(
                      width: 70,
                      height: 35,
                      text: "Next",
                      fontSize: 14,
                      fontColor: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.w500,
                      backgroundColor:
                          Theme.of(context).colorScheme.inverseSurface,
                      isActive: _interests.length >= _least,
                      onTap: _onNextTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InterestCategory extends StatelessWidget {
  const InterestCategory({
    super.key,
    required this.width,
    required this.height,
    this.category = "",
    this.isSelected = false,
    this.onTap,
  });

  final double width;
  final double height;
  final String category;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            width: 1,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: AnimatedDefaultTextStyle(
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.inverseSurface,
                ),
                duration: const Duration(milliseconds: 150),
                child: Text(
                  category,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: AnimatedOpacity(
                opacity: isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
