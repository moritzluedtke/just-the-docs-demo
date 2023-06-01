# Kotlin

See all Exceptions but they are grouped.

```kotlin
runBlocking(Dispatchers.IO) {
    (1..10).map {
        async {
            delay(1000)
            println("$it ${Thread.currentThread()}")
            throw IllegalStateException("$it Boom!")
        }
    }.awaitAll()
    println("done")
}
```

See all Exceptions in every thread. One exception in one thread doesn't abort the other threads.

```kotlin
runBlocking(Dispatchers.IO) {
    supervisorScope {
        (1..10).map {
            async {
                delay(1000)
                println("$it ${Thread.currentThread()}")
                throw IllegalStateException("$it Boom!")
            }
        }.awaitAll()
        println("done")
    }
}
```

Process in parallel.

```
runBlocking() {
    supervisorScope {
        val intRange = (1..10).map {
            async {
                println(it)
                delay(Random.nextLong(5000, 10000))
                println(it * it)
                it * it
            }
        }.awaitAll()

        println(intRange)
    }
}
```
