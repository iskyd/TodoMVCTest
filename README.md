# Run

This will run the server on port 8000

```sh
julia
using Pkg
Pkg.activate(".")
using Genie
Genie.loadapp()
up()
```

# Test
```sh
cd test
julia --project runtests.jl
```