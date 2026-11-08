import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyStyle = theme.textTheme.bodyLarge;
    final labelStyle = bodyStyle?.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Giới thiệu'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Icon(
                  Icons.local_drink,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Drink Recipe App',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Text('Môn học:', style: labelStyle),
              Text('Lập trình thiết bị di động', style: bodyStyle),

              const SizedBox(height: 16),
              Text('Giảng viên:', style: labelStyle),
              Text('ThS.NCS Nguyễn Xuân Quế', style: bodyStyle),

              const SizedBox(height: 16),
              Text('Nhóm:', style: labelStyle),
              Text('Nhóm 8', style: bodyStyle),

              const SizedBox(height: 16),
              Text('Thành viên:', style: labelStyle),
              Text(
                '- Hồ Sỹ Long – 24100319\n'
                '- Nguyễn Lê Trung Nguyên – 24100298\n'
                '- Phan Thị Ngân Quỳnh – 24100457',
                style: bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
