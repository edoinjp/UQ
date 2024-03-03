import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number, studentId: Number };
  static targets = ["messages", "form"];

  connect() {
    console.log("Connected to the chatroom subscription controller.");

    // Connect to ChatroomChannel for scrolling
    this.channelWithScroll = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => this.insertMessageAndScrollDown(data),
      }
    );

    // Connect to ChatroomChannel for additional logic
    this.channelWithAdditionalLogic = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => this.messagesTarget.insertAdjacentHTML("beforeend", data),
      }
    );

    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`);
  }

  disconnect() {
    console.log("Disconnected from the chatroom subscription controller.");

    // Disconnect from ChatroomChannel for scrolling
    this.channelWithScroll.unsubscribe();

    // Disconnect from ChatroomChannel for additional logic
    this.channelWithAdditionalLogic.unsubscribe();
  }

  insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    const lastMessage = this.messagesTarget.lastElementChild;
    lastMessage.scrollIntoView({ behavior: 'smooth', block: 'end' });
  }
}
