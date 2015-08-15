Sales Engine with SQL and dependency injection
==============================================

Initial state
-------------

This code is on the [minimal-example](https://github.com/JoshCheek/sales_engine_dependency_injection.rb/blob/minimal-example/lib/sales_engine.rb) branch.

Some students had to rewrite Sales Engine using sql.
I was explaining how the ideas I'd expressed to them in the non-sql version
still applied here.
Instead of instantiating the repo with the records you wanted it to have,
you instantiate it with the database. Thus the simple collection of arrays and hashes
will be extrapolated to a "database" object, which you have just as much control over.

This, then allows you to instantiate it with the Sql database,
or the Memory database, thus you can create the memory database
in the same way that you could previously create the sales engine.
To illustrate the idea, I wrote a simplified version:

* [Code](https://github.com/JoshCheek/sales_engine_dependency_injection.rb/blob/minimal-example/lib/sales_engine.rb)
* [Instantiating with an in-memory db](https://github.com/JoshCheek/sales_engine_dependency_injection.rb/blob/minimal-example/test/customer_repository_test.rb#L6-L12)
* [Instantiating with a sql db](https://github.com/JoshCheek/sales_engine_dependency_injection.rb/blob/minimal-example/test/sales_engine_test.rb#L9-L10)


Current state
-------------

I wound up playing with it a little more to see how it goes.
In some regard, it hits some difficulties where it feels like we need something like [Arel](https://rubygems.org/gems/arel)
at this point (has many through), but you could still push all these methods down into the db.
Maybe I should just go make a crappy Arel, but I have a lot I want to do, so just going to upsh it as is `^_^`


License
-------

[Just do what the fuck you want to](wtfpl.net/about)
