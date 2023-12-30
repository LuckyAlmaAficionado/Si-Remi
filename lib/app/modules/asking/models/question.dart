class Question {
  final int id;
  final String question;
  final String ans_1;
  final String ans_2;
  final String ans_3;

  Question({
    required this.id,
    required this.question,
    required this.ans_1,
    required this.ans_2,
    required this.ans_3,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'],
        question: json['question'],
        ans_1: json['ans_1'],
        ans_2: json['ans_2'],
        ans_3: json['ans_3'],
      );
}
