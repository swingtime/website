

/* Contact email for dynamic replacement */
var email = "(our group name here)-info@lists.stanford.edu";
/* Change current year so correct gigs are displayed */
var currentYear = '2016';

/* Limit event names to ~40 chars to prevent overflow */
/* Dates must have abbreviated month names, e.g. Jan, Sept, June, July, Aug */
var allEvents = {
  '2016': [
    {name: "Lynbrook Blue Pearl Dance", date: "Jan 30"},
    {name: "Mardi Gras Dinner", date: "Feb 6"},
    {name: "Stanford Viennese Ball", date: "Feb 27", url: "https://www.youtube.com/watch?v=L0lJ7pSyjeY"},
    {name: "Cardinal Dance Fusion", date: "Apr 1", url: "https://www.youtube.com/watch?v=jvxR1vo7oR8"},
    {name: "[M]ovement showcase at UC Berkeley", date: "Apr 9", url: "https://www.youtube.com/watch?v=GH69hGXl6ZI"},
    {name: "Cardinal Classic", date: "Apr 23"},
    {name: "Stanford Little Big Dance", date: "Apr 23"},
    {name: "Admit Weekend Expo", date: "Apr 29"},
    {name: "Swingtime Spring Show, \"Swing States 2016\"", date: "May 22"},
    {name: "Stanford Fall Ball", date: "Nov 11", url: "https://www.youtube.com/watch?v=iC5iIYd3ynQ"},
    {name: "Cardinal Ballet's \"The Nutcracker\"", date: "Dec 12", url: "https://www.youtube.com/watch?v=xJrsxkBXDxU"},
  ],
  '2015': [
    {name: "Cardinal Ballet's \"The Nutcracker\"", date: "Dec 12", url: "https://www.youtube.com/watch?v=z4xZtaLZ1X8"},
    {name: "tapTH@T Showcase", date: "Nov 8"},
    {name: "Stanford Fall Ball", date: "Nov 6", url: "https://www.youtube.com/watch?v=4ENBV6ftIdk"},
    {name: "Swingtime Spring Show, \"How The West Was Swung\"", date: "May 31", url: "https://www.youtube.com/watch?v=VwIlGsH38EU"},
    {name: "Stanford Big Dance", date: "May 8"},
    {name: "Autism Talks", date: "Apr 19"},
    {name: "Cardinal Classic Ballroom Competition", date: "Apr 18"},
    {name: "Toyon Special Dinner", date: "Apr 16"},
    {name: "Cardinal Dance Fusion", date: "Apr 3"},
    {name: "Stanford Viennese Ball", date: "Feb 27", url: "https://www.youtube.com/watch?v=wRsySOa12-Y"},
    {name: "Mardi Gras Dinner", date: "Feb 17"},
    {name: "Arrillaga Late Nights", date: "Feb 10"},
    {name: "Stanford Dance Marathon", date: "Feb 7"},
  ],
  '2014': [
    {name: "San Jose Museum of Art", date: "Nov 20"},
    {name: "Stanford Men's Basketball Halftime Show", date: "Nov 14"},
    {name: "Stanford Fall Ball", date: "Nov 7", url: "https://www.youtube.com/watch?v=XU1ehv1ybcE"},
    {name: "Stanford is Swinging", date: "Sep 19"},
    {name: "Swingtime Spring Show, \"Once Upon A Swingtime\"", date: "May 29", url: "https://www.youtube.com/watch?v=LugIrghzqGg&list=PLJ9wNhPecSxyROmqSSoSg951y0RzuM7qR"},
    {name: "Salseros Spring Show", date: "May 17", url: "https://www.youtube.com/watch?v=JBwNLVyPefI"},
    {name: "Urban Styles Spring Show", date: "May 10"},
    {name: "Stanford Big Dance", date: "May 9", url: "https://www.youtube.com/watch?v=AgTfLwZ7mRg"},
    {name: "Admit Weekend Dance Expo", date: "Apr 26"},
    {name: "Tap Th@t Spring Show", date: "Apr 25"},
    {name: "EnCounter Culture", date: "Apr 6"},
    {name: "Cardinal Dance Fusion", date: "Apr 3"},
    {name: "Stanford Geothermal Workshop", date: "Feb 25"},
    {name: "Parents Weekend Extravaganza", date: "Feb 22"},
    {name: "Stanford Viennese Ball", date: "Feb 7", url: "https://www.youtube.com/watch?v=MfiFdeEa24c"},
  ],
  '2013': [
    {name: "Common Origins Fall Showcase", date: "Dec 6"},
    {name: "Stanford Fall Ball", date: "Nov 1", url: "https://www.youtube.com/watch?v=HMYX2sTflWU"},
    {name: "Stanford is Swinging", date: "Sep 20"},
    {name: "Swingtime Spring Show, \"Swing it On\"", date: "May 30", url: "https://www.youtube.com/watch?v=oUhK1v0_gIg&list=PLJ9wNhPecSxwk6Tp0D7HX7rR_RRhW76qd"},
    {name: "Stanford Big Dance", date: "May 10", url: "https://www.youtube.com/watch?v=UUVuvCaw6xw"},
    {name: "Cardinal Classic Performance", date: "Apr 13"},
    {name: "Cardinal Classic Lindy Hop Competition", date: "Apr 13"},
    {name: "Cardinal Dance Fusion", date: "Apr 8"},
    {name: "The Next Bing Thing Audition", date: "Apr 6"},
    {name: "DV8 Encounter Culture Winter Show", date: "Mar 3"},
    {name: "Stanford Viennese Ball", date: "Feb 21", url: "https://www.youtube.com/watch?v=p-WKwJbJY4s"},
    {name: "Black History Month Performance", date: "Feb 1"},
    {name: "Genentech Holiday Party", date: "Jan 1"},
  ],
  '2012': [
    {name: "Common Origins Fall Show: Breaking Ground", date: "Dec 1"},
    {name: "Stanford Ivy League Dining Conference", date: "Nov 14"},
    {name: "Stanford Fall Ball", date: "Nov 2", url: "https://www.youtube.com/watch?v=QMGpucAFBnE"},
    {name: "Swingtime Auditions", date: "Oct 25-29"},
    {name: "Private corporate fundraiser (Portola Valley)", date: "Sep 29"},
    {name: "Stanford Activities Fair", date: "Sep 28"},
    {name: "Stanford is Swinging", date: "Sep 21"},
    {name: "Swingtime Spring Show, \"Lord of the Swings\"", date: "June 2", url: "https://www.youtube.com/watch?v=Bp6VIAaLQac&list=PL6F7B8FF08675EC21"},
    {name: "Hipnotizes, Alliance & Urban Styles Spring Show", date: "May 20"},
    {name: "Tap Th@t Spring Show", date: "May 20"},
    {name: "Sigma Nu SNAPS", date: "May 16"},
    {name: "Stanford Big Dance", date: "May 11"},
    {name: "Swingkids Live Band Night", date: "Apr 28"},
    {name: "Dance Expo Performance", date: "Apr 28"},
    {name: "Stanford Activities Fair", date: "Apr 27"},
    {name: "Cardinal Classic Competition", date: "Apr 21"},
    {name: "Cardinal Classic Performance", date: "Apr 21"},
    {name: "Cardinal Nights Performance 2", date: "Apr 6"},
    {name: "Cardinal Nights Performance 1", date: "Apr 4"},
    {name: "Wednesday Night Hop Performance", date: "Mar 15"},
    {name: "DV8 Encounter Culture Winter Show", date: "Mar 11", url: "https://www.youtube.com/watch?v=oVJJSVDs46w"},
    {name: "Stanford Men\'s Basketball Halftime Show", date: "Feb 16"},
    {name: "Stanford Dance Marathon", date: "Feb 11"},
    {name: "Stanford Viennese Ball", date: "Feb 10"},
  ],
  '2011': [
    {name: "Google Holiday Party Day 2 (U.S.S. Hornet)", date: "Dec 10"},
    {name: "Google Holiday Party Day 1 (U.S.S. Hornet)", date: "Dec 2"},
    {name: "Stanford Fall Ball",  date: "Nov 11", url: "https://www.youtube.com/watch?v=JrzqH3XHJV4"},
    {name: "Swingtime Auditions", date: "Oct 2-6"},
    {name: "Stanford Activities Fair", date: "Sep 30"},
    {name: "Stanford is Swinging", date: "Sep 23"},
    {name: "FACES Performance", date: "Sep 21"},
    {name: "Swingtime Spring Show Performance", date: "May 27", url: "https://www.youtube.com/watch?v=mge7CzCA8Yg"},
    {name: "Tap Th@t Spring Show Performance", date: "May 15"},
    {name: "Hipnotized, Alliance Spring Show Performance",  date: "May 11"},
    {name: "Stanford Big Dance", date: "May 6"},
    {name: "Cardinal Classic Competition", date: "Apr 23"},
    {name: "Cardinal Classic Performance",  date: "Apr 23", url: "https://www.youtube.com/watch?v=6rVcUvQNDkg"},
    {name: "Vision eARTh Performance", date: "Apr 22"},
    {name: "Cardinal Dance Expo Day 2", date: "Apr 2"},
    {name: "Cardinal Dance Expo Day 1", date: "Apr 1"},
    {name: "EnCounter Culture Performance", date: "Feb 27"},
    {name: "Stanford Viennese Ball", date: "Feb 17", url: "https://www.youtube.com/watch?v=Y-0FS8__AF4"},
    {name: "Dance Marathon Performance", date: "Feb 12"},
    {name: "The Mendicants Winter Show Performance", date: "Jan 29"},
    {name: "Dance-Off for Development of Literacy", date: "Jan 23"},
  ],
  '2010': [
    {name: "Sigma Nu SNAPS", date: "Nov 3"},
    {name: "Stanford Fall Ball", date: "Oct 22"},
    {name: "Party on the Edge", date: "Oct 14"},
    {name: "Swingtime Auditions", date: "Sep 25-30"},
    {name: "Stanford is Swinging", date: "Sep 17"},
    {name: "Historical Dance Week Performance", date: "June 22"},
    {name: "Los Salseros de Stanford Spring Show", date: "May 29"},
    {name: "Tap Th@t Spring Show", date: "May 15"},
    {name: "Relay for Life Performance", date: "May 15"},
    {name: "Swingtime Spring Show", date: "May 14", url: "https://www.youtube.com/watch?v=OkeZB6LQLWU&list=PLJ9wNhPecSxx2DKI7P4uunkbbbFG9DMyr"},
    {name: "Veterans Administration Performance", date: "May 11"},
    {name: "Stanford Big Dance", date: "May 10"},
    {name: "Urban Styles Spring Show Performance", date: "May 2"},
    {name: "Dance Expo Performance", date: "Apr 24"},
    {name: "GRID Workshop and Performance", date: "Apr 23"},
    {name: "Swingtime@Twain Performance", date: "Apr 23"},
    {name: "Swingtime@Activities Fair", date: "Apr 23"},
    {name: "M]ovement Performance (Berkeley)", date: "Apr 16"},
    {name: "Art Affair Performance", date: "Apr 16"},
    {name: "Stanford Ballroom Dance Team Winter Social", date: "Apr 5"},
    {name: "Urban Nights Day 2", date: "Apr 3"},
    {name: "Urban Nights Day 1", date: "Apr 2"},
    {name: "Entertainment Extravaganza", date: "Feb 27", url: "https://www.youtube.com/watch?v=xkaWjR1dy0w"},
    {name: "Stanford Viennese Ball", date: "Feb 19"},
    {name: "Wednesday Night Hop Performance", date: "Feb 17"},
    {name: "Dance Marathon Performance", date: "Feb 6"}
  ],
  '2009': [
    {name: "[M]ovement Performance (Berkeley)", date: "Dec 5"},
    {name: "Stanford Fall Ball",date: "Nov 9"},
    {name: "Swingtime Auditions", date: "Sep 27-30"},
    {name: "Stanford is Swinging", date: "Sep 18"}
  ]
};

