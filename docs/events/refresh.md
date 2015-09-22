# @title Vedeu Refresh Events

## Refresh Events

### :_refresh_
Refreshes all registered interfaces or the named interface.

The interfaces will be refreshed in z-index order, meaning that
interfaces with a lower z-index will be drawn first. This means
overlapping interfaces will be drawn as specified. Hidden interfaces
will be still refreshed in memory but not shown.

    Vedeu.trigger(:_refresh_)
    Vedeu.trigger(:_refresh_, name)

### :_refresh_cursor_
Will cause the named cursor to refresh, or the cursor of the interface
which is currently in focus.

    Vedeu.trigger(:_refresh_cursor_, name)

### :_refresh_group_
Will cause all interfaces in the named group to refresh.

    Vedeu.trigger(:_refresh_group_, name)