[![rebol-scheduler](https://github.com/user-attachments/assets/8218d861-513c-41c8-bb23-fc58da7d2fee)](https://github.com/Oldes/Rebol-Scheduler)

[![Rebol-Scheduler CI](https://github.com/Oldes/Rebol-Scheduler/actions/workflows/main.yml/badge.svg)](https://github.com/Oldes/Rebol-Scheduler/actions/workflows/main.yml)
[![Gitter](https://badges.gitter.im/rebol3/community.svg)](https://app.gitter.im/#/room/#Rebol3:gitter.im)
[![Zulip](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://rebol.zulipchat.com/)

# Rebol/Scheduler

Task scheduling library with dialect originally written for Rebol2 by Nenad Rakocevic (Softinnov) in year 2009.
Ported to [Rebol3](https://github.com/Oldes/Rebol3) by Oldes.

The original source was downloaded from: https://www.softinnov.org/rebol/scheduler.shtml

Importing the Scheduler
------------------------
```rebol
scheduler: import %scheduler.reb
```

### Scheduler DSL quickstart

Legend:
- `<value>` means that the value is optional
- CAPITALIZED words design dialect's keywords

#### Event with a precise point in time :
```
    <name:> AT time! DO action
```

#### Event with a delay :
```
    <name:> IN n <unit> DO action
```

#### Recurring event :
```rebol
    <name:> EVERY 
        <n> <unit>      ; recurring unit
        <allowed>       ; specific point(s) in time or duration(s) allowed
        <NOT forbidden> ; specific point(s) in time or duration(s) forbidden
        <FROM moment>   ; starting point
        <AT moment>     ; fix time for each event (only date changes)
        <t TIMES>       ; limit the number of event occurences
        DO action       ; job to execute
```
with
```
    <name:>:     set-word! value for naming a task (for future access using the API).
    <n>:         integer! value for unit multiplying.
    <unit>:      any of:
                   s|sec|second|seconds
                   mn|minute|minutes
                   h|hour|hours
                   d|day|days
                   w|week|weeks
                   m|month|months
    <allowed>:   any time (00:00:00), calendar day (#dd), weekday (mon|monday), 
                 month (jan|january), range of time|calendar-days or block of any
                 of theses options.
    <forbidden>: same options as <allowed>.
    <moment>:    date! or time! value.
    <t>:         integer! value.
    action:      file!|url!|block!|function!|word! value to be evaluated when event is fired.
```
	
### Syntactic sugar
Default dialect is parsed in BLOCK! mode. That means that only REBOL values
are accepted, but some may want to write calendar dates like: `1st`, `2nd`,...
instead or `#1`, `#2`,...

So, a preprocessor is included allowing tasks to be passed as string! values
extending the accepted syntax for the following cases:
```
        1st, 2nd, 3rd,..nth     : accepted
        12s, 12mn, 12h, 12d,... : accepted
```
### Scheduler API
```rebol
scheduler/plan [spec]      ; add one or more tasks to the scheduler
scheduler/plan/new [spec]  ; same as above but removes all previous tasks
scheduler/delete 'name     ; removes the named task from the scheduler
scheduler/wait             ; provides an adequate global event loop
```

## Examples
```rebol
scheduler: import %scheduler.reb
scheduler/plan [
    at 18:30 do http://domain.com/update.r3
    every 3 days not [#2 - #9 #12 sat sun] at 00:30 do %batch.r3
    smk: every friday at 13:00 do %test.r3
    cc: every 12 hours do %backup.r3
    every [sat sun] at 12:00 do %beep.r3
    every month on #01 do %check.r3
]
scheduler/wait
```

(See %test-scheduler.r3 for more examples)