$(document).ready(function() {
  resizeWindow();  // resizes the banner image to fill the user's screen
  $(".contact-link").attr("href", "mailto: " + email).text(email);  // dynamically replace emails to avoid web crawler spam
  addScrollingBehavior();
  $(".year").click(function() {
    switchYears($(this).text());
  });
  //initially start at correct year
  switchYears(currentYear);

  window.setTimeout(function() {
    $("#header-bg").addClass("transition");
    $("#logo").addClass("transition");
    $("#links").addClass("transition");
  }, 500);
});

/* Make sure the top image dynamically resizes with the window */
$(window).resize(function() {
  resizeWindow();
});

function eventCompare(a, b) {
  function dateCompare(a, b) {
    function intCompare(a, b) {
      if (a == b) {
        return 0;
      }

      return (a < b) ? -1 : 1;
    };

    function monthCompare(a, b) {
      var dict = {
        "Jan": 1,
        "Feb": 2,
        "Mar": 3,
        "Apr": 4,
        "May": 5,
        "June": 6,
        "July": 7,
        "Sept": 8,
        "Aug": 9,
        "Oct": 10,
        "Nov": 11,
        "Dec": 12,
      };

      return intCompare(dict[a], dict[b]);
    };

    var a_tokens = a.split(" ");
    var b_tokens = b.split(" ");
    var cmp = monthCompare(a_tokens[0], b_tokens[0]);
    if (cmp !== 0) {
      return cmp;
    } else {
      return intCompare(parseInt(a_tokens[1]), parseInt(b_tokens[1]));
    }
  };

  return dateCompare(a.date, b.date);
}

