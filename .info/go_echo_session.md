```go
package main

import (
	"net/http"

	"github.com/labstack/echo"
	"github.com/labstack/echo-contrib/session"
	"github.com/labstack/echo/middleware"

	// "net/http"
	"github.com/gorilla/sessions"
)

func main() {

	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// CORS
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{"*"},
	}))

	// Session
	e.Use(session.Middleware(sessions.NewCookieStore([]byte("secret")))) // เทียบกับการเก็บไว้ใน VAR ปกติ

	e.GET("/login", func(c echo.Context) error {
		sess, _ := session.Get("authenticate-sessions", c)
		sess.Options = &sessions.Options{
			Path:     "/secret",
			MaxAge:   86400, // (86400) => 24 * 60 * 60 => ออกมาเป็นวินาที แปลว่ามีอายุ 1 วัน * 7 ==> 7 วัน
			HttpOnly: true,
		}
		// Authentication goes here
		// ...

		// Set user as authenticated
		sess.Values["authenticated"] = true
		sess.Save(c.Request(), c.Response())
		return c.NoContent(http.StatusOK)
	})

	e.GET("/logout", func(c echo.Context) error {
		sess, _ := session.Get("authenticate-sessions", c)
		// Revoke users authentication
		sess.Values["authenticated"] = false
		return c.NoContent(http.StatusOK)
	})

	e.GET("/secret", func(c echo.Context) error {
		sess, _ := session.Get("authenticate-sessions", c)
		if auth, ok := sess.Values["authenticated"].(bool); !ok || !auth {
			return echo.NewHTTPError(http.StatusUnauthorized, "Please provide valid credentials")

		} else {
			return c.JSON(http.StatusOK, "You're able to read a secret")
		}

	})

	// Start server
	e.Logger.Fatal(e.Start(":8082"))

}

```
