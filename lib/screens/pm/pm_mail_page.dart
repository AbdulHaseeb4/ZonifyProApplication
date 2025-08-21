import 'package:flutter/material.dart';

class PMMailPage extends StatelessWidget {
  const PMMailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isWeb = screenWidth >= 900;

    /// Example mail data (baad me API/data se replace kar sakte ho)
    final mails = [
      {
        "sender": "John Doe",
        "subject": "Order Confirmation",
        "preview": "Your order #10023 has been confirmed successfully.",
        "time": "10:24 AM"
      },
      {
        "sender": "Sara Khan",
        "subject": "Refund Processed",
        "preview": "We have processed your refund of \$85.50.",
        "time": "Yesterday"
      },
      {
        "sender": "Ali Raza",
        "subject": "New Feature Update",
        "preview": "Check out the latest updates we rolled out...",
        "time": "Mon"
      },
      {
        "sender": "Support",
        "subject": "Password Reset",
        "preview": "Click the link below to reset your password.",
        "time": "Sun"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Page Title
              Text(
                "Inbox",
                style: TextStyle(
                  fontSize: isWeb ? 28 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              /// Mail List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mails.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final mail = mails[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// Sender Icon
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent.withOpacity(0.1),
                          child: Text(
                            mail["sender"]![0], // first letter of sender
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(width: 12),

                        /// Mail Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Sender + Time
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      mail["sender"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    mail["time"]!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),

                              /// Subject
                              Text(
                                mail["subject"]!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),

                              /// Preview
                              Text(
                                mail["preview"]!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
