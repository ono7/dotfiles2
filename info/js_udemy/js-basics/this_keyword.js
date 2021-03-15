// this keyword references the object
// that is excecuting the current funtion

// method -> obj
// function -> global object (window in browsers, global in node)

// * this is references the object methods, if this is a function inside the
// method , than this will reference global or window and not the this method
// only a few functions give you the the option to pass and additional object
// to use inside, forEach is one of them

const video1 = {
  title: 'a',
  play() {
    console.log(this);
  }
};

video1.play();

video1.stop = function () {
  console.log(this);
};

video1.stop();

function playVideo() {
  console.log(this);
}

playVideo();

// method -> obj
// function -> global (window(browser), global(nodejs))

const video = {
  title: "a",
  tags: ['a', 'b', 'c'],
  showTags() {
    this.tags.forEach(function (tag) {
      console.log(this.title, tag);
    }, this)
  }
};

video.showTags();
