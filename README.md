# Go Session Authentication
[![Build Status](http://img.shields.io/travis/apexskier/httpauth.svg)](https://travis-ci.org/apexskier/httpauth)
[![Coverage Status](https://coveralls.io/repos/github/apexskier/httpauth/badge.svg?branch=master)](https://coveralls.io/github/apexskier/httpauth?branch=master)
[![GoDoc](http://img.shields.io/badge/godoc-reference-blue.svg)](https://godoc.org/github.com/apexskier/httpauth)
![Version 2.0.0](https://img.shields.io/badge/version-2.0.0-lightgrey.svg)

See git tags/releases for information about potentially breaking change.

This package uses the [Gorilla web toolkit](http://www.gorillatoolkit.org/)'s
sessions package to implement a user authentication and authorization system
for Go web servers.

This fork from [https://github.com/apexskier/httpauth](https://github.com/apexskier/httpauth) includes support only for MongoDB as the data storage backend to ensure a clear, working example for folks using [MongoDB](https://godoc.org/github.com/apexskier/httpauth#NewMongodbBackend) and [mgo](http://gopkg.in/mgo.v2).

Access can be restricted by a users' role.

Uses [bcrypt](http://codahale.com/how-to-safely-store-a-password/) for password
hashing.

```go
var (
    aaa httpauth.Authorizer
)

func login(rw http.ResponseWriter, req *http.Request) {
    username := req.PostFormValue("username")
    password := req.PostFormValue("password")
    if err := aaa.Login(rw, req, username, password, "/"); err != nil && err.Error() == "already authenticated" {
        http.Redirect(rw, req, "/", http.StatusSeeOther)
    } else if err != nil {
        fmt.Println(err)
        http.Redirect(rw, req, "/login", http.StatusSeeOther)
    }
}
```

Run `go run server.go` from the examples directory and visit `localhost:8009`
for an example. You can login with the username "admin" and password "adminadmin".

Tests can be run with:

```bash
$ go test -test.v
=== RUN   TestNewAuthorizer
--- PASS: TestNewAuthorizer (0.04s)
=== RUN   TestRegister
--- PASS: TestRegister (0.08s)
=== RUN   TestUpdate
--- PASS: TestUpdate (0.00s)
=== RUN   TestLogin
--- PASS: TestLogin (0.21s)
=== RUN   TestAuthorize
--- PASS: TestAuthorize (0.14s)
  auth_test.go:135: Authorization: didn't catch new cookie
=== RUN   TestAuthorizeRole
--- PASS: TestAuthorizeRole (0.14s)
=== RUN   TestLogout
--- PASS: TestLogout (0.00s)
=== RUN   TestDeleteUser
--- PASS: TestDeleteUser (0.00s)
=== RUN   TestMongodbInit
--- PASS: TestMongodbInit (0.00s)
=== RUN   TestNewMongodbAuthBackend
--- PASS: TestNewMongodbAuthBackend (10.65s)
=== RUN   TestMongodbReopen
--- PASS: TestMongodbReopen (0.00s)
PASS
ok    httpauth-fork 11.261s
```

Make sure to install and start MongoDB before running the tests. The script `start-test-env.sh` can help to start an instance of MongoDB.

You should [follow me on Twitter](https://twitter.com/apexskier). [Appreciate this package?](https://cash.me/$apexskier)

### TODO

- User roles - modification
- SMTP email validation (key based)
- More backends
- Possible remove dependance on bcrypt
