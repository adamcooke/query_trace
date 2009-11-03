# QueryTrace plugin for Rails

It's nice that ActiveRecord logs the queries that are performed when your actions are executed, 
since it makes it easy to see when you have serious inefficiencies in your application. The next 
question, though, is always, "OK, so where are those being run from?" Before QueryTrace, that 
question could be a real pain to answer, since you'd have to go trawling through your code looking
for the culprit. Once you have QueryTrace installed, though, your logs won't just tell you that you
have a problem, they will pinpoint the location of that problem for you.

## Example

![Example](http://snaps.atechmedia.com/skitched-20091103-180533.jpg)

## Usage

All you have to do is have the plugin installed - QueryTrace takes care of the rest, including:

* Only displaying when at the DEBUG log level
* Honoring your log colorization settings

# Example

Before:

    Schedule Load (0.023687)   SELECT * FROM schedules WHERE (schedules.id = 3) LIMIT 1
    Resource Load (0.001076)   SELECT * FROM resources WHERE (resources.id = 328) LIMIT 1
    Schedule Load (0.011488)   SELECT * FROM schedules WHERE (schedules.id = 3) LIMIT 1
    Resource Load (0.022471)   SELECT * FROM resources WHERE (resources.id = 328) LIMIT 1


After:

    Schedule Load (0.023687)   SELECT * FROM schedules WHERE (schedules.id = 3) LIMIT 1
      app/models/available_work.rb:50:in `study_method'
    Resource Load (0.001076)   SELECT * FROM resources WHERE (resources.id = 328) LIMIT 1
      app/models/available_work.rb:54:in `div_type'
    Schedule Load (0.011488)   SELECT * FROM schedules WHERE (schedules.id = 3) LIMIT 1
      app/models/available_work.rb:50:in `study_method'
    Resource Load (0.022471)   SELECT * FROM resources WHERE (resources.id = 328) LIMIT 1
      app/models/available_work.rb:54:in `div_type'
