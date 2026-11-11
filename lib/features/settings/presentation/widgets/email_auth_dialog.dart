import 'package:flutter/material.dart';
import '../../../../l10n/l10n.dart';

class EmailAuthRequest {
  final String? name;
  final String email;
  final String password;
  final bool register;

  const EmailAuthRequest({
    this.name,
    required this.email,
    required this.password,
    required this.register,
  });
}

Future<EmailAuthRequest?> showEmailAuthScreen(
  BuildContext context, {
  Future<void> Function()? onGoogleSignIn,
}) {
  return Navigator.of(context).push<EmailAuthRequest>(
    MaterialPageRoute(
      builder: (_) => LoginScreen(onGoogleSignIn: onGoogleSignIn),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  final Future<void> Function()? onGoogleSignIn;

  const LoginScreen({super.key, this.onGoogleSignIn});

  @override
  Widget build(BuildContext context) =>
      _EmailAuthScreen(register: false, onGoogleSignIn: onGoogleSignIn);
}

class RegisterScreen extends StatelessWidget {
  final Future<void> Function()? onGoogleSignIn;

  const RegisterScreen({super.key, this.onGoogleSignIn});

  @override
  Widget build(BuildContext context) =>
      _EmailAuthScreen(register: true, onGoogleSignIn: onGoogleSignIn);
}

class _EmailAuthScreen extends StatefulWidget {
  final bool register;
  final Future<void> Function()? onGoogleSignIn;

  const _EmailAuthScreen({required this.register, this.onGoogleSignIn});

  @override
  State<_EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<_EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      EmailAuthRequest(
        name: widget.register ? _name.text.trim() : null,
        email: _email.text.trim(),
        password: _password.text,
        register: widget.register,
      ),
    );
  }

  Future<void> _openRegister() async {
    final request = await Navigator.of(context).push<EmailAuthRequest>(
      MaterialPageRoute(
        builder: (_) => RegisterScreen(onGoogleSignIn: widget.onGoogleSignIn),
      ),
    );
    if (request != null && mounted) Navigator.of(context).pop(request);
  }

  Future<void> _openLogin() async {
    final request = await Navigator.of(context).push<EmailAuthRequest>(
      MaterialPageRoute(
        builder: (_) => LoginScreen(onGoogleSignIn: widget.onGoogleSignIn),
      ),
    );
    if (request != null && mounted) Navigator.of(context).pop(request);
  }

  Future<void> _signInWithGoogle() async {
    Navigator.of(context).pop();
    await widget.onGoogleSignIn?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.register
              ? L10n.t.emailAuthTitleRegister
              : L10n.t.emailAuthTitleLogin,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.register) ...[
                    TextFormField(
                      controller: _name,
                      maxLength: 100,
                      textCapitalization: TextCapitalization.words,
                      autofillHints: const [AutofillHints.name],
                      decoration: InputDecoration(
                        labelText: L10n.t.emailAuthName,
                      ),
                      validator: (value) => (value?.trim().isNotEmpty ?? false)
                          ? null
                          : L10n.t.emailAuthNameRequired,
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    maxLength: 254,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      labelText: L10n.t.emailAuthEmail,
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      return email.contains('@') && email.contains('.')
                          ? null
                          : L10n.t.emailAuthInvalidEmail;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: _obscurePassword,
                    textDirection: TextDirection.ltr,
                    maxLength: 128,
                    autofillHints: widget.register
                        ? const [AutofillHints.newPassword]
                        : const [AutofillHints.password],
                    decoration: InputDecoration(
                      labelText: L10n.t.emailAuthPassword,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    validator: (value) => (value?.length ?? 0) >= 8
                        ? null
                        : L10n.t.emailAuthShortPassword,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _submit,
                    child: Text(
                      widget.register
                          ? L10n.t.emailAuthRegister
                          : L10n.t.emailAuthLogin,
                    ),
                  ),
                  TextButton(
                    onPressed: widget.register ? _openLogin : _openRegister,
                    child: Text(
                      widget.register
                          ? L10n.t.emailAuthGoToLogin
                          : L10n.t.emailAuthGoToRegister,
                    ),
                  ),
                  if (widget.onGoogleSignIn != null) ...[
                    const Divider(height: 32),
                    OutlinedButton.icon(
                      onPressed: _signInWithGoogle,
                      icon: const Icon(Icons.g_mobiledata_rounded),
                      label: Text(L10n.t.cloudAccountButton3),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