function switchYears(year) {
  var events = allEvents[year];
  events.sort(eventCompare);
  $(".year").removeClass("selected");
  $("#" + year).addClass("selected");
  var dates = $("#event-dates").empty();
  var names = $("#event-names").empty();
  for (var i = 0; i < events.length; i++) {
    dates.append($("<li>").text(events[i].date));
    //BOLD THE SPRING SHOW :D
    var name = events[i].name;
    var newElem = $("<li>");
    //make a hyperlink if there is a link to a youtube video of the performance
    if(events[i].url) {
      newElem.html("<a href=\"" + events[i].url + "\" target=\"_blank\">" + name + "</a>");
    }
    else {
      newElem.text(name);
    }
    if(name.indexOf("Swingtime Spring Show") >= 0) {
      newElem.css("font-weight","Bold");
    }
    //names.append($("<li>").text(events[i].name));
    names.append(newElem);
  }
}

/* Resizes the banner image to fit the user's screen */
function resizeWindow() {
  var height = $(window).height();
  $("#banner").height(height + "px");
  $("#banner-container").height(height + "px");
  $("#content").css("top", height);
}

/* Handles the navbar scrolling animation */
function scrollToAnchor(anchorId) {
  var h1Tag = $("h1[name='" + anchorId + "']");
  $("html, body").stop(true, true).animate({scrollTop: h1Tag.offset().top - 100}, "slow");
}

