import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { chatroomId: Number, userId: Number };
  static targets = ["messages", "form", "content"];

  connect() {
    console.log("Connected to the chatroom subscription controller.");
    console.log(this.userIdValue);
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
    this.messagesTarget.insertAdjacentHTML("beforeend", data.message);
    const lastMessage = this.messagesTarget.lastElementChild;
    console.log(lastMessage);
    if (this.currentUserIsSender(data.user_id)) {

      lastMessage.classList.add("sent");

    } else {
      lastMessage.classList.add("received");
    }


    lastMessage.scrollIntoView({ behavior: 'smooth', block: 'end' });
  }
  // Logic to know if the sender is the current_user
  currentUserIsSender(senderId) {
    return this.userIdValue === senderId;

  }
  // Creating the whole message from the `message` String
  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
  buildMessageElement(currentUserIsSender, message) {
    return `
    <div class="message-row d-flex ${this.justifyContentClass(currentUserIsSender)}">
    <div class="${this.userStyleClass(currentUserIsSender)}">
    ${message}
    </div>
    </div>
    `;
  }
}
