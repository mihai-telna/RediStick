# RediStick
A Redis client for Pharo using Stick auto-reconnection layer

Many parts are borrowed from RedisClient.

However RediStick use [Stick](https://github.com/mumez/Stick) for supporting auto reconnection.

## Installation

Default (Core only):

```smalltalk

Metacello new
  baseline: 'RediStick';
  repository: 'github://mumez/RediStick/repository';
  load.
```

With Connection-Pool package:

```smalltalk

Metacello new
  baseline: 'RediStick';
  repository: 'github://mumez/RediStick/repository';
  load: #('Core' 'ConnectionPool').
```

## Sample Code

### Basic usage

```smalltalk
stick := RsRediStick targetUrl: 'sync://localhost'.
stick connect.
stick beSticky. "Auto reconnect when server is not accessible"
stick onError: [ :e | e pass ].
stick endpoint info.
stick endpoint get: 'a'.
stick endpoint set: 'a' value: 999.
```

### Using a connection pool with a wrapper class

```smalltalk
RsRedisConnectionPool primaryUrl: 'sync://localhost:6379'.
redis := RsRedisProxy of: #client1.
redis at: 'a'.
redis at: 'a' put: 999.
```
