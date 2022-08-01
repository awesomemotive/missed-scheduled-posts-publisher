# Missed Scheduled Posts Publisher PHPUnit tests suite

## Running the tests

The units tests use a [prebuilt Docker image](https://github.com/humanmade/plugin-tester).

Before running the tests, make sure you have Docker up and running on your machine. Then run the following command from the plugin root directory:

```bash
docker run --rm -v "$PWD:/code" humanmade/plugin-tester
```
