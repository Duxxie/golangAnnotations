// +build tools

package tools

/* See https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md

This file is intended to be never compiled (because of the build tag). It merely states the imports, so go.mod will include them.
If you would remove this file and then run `go mod tidy` these dependencies could be removed from go.mod because then they can be "unused".
The point is that we just want the binary executables in /go/bin so we can use these tools in go:generate commands. We have no interest in the source code, but we want to track the version.
*/

import (
	_ "golang.org/x/tools/cmd/goimports"
)
