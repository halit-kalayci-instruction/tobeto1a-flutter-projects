import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

//11:10
class _NewExpenseState extends State<NewExpense> {
  // Controller
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _openDatePicker() async {
    // DatePicker açmak.. ✅
    // DatePicker'dan gelen değeri Text olarak yazdırmak
    // built-in function

    // sync => bir işlem bitmeden diğerinin başlamadığı yapılar
    // async => alt satıra geçmek için işlemin bitmesini beklemezler // await
    DateTime now = DateTime.now();
    DateTime oneYearAgo = DateTime(now.year - 1, now.month, now.day);

    // 1 yıl öncesi ve bugün arasında kısıtlama
    // then => async bir işlemin geri dönüş sağladığı anda çalışacak bloğunu tanımlar.
    // showDatePicker(
    //         context: context,
    //         initialDate: now,
    //         firstDate: oneYearAgo,
    //         lastDate: now)
    //     .then((value) {
    //   print(value);
    // });

    // await => ilgili async işlemini bekle
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? now : _selectedDate!,
        firstDate: oneYearAgo,
        lastDate: now);

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Expense Name")),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(label: Text("Amount"), prefixText: "₺"),
          ),
          IconButton(
              onPressed: () => _openDatePicker(),
              icon: const Icon(Icons.calendar_month)),
          // Ternary Operator
          Text(_selectedDate == null
              ? "Tarih Seçiniz"
              : DateFormat.yMd().format(
                  _selectedDate!)), // seçilen tarihi formatlayarak yazdırmak..
          ElevatedButton(
              onPressed: () {
                print("Kayıt başarılı: ${_nameController.text}");
              },
              child: const Text("Kaydet"))
        ],
      ),
    );
  }
}
