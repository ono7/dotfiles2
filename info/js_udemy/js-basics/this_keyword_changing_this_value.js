// method -> obj
// function -> global (window(browser), global(nodejs))
// you can assign a variable this and use that new
// variable to pass to methods that do not support passing this keyword

const video = {
  title: "a",
  tags: ['a', 'b', 'c'],
  showTags() {
    const self = this;
    this.tags.forEach(function (tag) {
      console.log(self.title, tag);
    })
  }
};

video.showTags();