$("#links a").click(function() {
  scrollToAnchor($(this).text());
});

/* Scrolls to the appropriate section when a navbar link is clicked and highlights as the user scrolls */
function addScrollingBehavior() {
  var about = $("h1[name='about']").offset().top - 200;
  var auditions = $("h1[name='auditions']").offset().top - 200;
  var booking = $("h1[name='booking']").offset().top - 200;
  var members = $("h1[name='members']").offset().top - 200;
  var contact = $("h1[name='contact']").offset().top - 500;  // Extra high offset of 500 since contact is at the bottom of the page

  $("#mini-logo").click(function() {
    $("html, body").animate({scrollTop: 0}, "slow", "easeInCirc");
  });

  $(window).scroll(function() {
    /* Activates the navbar withdrawal when scrolling down */
    var top = $(this).scrollTop();
    if (top > 1) {
      $("#mini-logo").css("opacity", 1);
      $("#logo").css("opacity", 0);
      $("#header-container").addClass("sticky");
      $("#links").addClass("sticky");
      $("#banner").addClass("sticky");
    } else {
      $("#mini-logo").css("opacity", 0);
      $("#logo").css("opacity", 1);
      $("#header-container").removeClass("sticky");
      $("#links").removeClass("sticky"); 
      $("#banner").removeClass("sticky");
    } 

    /* Highlights the appropriate top-nav link */
    $("#links a").removeClass("selected");
    if (top >= about && top < auditions) {
      $("#about").addClass("selected");
    } else if (top >= auditions && top < booking) {
      $("#auditions").addClass("selected");
    } else if (top >= booking && top < members) {
      $("#booking").addClass("selected");
    } else if (top >= members && top < contact) {
      $("#members").addClass("selected");
    } else if (top >= contact) {
      $("#contact").addClass("selected");
    }
  }); 
}
