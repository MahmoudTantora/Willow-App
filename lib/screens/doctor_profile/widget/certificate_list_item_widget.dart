import 'package:flutter/material.dart';import 'package:flutter_screenutil/flutter_screenutil.dart';class CertificatesListItemWidget extends StatelessWidget {  final String image;  const CertificatesListItemWidget({Key? key, required this.image})      : super(key: key);  @override  Widget build(BuildContext context) {    return Padding(      padding: EdgeInsets.symmetric(horizontal: 8.0.w),      child: Image.asset(image),    );  }}