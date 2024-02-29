
import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number, studentId: Number };
  static targets = ["messages", "form"];

  connect() {
    console.log("Connected to the chatroom subscription controller.");
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => this.insertMessageAndScrollDown(data),
      }
    );
  }

  disconnect() {
    console.log("Disconnected from the chatroom subscription controller.");
    this.channel.unsubscribe();
  }

  insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    const lastMessage = this.messagesTarget.lastElementChild;
    lastMessage.scrollIntoView({ behavior: 'smooth', block: 'end' });
  }

  switchToDirectMessage(event) {
    console.log("Clicked on a student", event.currentTarget.dataset.id);
    event.preventDefault();


    // @@ Retrieve student ID from the clicked element
    const studentId = event.currentTarget.dataset.id;



    // @@  Unsubscribe from the current channel
    console.log("Unsubscribing from the current channel");
    this.channel.unsubscribe();

    // @@  Subscribe to the new channel (direct chat with the selected student)
    console.log(`Subscribing to the new channel with chatroom ID ${studentId}`);
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: studentId},
      {
        received: data => this.insertMessageAndScrollDown(data),
      }
    );

    console.log(`Switched to direct chat with student ID ${studentId}.`);
  }


}
