## syntax keywords

`{{ define ...}}`
`{{ template ...}}`
`{{ block ...}}`
`{{ if <var> }} {{ else if <var> }} {{ else }} {{ end }}`
`{{ with <var> }} {{ end }}`
`{{ range <var> }} {{ else }} {{ end }}`

- anything else (and, or, not len, index) is a function

## use template.Must() when possible

this will display a better error msg when rendering

separate the rendering and response

```go
var buff bytes.buffer
err := tpl.Execute(&buff, p)
if err != nil {
    log.Println("error:", err)
    http.Redirecp(w, r, "/error", http.StatusTemporaryRedirect)
    return err
}
buff.Write(w) // write to http stream

```

## examples

```go

struct {
    Params: Params {
        Author: Author {
            FirstName: "john",
            LastName: "Doe",
          },
      },
  }

// `{{ . }}` --> represent the entire struct
// `{{ .Params.Author.FirstName }}` --> represents FirstName
// alternative for maps
// `{{ index . "Params" "Autor" "FirstName" }}`
```

- variables must be passed explicitely down to templates

```go
{{ define "footer" }}
  {{ Params.Test.FirstName }}
{{ end }}

{{ template "footer" . }} // must past "dot" . for it to work when called from other templates

```

- assinging to variables

```go
{{ define "greet" }}
{{ $firstname := .Params.FirstName }}
  <p>hello my name is {{ $firstname }}</p>
{{ end }}
```

## evaluation is truthy/falsy

```go
{{ if eq (len .Users) 0 }} // dont do this
{{ end }}
// do this
{{ if .Users }}
{{ end }}
```

## template varaibles "dot." and "dollar$"

dot and dollar represent the current template variable

{{ $.Params.Firstname }} // samething
{{ .Params.Firstname }} // samething

**DOT** changes values depending on the context (with and range blocks)
**$** will always point to the current top variable, even within the (with and
range) blocks

```go
User: {
    FirstName: "jonh",
    LastName: "Doe",
  }

  {{ with .User.Firstname }}
    <p>FirstName: {{ . }}</p>
    <p>LastName: {{ $.User.LastName }}</p>
  {{ end }}
```

```go
template variable:
{
  "Users": [
    {
    "FirstName": "John",
    "LastName": "Doe"
    },{
    "FirstName": "Jane",
    "LastName": "Doe"
    }
  ],
  "Today": "Thursday"
}

{{ range .Users }}
  <p>firs_name: {{ .FirstName }}</p>
  <p>today: {{ $.Today }}</p>
{{ end }}

// range over slices
{{ range $i, $user .Users }}
  <p>username: {{ $user.FirstName }}</p>
  <p>index {{ $i }}</p>

{{ end }}
// for maps

{{ range $key, $value .UsersMap }}
  <p>key {{ $key }}</p>
  <p>value {{ $value }}</p>
  <p>{{ $key }}:{{ $value }}</p>
{{ end }}
```

## conditionals

```go
{{ if <and,or,not> }} {{ end }}
{{ len <var> }} // of type: slice, array, map, channel
{{ index <slice> <num> ...}}
{{ index <map> <key> ...}}
```

## template composition

```go
{{ template "newtemplatename" }}
{{ define "newtemplatename" }}
<body>
  blah blah blah
</body>
{{ end }}

// or better (samething)
// block is syntax sugar for the above syntax

{{ block "newtemplatename" }}
<body>
  blah blah blah
</body>
{{ end }}

// now we can import this template



```
