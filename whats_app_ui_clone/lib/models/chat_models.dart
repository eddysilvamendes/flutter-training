class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  ChatModel(
      {required this.name,
      required this.message,
      required this.time,
      required this.avatarUrl});
}

List<ChatModel> dummyData = [
  ChatModel(
    name: "Edilson Mendes",
    message: "Hey there, Testing flutter",
    time: "16:30",
    avatarUrl: "https://www.mobafire.com/images/avatars/zed-classic.png",
  ),
  ChatModel(
    name: "Yasou",
    message: "Death is like the wind - always by my side.",
    time: "18:30",
    avatarUrl:
        "https://i.pinimg.com/originals/fb/e5/72/fbe572e1faefa97388243a952acfbe93.jpg",
  ),
  ChatModel(
    name: "Jax",
    message: "Imagine if i had a real weapond",
    time: "11:00",
    avatarUrl: "https://www.mobafire.com/images/avatars/jax-classic.png",
  ),
  ChatModel(
    name: "Master Yi",
    message: "My blade is yours.",
    time: "08:00",
    avatarUrl:
        "https://external-preview.redd.it/Od5f5CtxQUZR-5atAshk0QAcpkXPuoQPePRSSZvLDgQ.jpg?auto=webp&s=84b42f8fdaaf7d440135153f8c7c690ae54c5e32",
  ),
  ChatModel(
    name: "Jinx",
    message: "Rules are made to be broken... like buildings! Or people!",
    time: "9:40",
    avatarUrl:
        "https://i.pinimg.com/originals/a3/52/60/a352605b4439be8271977fa254bca1ab.jpg",
  ),
  ChatModel(
    name: "Samira",
    message: "You want style? You've found her.",
    time: "12:30",
    avatarUrl: "https://www.mobafire.com/images/avatars/samira-classic.png",
  ),
  ChatModel(
    name: "Caitlyn",
    message: "I'm on the case.",
    time: "15:30",
    avatarUrl: "https://www.mobafire.com/images/avatars/caitlyn-pulsefire.png",
  ),
];
