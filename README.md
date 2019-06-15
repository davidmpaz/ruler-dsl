Ruler external DSL
==================

These projects are an external domain specific language (DSL) for typing
[Ruler](https://github.com/bobthecow/Ruler) rules in a more concise way.

Its helps because you can express your rules with less typing, improve
readibility of business rules and the DSL allows for a syntax not as
technical as a programming language, so non programmers could understand
easier what is it expressed in rules.

Building/Installing
-------------------

The DSL is build with [Xtext](http://www.eclipse.org/Xtext/) so first
it is needed to have an eclipse installation with their packages, or just
download a full eclipse install from their web site.

After getting Xtext:

* Clone this project and open it as a workspace of eclipse.
* Import all `org.ruler.*` projects on it. You will get lot of warnings/errors.
* Create the missing `src-gen` folder on project org.ruler.
* Generate the Xtext artifacts for the grammar.
	- Open `org.ruler.Modeller.xtext`
	- Right click on editor and: _Run As / Run Xtext Artifacts_.
* Create any missing folder on project `org.ruler.sdk`, if any.
* If some weird characters show up, change eclipse editor encoding to UTF-8.

From here the projects can be exported as eclipse plugins and installed
as any other eclipse plugin.

Ruling
------

For seeing how to create your rules in the editor, a look can be taken into
the sample project: `TestingRuler` in this same workspace. It is the DSL
variant of the Modus Ponens rules exposed as unit tests in
[RulerTest](https://github.com/bobthecow/Ruler/blob/master/tests/Ruler/Test/Functional/RulerTest.php)

* Import the project into workspace.
* Configure base package as `Cid.Ruler`.
* Clean project or open a `.rules` fles and save it to trigger the code generation.
* Install composer dependencies.
* Run tests.

### Starting a new project

Once the eclipse plugins (DSL) are installed on your eclipse instance do:

1. Create new `General Project`.
2. Create new file with extension `.rules`. If asked to add Xtext nature to project accept it.
3. Edit your rules files.

You can have already a php project created and then just create the _.rules_
file and this will have same result. It is only need to take care of some 
configurations on paths and namespaces to mae it match your current project
namespacing.

### Configuration

Workspace configuration for the DSL editor can be found under menu: 
_Windows / Preferences_ filter options by `Modeller`.

There are several configurations related to the DSL editor you can tweak,
related to the DSL look and feel, like font, colors to use (**Syntax Coloring**),
code template snippets to increase productivity when typing (**Templates**).

Others related to the code generation (**Compiler**) process which specify 
output folders; and currently, only one custom configuration option
which state the **base package** where the code for the rules will be 
generated. This last option is a **project specific configuration** and
as such should be accessed through the _Project / Properties_ dialog.

### Some notes

> * At the time of this writing the [Ruler](https://github.com/bobthecow/Ruler)
framework need some modifications to work with the current generated code by DSL.
A pull request has been sent and it waits for acceptance, that's why for now it is
needed to use a [fork](https://github.com/davidmpaz/Ruler/tree/proposition-impl) 
in your composer dependencies, note the name of the branch.

> * Previously was mentioned words like _compiler_, _code generation_. Take into
account that what we do with the generated model once we have our rules, can be 
changed, compiling could be write some php files like it is now, but it could also be
execute the rules logic directly taking data from databases or what ever we need, 
the DSL is just, hopefully :), a simpler interface for coding Ruler rules easier.

> * Base Package option should be given with **dot notation**, 
ex: `Psr.Log.LogLevel`

> * Look at the example project to see how to configure composer to look for
code in namespaces for manual editing code or generated code by the compiler.
Running the tests once all dependencies are installed is like any other composer
project: `./vendor/bin/phpunit`

TODO
----

* Include support for all [operators](https://github.com/bobthecow/Ruler/tree/master/src/Ruler/Operator) 
  into DSL grammar. Currently only a few are supported.
* Fully support callable usage in conditions, grammar is there but no usage on compiler yet.
* Improve the editor.
	- Add validation rules to dsl as well as its _fixme_ functionality when possible.
	- Customize outline.
	- Adding icons for grammar elements.
* Wait for feedback ;)
