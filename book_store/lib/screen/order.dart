import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamed(context, '/card_list');
          },
        ),
        title: Row(children: [
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {},
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(2),
                        hintText: "Search...",
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _focusNode.hasFocus
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade500))),
                  ))),
        ]),
        actions: [
          Stack(
            children: [
              Positioned(
                height: 250,
                width: 250,
                child: Container(
                  width: 150,
                  height: 150,
                  child: const Text("1",
                      style: TextStyle(fontSize: 15, color: Colors.red)),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AddToCard()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          // height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/images/orderSuccessfull-1.png",
              //   height: 100,
              //   width: 100,
              // ),
              const SizedBox(
                height: 80,
              ),
              Text(
                'Order Placed Successfully',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              // Image.asset(
              //   "assets/images/orderSuccessfull-2.png",
              //   height: 60,
              //   width: 60,
              // ),
              Text(
                'hurray!! your order is confirmed',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'The order id is #123456 save the order id for',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'further communication.',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                    //defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text('Email us', style: TextStyle(fontSize: 20.0))
                        ]),
                        Column(children: [
                          Text('Contact us', style: TextStyle(fontSize: 20.0))
                        ]),
                        Column(children: [
                          Text('Address', style: TextStyle(fontSize: 20.0))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('admin@bookstore.com'),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text('+91 8163475881'),
                          )
                        ]),
                        Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                                '42, 14th Main, 15th Cross, Sector 4, opp to BDA /n complex, near Kumarakom restaurant, HSR Layout, Bangalore 560034'),
                          )
                        ]),
                      ]),
                    ]),
              ),
              // SingleChildScrollView(
              //   child: DataTable(columnSpacing: 10, columns: const <DataColumn>[

              //     DataColumn(
              //       label: Text(
              //         'Email us',
              //         style: TextStyle(fontStyle: FontStyle.italic),
              //       ),
              //     ),
              //     DataColumn(
              //       label: Text(
              //         'Contact us',
              //         style: TextStyle(fontStyle: FontStyle.italic),
              //       ),
              //     ),
              //     DataColumn(
              //       label: Text(
              //         'Address',
              //         style: TextStyle(fontStyle: FontStyle.italic),
              //       ),
              //     ),
              //   ], rows:

              //    const <DataRow>[
              //     DataRow(
              //       cells: <DataCell>[
              //         DataCell(Text('admin@bookstore.com')),
              //         DataCell(Text('+91 8163475881')),
              //         DataCell(
              //           Text(
              //               '42, 14th Main, 15th Cross, Sector 4, opp to BDA /n complex, near Kumarakom restaurant, HSR Layout, Bangalore 560034'),
              //         ),
              //       ],
              //     ),
              //   ]),
              // ),
              TextButton(
                child: const Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(4.0),
                  )),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
