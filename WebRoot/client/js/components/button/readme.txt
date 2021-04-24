Redesign of the HTML5 client
----------------------------

We are going to make 'components' for the different arcplan object types, starting with button.

We will start structuring the project by feature.
So everything belonging to a button belongs in the button component folder:
	- javascript files
	- css files
	- html templates
	- unit tests
	- casper tests (test the button component in a static html file, i.e. without an arcplan session)
	- documentation, etc.

We are aiming for a loosely coupled modular struture.

See task 25144 
See blog post https://insider.arcplan.com/team/dev/Blog/Lists/Posts/Post.aspx?ID=820