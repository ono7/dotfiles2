// arrow functions were introduced in ES6

// method -> object
// function -> global (window, global)
// arrow functions inherit this!!!
// this is the preffered method to access this inside
// funtions that do not support passing this as an argument

const video = {
  title: 'a',
  tags: ['a', 'b', 'c'],
  showTags() {
    this.tags.forEach(tag => {
      console.log(this.title, tag);
    })
  }
};

video.showTags();
