# FinTech Wallet App Demo


## Features

- Authentication Module: Email & Password Login, Biometrics (Fingerprint/FaceID) support.
- Wallet Dashboard: View current balance and native currency.
- Transactions: View recent Mock Transactions with credit (green) and debit (red) differentiation.
- Send Money: Input recipient and amount with form validation, confirmation screen, and simulated network requests.
- Security: Local authentication with explicit fallback and Token protection using `flutter_secure_storage`.



This ensures extreme scalability, easy testing (data logic decoupled from UI logic), and modular feature integration. Each Domain has no dependencies on external frameworks like Flutter or HTTP clients.



> **Note for iOS**: In order to use biometrics, `NSFaceIDUsageDescription` config is intrinsically required in `Info.plist` (typically added automatically or during deep device config).

## Assumptions

- Mock API: There is no live remote API. Data Sources mock network delays (using `Future.delayed()`) and hardcode mock responses directly as per in the doc.
- Tokens are simply mocked as securely stored UUIDs indicating an active session.
- To simulate an expired session, `SecureStorage` must be cleared.
-  Login credentials to pass validation during demo:
  - Email: `test@example.com`
  - Password: `password123`
