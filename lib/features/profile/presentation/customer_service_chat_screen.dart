import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa/core/theme/app_colors.dart';
import 'package:nexa/core/theme/app_text_styles.dart';

class CustomerServiceChatScreen extends StatelessWidget {
  const CustomerServiceChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.gray900,
            size: 22,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Customer Service',
          style: AppTextStyles.header2SemiBold.copyWith(
            color: AppColors.gray900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.call_outlined,
              color: AppColors.gray900,
              size: 22,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Divider(color: AppColors.gray100, height: 1, thickness: 1),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: const BouncingScrollPhysics(),
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Messages
                _ChatBubble(text: 'Hello, good morning.', isSender: false),
                _ChatBubble(
                  text:
                      'I am a Customer Service, is there anything I can help you with?',
                  isSender: false,
                  time: '10:41 pm',
                ),
                _ChatBubble(
                  text: 'Hi, I\'m having problems with my order & payment.',
                  isSender: true,
                ),
                _ChatBubble(
                  text: 'Can you help me?',
                  isSender: true,
                  time: '10:54 pm',
                ),
                _ChatBubble(text: 'Of course...', isSender: false),
                _ChatBubble(
                  text:
                      'Can you tell me the problem you are having? so I can help solve it',
                  isSender: false,
                  time: '10:51 pm',
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.gray100, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.gray200, width: 1.2),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: AppTextStyles.body2Regular.copyWith(
                              color: AppColors.gray900,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write your message...',
                              hintStyle: AppTextStyles.body2Regular.copyWith(
                                color: AppColors.gray400,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.image_outlined,
                          color: AppColors.gray400,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.gray900,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.mic_none_rounded,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final String? time;

  const _ChatBubble({required this.text, required this.isSender, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSender ? AppColors.gray900 : AppColors.gray100,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isSender ? 16 : 4),
                bottomRight: Radius.circular(isSender ? 4 : 16),
              ),
            ),
            child: Text(
              text,
              style: AppTextStyles.body2Regular.copyWith(
                color: isSender ? AppColors.white : AppColors.gray900,
                height: 1.4,
              ),
            ),
          ),
          if (time != null) ...[
            const SizedBox(height: 4),
            Text(
              time!,
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.gray400,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
