import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/dio_settings.dart';
import 'package:myapp/send_email_model.dart';
import 'package:myapp/text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SendEmailModel model = SendEmailModel();
    final TextEditingController controllerToName = TextEditingController();
    final TextEditingController controllerFromName = TextEditingController();
    final TextEditingController controllerMessage = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          model = SendEmailModel(
            serviceId : 'service_grwl299',
            templateId : 'template_4h00avg',
            userId : 'jp9Z-7JX36PKzReQP',
            accessToken : 'ppb3aO-WPz_mK7KFhu5G-',
            templateParams: TemplateParams(
            toName: controllerToName.text,
            fromName: controllerFromName.text,
            message: controllerMessage.text,
          ),
          );
          sendMessage(model: model);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.send),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'To name',
                controller: controllerToName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'From name',
                controller: controllerFromName,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Message',
                controller: controllerMessage,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage({required SendEmailModel model}) async {
    final Dio dio = DioSettings().dio;
    final Response response = await dio.post(
      'https://api.emailjs.com/api/v1.0/email/send',
      data: model.toJson(),
    );
    // ignore: avoid_print
    print(response.data);
  }
}


