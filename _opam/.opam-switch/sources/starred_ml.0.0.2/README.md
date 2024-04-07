Starred_ml - Github Awesome list based on starred proejct
---

Are you a compulsive Github stargazer? `Starred_ml` is here for you! It will access Github `https://api.github.com/user/starred` API and fetch all starred repositories and dump a mardown that you can use as
`README.md` in a repository.

## Running

```shell
TOKEN={{your github personal token}} opam Starred_ml 
```

Will output something liket this:  

```mardkown

Awesome Starts
===

> A curated list of Github starts! Geberated by [starred_ml](https://github.com/paulosuzart/starred_ml)


Languages
---
   - [C](#C)
   - [C#](#C#)
   - [C++](#C++)
   - [Clojure](#Clojure)
   - [Elixir](#Elixir)
   - [Go](#Go)
   - [Groovy](#Groovy)
   - [Haskell](#Haskell)
   - [Java](#Java)
   - [Jupyter Notebook](#Jupyter Notebook)
   - [Lua](#Lua)
 ...

Contents
---

## C
   - [PikaPython](https://api.github.com/repos/pikasTech/PikaPython): An ultra-lightweight Python interpreter that runs with only 4KB of RAM, zero dependencies. It is ready to use out of the box without any configuration required and easy to extend with C. Similar project: MicroPython, JerryScript.
## C#
   - [kiota](https://api.github.com/repos/microsoft/kiota): OpenAPI based HTTP Client code generator
...

```

Templating
---

`Starred_ml` uses [jingoo](https://github.com/tategakibunko/jingoo) as a template engine. Create a `default.jingoo` file if you want to customize. Please refer to the provided template [here](default.jingoo) and customize as you see fit. 

The availabe variables are:
   - `lang_count` - The total count of languages found (Including `Not set`)
   - `languages` - a list of languages detected across all starred repos
   - `by_language` - a list of objects representing starred repositories with the following keys:
      - `language` - the language of in question
      - `starred` - a list of objects with the following keys:
         - `name` - name of the repository
         - `url` - Github url
         - `description` - repository description

Similar projects
---
While developing `Starred_ml` I found at least one alternative:

   - [smaguowei/starred](https://github.com/maguowei/starred) written in python. I then proceeded to use a similar output
