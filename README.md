# crystabit

CaaS (component-as-a-service) CPU emulator, written in functional-style Crystal using TDD.

Definitely a good learning experience.

## Installation

First, you need Crystal 0.25.0 or above.

```bash
curl -sSL https://dist.crystal-lang.org/apt/setup.sh # Adds repo key & config
sudo !!
sudo apt install crystal
```

Then, clone repo and install local dependencies...

```bash
git clone git@github.com:mmKALLL/crystabit.git
shards install
```

## Usage

You can run local specs using:
```bash
crystal spec
```

Run all specs, including Web API specs with Kemal test server, using:
```bash
KEMAL_ENV=test crystal spec
```

Run CPU emulator and its server on localhost:3000 using:
```bash
crystal src/crystabit.cr
```

Then you can run things using the REST API! (Examples written with HTTPie, but cURL works just as well.)
```bash
# Sum two Int64 values together:
http get localhost:3000/v1/cpu/exec?opcode=0x7c&inputs=[12,321] # => 333

# Execute from a mnemonic:
http get localhost:3000/v1/cpu/exec?opcode=set_local&inputs=["localvar",1234] # =>
http get localhost:3000/v1/cpu/exec?opcode=get_local&inputs=["localvar"] # => 1234

# Run full-blown WebAssembly from the query string!
http get localhost:3000/v1/cpu/run?program=(local $res i32)(set_local $res (i32.add (2)(7)))(get_local $res) 

# ...Or upload a file for immediate interpretation:
http post localhost:3000/v1/cpu/run {program:"..."} # Results in response body

# Please no infinite loops until beta.
```


## Development

Write specs, then write code to implement their features, and refactor when useful. Keep consistent style and have fun!

## Contributing

1. Fork it (<https://github.com/mmKALLL/crystabit/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- \[[mmKALLL](https://github.com/mmKALLL)\] Esa Koskinen - creator, maintainer
