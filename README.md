# interview-project
Bookshout interview project.

Assignment: Using the GitHub Search API, implement a web app that queries repositories based on user input and displays the following data / options:

Business Requirements:
- A list of the results along with the programming language for that repo
- A filtering of the results based on the languages returned (can use AJAX or make separate requests)
- Sort by stars in either asc or desc order
- Pagination, if available
- Persist the user's information upon logging in to the app in a DB

Technical Requirements:
- Use Ruby on Rails as backend app.
- Push code to GitHub public repo
- While the GitHub search API is public and can be used without authentication, you must authenticate your user and make authenticated requests. Use oauth.
- It must be deployed to either a micro EC2 instance or Heroku Instance
- You must persist some data in a database. Ideally, this would be the user's information that comes back from their API after authenticating with OAuth 2


Everything else is up to you and you are free to use any tools / libaries you need to get the job done. 

Things we look for:
- Code quality
- Specs / Tests
- Use of tools / gems / etc
- Speed of completion (On average, people get it knocked out in 3 days max)
- Anything you think will make your app special. Extra credit is always good.

# Implementation Notes

This is my first Rails project, so the bulk of my time ended up being spent just in reading docs/tutorials and getting a feel for how a Rails app fits together.  There's a lot of places where I strongly suspect there's a cleaner, more idiomatic approach than what I used.

One of my goals during development was to do everything server-side, in Ruby, with no JS, since I intended to use the project primarily as a learning experience, rather than being slick and doing something clever on the client side (like using JS to access the GitHub API directly from the client).

### Gems and APIs

Gems Used (other than Rails default Gemfile):
- devise: login/session
- omniauth/omniauth-github: free oauth2 integration with GitHub
- octokit: wrapper around GitHubs REST API
- pry: console and emacs inspection and completion

I initial spent a fair amount of time looking to implement raw OAuth by hand, then with OmniAuth.  This proved hairy, especially since I didn't at the time understand how routing/sessions were being handled.  In further exploration, I discovered `devise` and its built-in `omniauth` support, shortly followed by the discovery of `omniauth-github`.  Once I figured out what was going on, I was able to slot in `devise` + `omniauth-github` without having to write almost any code.  Additionally, I was very pleased with `omniauth-developer` and the ability to seamlessly switch between developer auth on my local machine and GitHub on production without the rest of the app having to know any different.

By the time I got to integrating GitHubs API for search, `octokit` was an easy find and plugged in easily.

Overall the experience of finding, adding, and integrating gems/APIs was pleasant and accessible.

### Templates, HTML, and CSS
A rough patch was the actual HTML generation.  Understanding the mapping from controller instance variables/parameters to views was straightforward enough, but I didn't feel like I was making good use of the platform.  In particular, I strongly suspect that my use of the `form_tag/label_tag/*field_tag` helpers would be better replaced by use of the Form Builder system and Rails model/form inspection/autogeneration systems.  It's not clear to me if this would require reifying the notion of a "search query" into a model of its own, or whether Rails supports the notion of Models that are not directly backed by the database.  This is something I'd like to spend some more time researching.

I like the HTML partials feature, and it felt natural to use.

I've used LESS extensively, so SCSS felt natural and intuitive to me, although I really didn't do anything interesting with it.

RE Pagination:
I don't feel my solution was terribly elegant, and I'd certainly want to make better use of all the auto-pagination APIs I found during development.  Most of these APIs seemed to expect direct interaction with models in the database, or subsets/queries thereof, which doesn't really seem to work with the pass-through/somebody-elses-problem approach I was using.  I'd have to find a way to make the auto-paginator integrate with GitHubs notion of pagination, and I never made "search-result" into a model of its own.

### Testing
Errr, you got me there.  I didn't really do anything here.  Looking at the DSL Rails provides does make me want to get into this properly, but I wanted to wrap things up.  In particular, I really like the ability to test the generated HTML from a view with the likes of `assert_select`.  The fixtures system looks very usefull as well.


### Ruby, Rails, and "magic"
Ruby is, perhaps, the most "magical" language I've ever used, and Rails seems to push it to the greatest possible extent.  This seems both good and bad, but mostly it just sits really poorly with my own "explicity defined/statically typed everything" development philosophy.

I like the `link_to` tag, and the auto-generated `controller_xyz_url` symbols, but you just have to know they exist.  Likewise with `devise` (and the Ruby idiom of using methods/DSLs in class definition generally), the `devise` method and the `:omniauthable`/etc symbols just "appear of out of nowhere" without so much as an import statement.  Another instance of this is the `radio_button_tag` autogenerating the `:<radio group name>_<value>` symbols used for linking the radio buttons to their labels.  It's not a bad thing, it's just "magical" and requires the programmer to keep a lot of behavior in their head.  I'm sure it becomes more natural with enough doc-reading time and experience, though I suspect many gems have their own unique DSLs to learn.

I really did like when Ruby caught me in a PHP-ism of comparing a query parameter (`@page` coming in as a string) to a number.  I prefer statically typed languages, but it's incredibly refreshing to be using a dynamic language that is at least sanely-typed.

### Other Notes

`web-console` is pretty cool.  Heroku was easy to work with.  GitHubs API is pretty nice, and `octokit` was easy to use.  I mentioned this above, but `omniauth` automatically switching between `developer` and `github` auth was pretty neat, and it really seems like a very powerful tool.  In fact, the experience I had with `omniauth` gives me a lot of faith in the ability to rapidly add major new features very quickly through the Rails ecosystem.
