(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using TodoMVCTest
push!(Base.modules_warned_for, Base.PkgId(TodoMVCTest))
TodoMVCTest.main()
