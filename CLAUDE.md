# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Hugo-powered static blog called "the dementor's pensieve" hosted at https://blog.soumyadeep.in/. The site uses the "Pickles" theme and contains personal blog posts covering topics like technology, networking, productivity, and personal experiences.

## Architecture

- **Static Site Generator**: Hugo (v0.119.0 or newer)
- **Theme**: Pickles theme (located in `themes/pickles/`)
- **Content**: Markdown files in `content/posts/`
- **Configuration**: `config.toml` at root
- **Static Assets**: Located in `static/` directory
- **Generated Site**: Built to `public/` directory

### Directory Structure

```
├── config.toml          # Hugo configuration
├── content/posts/       # Blog post content (Markdown)
├── layouts/shortcodes/  # Custom Hugo shortcodes
├── static/             # Static assets (images, CSS, etc.)
├── themes/pickles/     # Hugo theme
└── public/             # Generated static site (build output)
```

## Common Development Commands

### Building and Serving
- `hugo server` - Start development server with live reload
- `hugo server -D` - Include draft posts in development server
- `hugo` - Build static site to `public/` directory
- `hugo --minify` - Build with minification for production

### Content Management
- `hugo new posts/post-name.md` - Create new blog post
- Blog posts use front matter with title, date, and tags
- Custom shortcode `zoom-img` available for image zoom functionality

## Configuration Notes

- Site configured for deployment to https://blog.soumyadeep.in/
- Analytics and social links configured in `config.toml`
- Custom CSS styling in `static/css/custom.css`
- Related posts feature enabled with tag-based matching

## Theme Customization

The Pickles theme has been customized with:
- Custom CSS overrides
- Zoom image shortcode functionality
- Social media integration (Twitter, GitHub, LinkedIn)
- Custom logo and favicon configuration