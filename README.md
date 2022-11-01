# heroku-buildpack-vips

Heroku buildpack with [libvips](https://github.com/libvips/libvips) installed. A buildpack for the modern Heroku stacks.

[![Vips](https://img.shields.io/github/v/tag/hardpixel/heroku-buildpack-vips?label=vips&logo=hack-the-box)](https://github.com/hardpixel/heroku-buildpack-vips/releases)
[![Heroku 18](https://img.shields.io/badge/stack-18-904edf?logo=heroku)](https://github.com/hardpixel/heroku-buildpack-vips/releases)
[![Heroku 20](https://img.shields.io/badge/stack-20-904edf?logo=heroku)](https://github.com/hardpixel/heroku-buildpack-vips/releases)
[![Heroku 22](https://img.shields.io/badge/stack-22-904edf?logo=heroku)](https://github.com/hardpixel/heroku-buildpack-vips/releases)
[![Build](https://github.com/hardpixel/heroku-buildpack-vips/actions/workflows/build.yml/badge.svg)](https://github.com/hardpixel/heroku-buildpack-vips/actions/workflows/build.yml)

## Usage

Run the commands below to add this buildpack to your app:

```
$ heroku buildpacks:add --index 1 https://github.com/hardpixel/heroku-buildpack-vips
```

Deploy to Heroku and verify the result by running this command:

```
$ heroku run vips -v
vips-8.13.2-Thu Sep 29 04:55:26 UTC 2022
```

## Configuration

You can select the preferred version by setting the `VIPS_VERSION` environment variable. It defaults to the latest stable [release](https://github.com/libvips/libvips/releases). Check the available versions in the [releases](https://github.com/hardpixel/heroku-buildpack-vips/releases) page.

```
$ heroku config:set VIPS_VERSION=8.13.0
```

## License

The buildpack is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
