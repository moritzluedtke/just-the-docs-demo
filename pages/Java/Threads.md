# Java Threads

## ThreadPool

```java
ThreadPoolExecutor poolExecutor = (ThreadPoolExecutor) Executors.newFixedThreadPool(10);
poolExecutor.submit(() -> {
  // code to execute aka task
});
```

All tasks will be added to a queue. This queue is processed by the ThreadPool. Processing starts while the queue is still being filled.

[Source](https://www.baeldung.com/thread-pool-java-and-guava)
