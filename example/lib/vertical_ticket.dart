import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:simple_ticket_widget/simple_ticket_widget.dart';

class VerticalTicket extends StatelessWidget {
  const VerticalTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SimpleTicketWidget(
        arcRadius: 15,
        position: 300,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 405,
          width: 280,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Center(
                      child: Opacity(
                        opacity: 0.2,
                        child: Image.asset('assets/ic_world.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            spacing: 15,
                            children: [
                              _detailWidget(
                                name: 'Name of Passenger',
                                value: 'John Doe',
                              ),
                              _detailWidget(
                                name: 'Flight',
                                value: 'F3954',
                              ),
                              _detailWidget(
                                name: 'Date',
                                value: '09 Apr 2025',
                              ),
                              _detailWidget(
                                name: 'Seat',
                                value: '7A',
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                'New york'.toUpperCase(),
                                style: _textStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: Icon(
                                  Icons.local_airport,
                                  size: 30,
                                ),
                              ),
                              Text(
                                'New Delhi'.toUpperCase(),
                                style: _textStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 2,
                                children: [
                                  Text(
                                    'Gate'.toUpperCase(),
                                    style: _textStyle(color: Colors.red, fontSize: 13),
                                  ),
                                  Text(
                                    'D 12'.toUpperCase(),
                                    style: _textStyle(color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 2,
                                children: [
                                  Text(
                                    'Boarding Time'.toUpperCase(),
                                    style: _textStyle(color: Colors.red, fontSize: 13),
                                  ),
                                  Text(
                                    '07:30'.toUpperCase(),
                                    style: _textStyle(color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Gate closes 40 minutes before departure'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: _textStyle(color: Colors.black, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xFFD0D0D0),
                dashGapLength: 10,
                dashLength: 14,
                lineThickness: 14,
                dashRadius: 7,
              ),
              Container(
                height: 110,
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  spacing: 5,
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: 'John Doe F3954',
                      color: Colors.white,
                      drawText: false,
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 5,
                      children: [
                        Text(
                          'New York'.toUpperCase(),
                          style: _textStyle(color: Colors.white, fontSize: 14),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.local_airport,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'New Delhi'.toUpperCase(),
                          style: _textStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailWidget({required String name, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          name.toUpperCase(),
          style: _textStyle(color: Colors.grey, fontSize: 10),
        ),
        Text(
          value.toUpperCase(),
          style: _textStyle(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }

  TextStyle _textStyle({
    required Color color,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'Helvetica',
    );
  }
}
