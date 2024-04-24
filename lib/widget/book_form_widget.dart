import 'package:flutter/material.dart';

class BookFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? coverUrl;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCoverUrl;

  const BookFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.coverUrl = '',

    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCoverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget> [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 8),
            buildCoverUrl(),
            const SizedBox(height: 8)
          ],
        ),
      )
    );
  }

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24
    ),

    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter book title...',
      hintStyle: TextStyle(color: Colors.white70)
    ),

    validator: (title) => title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 8,
    initialValue: description,
    style: const TextStyle(color: Colors.white60, fontSize: 18),

    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter book description...',
      hintStyle: TextStyle(color: Colors.white60)
    ),

    validator: (desc) => desc != null && desc.isEmpty ? 'The description cannot be empty' : null,
    onChanged: onChangedDescription,
  );

  Widget buildCoverUrl() => TextFormField(
    maxLines: 1,
    initialValue: coverUrl,
    style: const TextStyle(color: Colors.white60, fontSize: 18),

    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter book cover URL...',
      hintStyle: TextStyle(color: Colors.white60)
    ),

    validator: (coverUrl) => coverUrl != null && coverUrl.isEmpty ? 'The cover URL cannot be empty' : null,
    onChanged: onChangedCoverUrl,
  );
}