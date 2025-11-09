
module guestbook::guestbook;

use std::string::String;

const MAX_MESSAGE_LENGTH: u64= 10;

const EInvalidLength: u64 = 0;

public struct Message has store{
    content: String,
    sender: address,
}

public struct Guestbook has key{
    id: UID,
    no_of_messages: u64,
    messages: vector<Message>,
}

fun init( ctx: &mut TxContext) {
    let guestbook = Guestbook {
        id: object::new(ctx),
        no_of_messages: 0,
        messages: vector::empty<Message>(),
    };
    sui::transfer::share_object(guestbook);
}


public fun add_message(guestbook: &mut Guestbook, message: Message) {
    guestbook.no_of_messages = guestbook.no_of_messages + 1;
    guestbook.messages.push_back(message);
}

public fun create_message(content: String, ctx: &mut TxContext): Message {
    assert!(content.length() <=MAX_MESSAGE_LENGTH, EInvalidLength);
    Message {
        content,
        sender: ctx.sender(),
    }
}


