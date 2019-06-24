GME
===

This is an implementation of the [Mythic Game Master Emulator](https://wordmillgames.com/mythic-game-master-emulator.html).
Execute `ruby ./gme.rb` to run.

It is command-based, so type in a command and, if the system recognises it, it
will print a reply.

Available commands:

- Anything ending in a '?', e.g., "Are they close?", will yield a response of 
  "YES", "NO", "EXCEPTIONAL YES", "EXCEPTIONAL NO", plus possibly an event,
  according to the rules of the Mythic system.
- The default odds are "50/50", but different odds can be specified in 
  parentheses after the command, e.g., "Do I hear them? (very unlikely)".
  Available odds are "impossible", "no way", "very unlikely", "unlikely", 
  "50/50", "somewhat likely", "likely", "very likely", "near sure thing", 
  "a sure thing", "has to be".
- Enter "/chaos" to show the current chaos level.
- Enter "/event" to generate an event.
