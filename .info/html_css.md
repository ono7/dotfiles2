# making a circle from a square

if you have a box, you can make it round by setting the border-radius to 100%

you can google css shapes and find info on how to create other shapes

```css
.box {
  width: 200px;
  height: 200px;
  border-radius: 100%;
}
```

# borders

```css
.box {
  width: 600px;
  height: 200px;
  background: dodgerblue;
  border: 10px dashed royalblue;
  border-width: 10px 20px 20px 10px; /* trbl top right bottom lest */
}
```

# selector specifity

determins the priority in which styling is applied when
multiple styles exists

id(single element) -> class & attribute -> element selector

override with `!important`

```css
/* do not let other rules override the color !important 
this is considered bad because it can be hard to troubleshoot
*/

section :first-child {
  color: green !important;
  font-style: italic;
}

/* better approach is to increate the priority by including other types */

.highlight#products :first-child {
  color: green !important;
  font-style: italic;
}
/* this now weights more because it has a class and an ID selector */
```

# pseudo element selector

they can be access in css with double ::

they are used to style `part` of an element

```css
/* change background color for mouse selection for all elements */
::selectionn {
  background-color: pink;
}

/* change background selection only for paragraphs */
p::selectionn {
  background-color: pink;
}
```

# pseudo class selectors

these are selectors injected by the browser

they can be access in css with :
they are used to style entire classes/whole element

these are considered brittle because the `first-child` might change but are useful

```css
/* add styling to the first child */
section :first-child {
  color: green;
  font-style: italic;
}

/* adds styling to the first of each type in section */
section :first-of-type {
  color: green;
  font-style: italic;
}

/* adds styling to the first of each type of paragraph element in section */
section p:first-of-type {
  color: green;
  font-style: italic;
}
```

# normalize css

normalize all css

download a copy from

`https://necolas.github.io/normalize.css/`

```html
<link rel="stilysheets" href="css/normalize.css" />
```

# validate pages/sites

`https://validator.w3.org` - takes URLs or file uploads

or search for css validator for css

# booleans in html

the presense of an attribute is equal to true, the absence
of an attribute means its false. adding "controls" below means
true, so there is no need to sawy `controls="true"`

`<video controls src="video/1.mp4"></video>`

# find free images

`https://unsplash.com`

# video elements

- `<video controls src="video/1.mp4"></video>` shows video and adds controls
- `<video controls autoplay src="video/1.mp4"></video>` shows video and adds controls, video automatially starts
- `<video controls autoplay loop src="video/1.mp4">the browser does not support video</video>` shows text when video is not available

# url/links href

`<a href=""></a>` hypertext reference or link

# html entities (display characters that are also part of html language such as <> )

google html entities for a full list

- `&nbsp` none break space (do not split the words when a line break is reached)
  place the &nbsp; between the two words that should never be split

```html
google html entities for a full list google html entities for a full&nbsp;list
google html entities for a full list google html entities for a
fullarstrastarsarsas list testing google html entities for a full list google
html entities for a full list google html entities for a full list google html
entities for a full list google html entities for a full list google html
entities for a full list google html entities for a full list google html
entities for a full list
```

`&lt;` displays less than
`&gt;` displays greater than

```html
<p>Testing &lt;HTML&gt;!</p>
<!-- ret: Testing <HTML> -->
```

# CSS elements

- `<em></em>` emphasis (do not use for italics)
- `<strong></strong>` represents strong importance, similar to emphasis
- `<b></b>` bold - depricated (use styling instead)
- `<i></i>` italic - depricated (use styling instead)
- `<h1></h1>` headings, 1-6, should be use as a heriarchical structure not for
  changing font size, styling can be used to change the size instead
