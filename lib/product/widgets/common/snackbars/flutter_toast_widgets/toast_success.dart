// import 'package:flutter/material.dart';
// import '../../../../core/extensions/context_extension.dart';

// import '../../../assets/asset.dart';

// class ToastSuccessfulWidget extends StatelessWidget {
//   const ToastSuccessfulWidget({super.key, this.backgroundColor, required this.title, this.subTitle});
//   final Color? backgroundColor;
//   final String title;
//   final String? subTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//         color: backgroundColor ?? context.appTheme.colorScheme.primaryContainer,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Assets.svg.checkCircle.svg(),
//           SizedBox(
//             width: 12.0,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   title,
//                   style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 if (subTitle != null)
//                   Text(subTitle!, style: context.textTheme.titleSmall?.copyWith(color: context.appTheme.colorScheme.onSurfaceVariant)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
