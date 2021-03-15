// function -> global (window, global)
// arrow functions inherit the this value

const video = {
  title: 'a',
  tags: ['a', 'b', 'c'],
  showTags() {
    this.tags.forEach(function (tag) {
      console.log(this.title, tag);
    }.bind(this));
  }
};

video.showTags();
