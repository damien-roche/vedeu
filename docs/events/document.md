# @title Vedeu Document Events

## Document Events

### :_editor_execute_

    Vedeu.trigger(:_editor_execute_, name)

### :_editor_delete_character_
This event attempts to delete the character in the named
document at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_character_, name)

### :_editor_delete_line_
This event attempts to delete the line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_delete_line_, name)

### :_editor_down_
This event attempts to move the virtual cursor down by one
line in the named document.

    Vedeu.trigger(:_editor_down_, name)

### :_editor_insert_character_
This event attempts to insert the given character in the named
document at the current virtual cursor position.

    Vedeu.trigger(:_editor_insert_character_, name, character)

### :_editor_insert_line_
This event attempts to insert a new line in the named document
at the current virtual cursor position.

    Vedeu.trigger(:_editor_insert_line_, name)

### :_editor_left_
This event attempts to move the virtual cursor left by one
character in the named document.

    Vedeu.trigger(:_editor_left_, name)


### :_editor_right_
This event attempts to move the virtual cursor right by one
character in the named document.

    Vedeu.trigger(:_editor_right_, name)


### :_editor_up_
This event attempts to move the virtual cursor up by one line
in the named document.

    Vedeu.trigger(:_editor_up_, name)