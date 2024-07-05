import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/providers/notifiers/user_profile_notifier.dart';
import 'package:twitter_clone/screens/common/rounded_button.dart';
import 'package:twitter_clone/screens/common/thread_app_bar.dart';
import 'package:twitter_clone/screens/profile/components/avatar.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  late final TextEditingController _descController;
  late final TextEditingController _nameController;

  bool _isEditActive = false;

  void _onChangedField() {
    setState(() {
      final description = ref.read(userProvider).value?.description;
      final username = ref.read(userProvider).value?.userName;
      final typedDesc = _descController.text;
      final typedName = _nameController.text;

      _isEditActive = ((description != typedDesc && typedDesc.isNotEmpty) ||
              (username != typedName)) &&
          typedName.isNotEmpty;
    });
  }

  Future<void> _onEditTap() async {
    await ref.read(userProvider.notifier).editUserProfile(
          username: _nameController.text,
          description: _descController.text,
        );
    if (mounted) {
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _descController = TextEditingController(
      text: ref.read(userProvider).value?.description,
    );
    _nameController = TextEditingController(
      text: ref.read(userProvider).value?.userName,
    );
    _isEditActive =
        ref.read(userProvider).value?.description != _descController.text &&
            _descController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _descController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const ThreadAppBar(isUseBackArrowLeading: true),
        body: ref.watch(userProvider).when(
              data: (user) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Avatar(user: user, size: 40),
                        const SizedBox(height: 20),
                        Text(
                          user.displayUserId ?? "",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _nameController,
                          maxLines: 1,
                          onChanged: (value) => _onChangedField(),
                          decoration: const InputDecoration(
                            label: Text("nickname"),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: "Type your nickname",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _descController,
                          maxLines: 5,
                          onChanged: (value) => _onChangedField(),
                          decoration: const InputDecoration(
                            label: Text("Description"),
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: "Type your info",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        RoundedButton(
                          onTap: () => _onEditTap(),
                          text: "Edit Profile",
                          centerWidget: ref.watch(userProvider).isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : null,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          fontColor: Colors.white,
                          isActive: _isEditActive &&
                              !ref.watch(userProvider).isLoading,
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (err, stack) => Center(
                child: Text("error: $err"),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
      ),
    );
  }
}
