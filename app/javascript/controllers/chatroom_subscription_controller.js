import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages", "form", "content"];

  connect() {
    console.log("Connected to the chatroom subscription controller.");

    // Connect to ChatroomChannel
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => this.handleChatroomData(data),
      }
    );
  }

  disconnect() {
    console.log("Disconnected from the chatroom subscription controller.");

    // Disconnect from ChatroomChannel
    this.channel.unsubscribe();
  }

  // Handle form submission
  submitForm(event) {
    event.preventDefault();
    const content = this.contentTarget.value.trim();

    if (content !== "") {
      // Insert logic to send content to the server using ActionCable
      this.channel.send({ content });
      this.contentTarget.value = ""; // Clear input after submission
    }
  }

  // Handle received message from ActionCable
  handleChatroomData(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    const lastMessage = this.messagesTarget.lastElementChild;
    lastMessage.scrollIntoView({ behavior: 'smooth', block: 'end' });
  }
}
