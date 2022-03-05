const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
	host: keys.redisHost,
	port: keys.redisPort,
	// if connecton is lost, try to connect to the server every second
	retry_strategy: () => 1000,
});

// subscription
const sub = redisClient.duplicate();

// Calculate fib
function fib(index) {
	if (index < 2) {
		return 1;
	}

	return fib(index - 1) + fib(index - 2);
}

// Whenever a new value shows up in Redis, we will calculate a new fib value
sub.on('message', (channel, message) => {
	redisClient.hset('values', message, fib(parseInt(message)));
});
// Subscribe to insert event
sub.subscribe('insert');
