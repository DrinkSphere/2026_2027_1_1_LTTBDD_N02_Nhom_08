import 'package:flutter/material.dart';

class TasteRecommendationScreen extends StatefulWidget {
  const TasteRecommendationScreen({super.key});

  @override
  State<TasteRecommendationScreen> createState() =>
      _TasteRecommendationScreenState();
}

class _TasteRecommendationScreenState extends State<TasteRecommendationScreen> {
  int currentStep = 0;

  String? selectedTaste;
  String? selectedTemperature;
  String? selectedType;

  final List<String> tastes = ['Ngọt', 'Chua', 'Đắng', 'Béo', 'Thanh nhẹ'];

  final List<String> temperatures = ['Nóng', 'Lạnh', 'Không quan trọng'];

  final List<String> drinkTypes = [
    'Trà',
    'Cà phê',
    'Nước trái cây',
    'Không quan trọng',
  ];

  void nextStep() {
    if (currentStep == 0 && selectedTaste == null) return;
    if (currentStep == 1 && selectedTemperature == null) return;
    if (currentStep == 2 && selectedType == null) return;

    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void restart() {
    setState(() {
      currentStep = 0;
      selectedTaste = null;
      selectedTemperature = null;
      selectedType = null;
    });
  }

  Widget buildOptions(
    List<String> options,
    String? selectedValue,
    ValueChanged<String> onSelected,
  ) {
    return Column(
      children: options.map((option) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) onSelected(value);
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Bạn thích khẩu vị nào?',
      'Bạn thích uống nóng hay lạnh?',
      'Bạn muốn uống loại nào?',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gợi ý đồ uống')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: currentStep == 3
            ? buildResult()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: (currentStep + 1) / 3),
                  const SizedBox(height: 24),

                  Text(
                    'Câu hỏi ${currentStep + 1}/3',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    titles[currentStep],
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: currentStep == 0
                          ? buildOptions(
                              tastes,
                              selectedTaste,
                              (value) => setState(() => selectedTaste = value),
                            )
                          : currentStep == 1
                          ? buildOptions(
                              temperatures,
                              selectedTemperature,
                              (value) =>
                                  setState(() => selectedTemperature = value),
                            )
                          : buildOptions(
                              drinkTypes,
                              selectedType,
                              (value) => setState(() => selectedType = value),
                            ),
                    ),
                  ),

                  Row(
                    children: [
                      if (currentStep > 0)
                        OutlinedButton(
                          onPressed: previousStep,
                          child: const Text('Quay lại'),
                        ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: nextStep,
                          child: Text(
                            currentStep == 2 ? 'Xem gợi ý' : 'Tiếp tục',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Khẩu vị của bạn',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        Text('Khẩu vị: $selectedTaste'),
        Text('Nhiệt độ: $selectedTemperature'),
        Text('Loại đồ uống: $selectedType'),

        const SizedBox(height: 30),

        const Text('Dưới đây là gợi ý đồ uống dựa trên sở thích của bạn:'),

        const Spacer(),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: restart,
            child: const Text('Chọn lại'),
          ),
        ),
      ],
    );
  }
}
