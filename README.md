# Swingtime website

Hello, future Swingtime webmasters. This website has been through many
iterations and the code has gotten pretty ugly in the past, so this README is
an effort to explain how to maintain the site without too many headaches!

## Viewing the site locally

1. Make sure you have Git and Node.js installed on your computer.

2. Install a simple http server, e.g.
   [http-server](https://www.npmjs.com/package/http-server).

```
> npm install http-server -g
```

3. Clone this repository onto your computer.

```
> git clone https://github.com/swingtime/website.git
```

4. Go into the website directory and start the http server.

```
> cd website
> http-server
```

5. Visit the site in your browser, probably at
   `http://localhost:8080/home.html`.

## Editing the site locally

The `.htaccess` file in this directory is configured to serve `home.html`
whenever someone requests the Swingtime website (the person writing this
README doesn't fully understand how that works -- more info
[here](https://uit.stanford.edu/service/web/redirects)). So, anything you put
in `home.html`, or reference from `home.html`, will be available on the site.

The website is built with [Bootstrap
4.1](https://getbootstrap.com/docs/4.1/getting-started/introduction/), as well
as some custom styles (`css/style.css`) and JavaScript (`js/banner.js`).

### Adding new members

First, add a photo of the new member to the `images/members` directory. Try to
crop it like the other member photos and keep it fairly low resolution so the
website loads quickly.

Then add another entry to the list of members in `home.html`, underneath the
`<h1 name="members">` tag.

### Updating auditions info

There are two version of the Auditions section of the site in `home.html` --
one to display during auditions season, and the other to display during the
rest of the year. Once audition dates are nailed down, uncomment and update
the relevant section of the site, and comment out the other Auditions section.
You'll also need to update the navbar links (inside the `<nav>` tag at the top
of the site). You can reverse those changes once auditions are over.

### Updating slideshow photos

The slideshow uses
[Bootstrap Carousel](https://getbootstrap.com/docs/4.0/components/carousel/).
To add a new photo:

1. Put the image file in the `images/slideshow` directory, e.g. `slide1.jpg`.

2. Add a new CSS rule to `style.css`; for example:

```css
.slide1 {
  background-image: url('../images/slideshow/slide1.jpg');
}
```

2. In `home.html`, add a new `<li>` to the
   `<ol class="carousel-indicators">` list.

3. Underneath that, add a new child to the `<div class="carousel-inner">`
   element, e.g. `<div class="carousel-item slide1"></div>`.

### List of past gigs

The site used to have a list of our past gigs, but no one was updating it and
it was very out of date. If you would like to continue maintaining that, you
can uncomment it in `home.html`. Here are the instructions for maintaining it,
from the old version of this README:

> js/banner.js
>   - To add a new year, add a new div in the home.html, and add a new
>     year to the allEvents variable.
>   - Add new events per each year here. See allEvents variable.
>     - Follow the month abbreviation in the comment, events are sorted in
>       ascending order according to eventCompare.

## Deploying changes

To actually deploy changes, you'll need to update the contents of the
`/afs/.ir/group/swingtime/WWW` directory on Stanford's servers. More info
[here](https://uit.stanford.edu/service/web/centralhosting/howto_group).

I recommend you avoid directly modifying those files, and instead make changes
locally, check that they look good, commit them to Git, push those changes to
GitHub, and then pull the latest changes from within the `WWW` directory on
Stanford's servers. Here are the steps to do that.

1. Make your changes, and follow the steps in *Viewing the site locally* to
   check that everything looks okay.

2. Commit your changes to the `master` branch using Git, and push those
   changes to GitHub. I highly recommend reading about Git to understand how
   it works, but you should end up doing something similar to the following:

```
> git add .
> git commit -m 'Add new member photos'
> git push
```

3. `ssh` into a Stanford server and change to Swingtime's `WWW` directory:

```
> ssh <username>@rice.stanford.edu
> cd /afs/.ir/group/swingtime/WWW/
```

3. Pull the changes from GitHub.

```
> git pull
```

4. Visit `swingtime.stanford.edu`. You should see your changes. If you don't,
   the website might be cached. Try doing a hard refresh (on a Mac you can do
   this in most browsers by holding Shift and clicking the refresh button).

## Giving permission to future webmasters

Access to the `WWW` directory is controlled by an Access Control List. You'll
need to give new webmasters access to add/modify files. Information about how
to manage ACLs is available
[here](http://web.stanford.edu/services/afs/sysadmin/userguide/file-permissions.html).
You will probably need to do something like the following, which recursively
gives the designated user administrative access to files in the current
directory and all its subdirectories:

```
> fsr setacl . <username> rlidwka
```

If you list permissions for the current directory, you should now see that
person's username:

```
> fs listacl
```

You will also need to add new webmasters to the Swingtime organization on
GitHub, so that they can push to the repository.

## The `members` directory

It appears that there used to be an old, members-only area of the website. It
has lots of old files, including descriptions of our choreos, Swingtime
documents, quotes, and other stuff from 2002-2006. I've kept it here for now
because it's fun to look through, and someone should go through it and see if
we want to put any of it elsewhere. I already transferred the choreo
descriptions to the Google Drive. Future webmasters are welcome to delete this
directory (of course, it will always be stored in the Git history in case we
want to go back and look at it).
