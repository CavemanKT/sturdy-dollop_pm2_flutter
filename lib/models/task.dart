class Task {
  var id;
  var title;
  var content;
  var status;
  var UserId;
  var receiver;
  var createdAt;
  var updatedAt;

  Task({
    this.id,
    this.title,
    this.content,
    this.status,
    this.UserId,
    this.receiver,
    this.createdAt,
    this.updatedAt,
  });

  void setComplete() {
    status = 'complete';
  }

  static fromJson(item) {
    return Task(
      id: item['id'],
      title: item['title'],
      content: item['content'],
      status: item['status'],
      UserId: item['UserId'],
      receiver: item['receiver'],
      createdAt: item['createdAt'],
      updatedAt: item['updatedAt'],
    );
  }
}
