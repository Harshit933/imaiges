// import 'package:email_auth/email_auth.dart';
//
// class VerifyEmail {
//   String Email;
//   EmailAuth emailAuth = EmailAuth(sessionName: 'Sample session');
//
//   VerifyEmail({required this.Email});
//
//   void sendMail() async {
//     // EmailAuth emailAuth = EmailAuth(sessionName: 'User session');
//     bool result = await emailAuth.sendOtp(recipientMail: Email, otpLength: 5);
//   }
//
//   void validateOTP(int otp) async {
//     emailAuth.validateOtp(
//       recipientMail: Email,
//       userOtp: otp.toString(),
//     );
//   }
// }
