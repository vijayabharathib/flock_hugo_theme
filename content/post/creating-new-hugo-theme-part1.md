+++
author = "michaelhenderson"
date = "2017-06-16T22:02:51+05:30"
publishdate = "2017-06-16T22:02:51+05:30"
subtitle = "Sample content for new themes"
tags = ["hugo","theme"]
title = "Creating new hugo theme - Part 1"
+++


## Introduction

This tutorial will show you how to create a simple theme in Hugo. I assume that you are familiar with HTML, the bash command line, and that you are comfortable using Markdown to format content. I'll explain how Hugo uses templates and how you can organize your templates to create a theme. I won't cover using CSS to style your theme.

We'll start with creating a new site with a very basic template. Then we'll add in a few pages and posts. With small variations on that, you will be able to create many different types of web sites.

In this tutorial, commands that you enter will start with the "$" prompt. The output will follow. Lines that start with "#" are comments that I've added to explain a point. When I show updates to a file, the ":wq" on the last line means to save the file.

Here's an example:

```
## this is a comment
$ echo this is a command
this is a command

## edit the file
$vi foo.md
+++
date = "2014-09-28"
title = "creating a new theme"
+++

bah and humbug
:wq

## show it
$ cat foo.md
+++
date = "2014-09-28"
title = "creating a new theme"
+++

bah and humbug
$
```


## Some Definitions

There are a few concepts that you need to understand before creating a theme.

### Skins

Skins are the files responsible for the look and feel of your site. It’s the CSS that controls colors and fonts, it’s the Javascript that determines actions and reactions. It’s also the rules that Hugo uses to transform your content into the HTML that the site will serve to visitors.

You have two ways to create a skin. The simplest way is to create it in the ```layouts/``` directory. If you do, then you don’t have to worry about configuring Hugo to recognize it. The first place that Hugo will look for rules and files is in the ```layouts/``` directory so it will always find the skin.

Your second choice is to create it in a sub-directory of the ```themes/``` directory. If you do, then you must always tell Hugo where to search for the skin. It’s extra work, though, so why bother with it?

The difference between creating a skin in ```layouts/``` and creating it in ```themes/``` is very subtle. A skin in ```layouts/``` can’t be customized without updating the templates and static files that it is built from. A skin created in ```themes/```, on the other hand, can be and that makes it easier for other people to use it.

The rest of this tutorial will call a skin created in the ```themes/``` directory a theme.

Note that you can use this tutorial to create a skin in the ```layouts/``` directory if you wish to. The main difference will be that you won’t need to update the site’s configuration file to use a theme.

### The Home Page

The home page, or landing page, is the first page that many visitors to a site see. It is the index.html file in the root directory of the web site. Since Hugo writes files to the public/ directory, our home page is public/index.html.

### Site Configuration File

When Hugo runs, it looks for a configuration file that contains settings that override default values for the entire site. The file can use TOML, YAML, or JSON. I prefer to use TOML for my configuration files. If you prefer to use JSON or YAML, you’ll need to translate my examples. You’ll also need to change the name of the file since Hugo uses the extension to determine how to process it.

Hugo translates Markdown files into HTML. By default, Hugo expects to find Markdown files in your ```content/``` directory and template files in your ```themes/``` directory. It will create HTML files in your ```public/``` directory. You can change this by specifying alternate locations in the configuration file.

### Content

Content is stored in text files that contain two sections. The first section is the “front matter,” which is the meta-information on the content. The second section contains Markdown that will be converted to HTML.

#### Front Matter

The front matter is information about the content. Like the configuration file, it can be written in TOML, YAML, or JSON. Unlike the configuration file, Hugo doesn’t use the file’s extension to know the format. It looks for markers to signal the type. TOML is surrounded by “`+++`”, YAML by “`---`”, and JSON is enclosed in curly braces. I prefer to use TOML, so you’ll need to translate my examples if you prefer YAML or JSON.

The information in the front matter is passed into the template before the content is rendered into HTML.

#### Markdown

Content is written in Markdown which makes it easier to create the content. Hugo runs the content through a Markdown engine to create the HTML which will be written to the output file.

### Template Files

Hugo uses template files to render content into HTML. Template files are a bridge between the content and presentation. Rules in the template define what content is published, where it's published to, and how it will rendered to the HTML file. The template guides the presentation by specifying the style to use.

There are three types of templates: single, list, and partial. Each type takes a bit of content as input and transforms it based on the commands in the template.

Hugo uses its knowledge of the content to find the template file used to render the content. If it can’t find a template that is an exact match for the content, it will shift up a level and search from there. It will continue to do so until it finds a matching template or runs out of templates to try. If it can’t find a template, it will use the default template for the site.

Please note that you can use the front matter to influence Hugo’s choice of templates.

#### Single Template

A single template is used to render a single piece of content. For example, an article or post would be a single piece of content and use a single template.

#### List Template

A list template renders a group of related content. That could be a summary of recent postings or all articles in a category. List templates can contain multiple groups.

The homepage template is a special type of list template. Hugo assumes that the home page of your site will act as the portal for the rest of the content in the site.

#### Partial Template

A partial template is a template that can be included in other templates. Partial templates must be called using the “partial” template command. They are very handy for rolling up common behavior. For example, your site may have a banner that all pages use. Instead of copying the text of the banner into every single and list template, you could create a partial with the banner in it. That way if you decide to change the banner, you only have to change the partial template.
