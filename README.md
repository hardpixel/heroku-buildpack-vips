# heroku-buildpack-vips

Heroku buildpack with [libvips](https://github.com/libvips/libvips) installed. A VIPS buildpack for the modern Heroku stacks. It supports the following stacks:

- heroku-18
- heroku-20
- heroku-22

In order to use this buildpack, you must install these packages in your heroku application:

- libglib2.0-0
- libglib2.0-dev
- libpoppler-glib8

The easiest way to do this is using the heroku [apt](https://github.com/heroku/heroku-buildpack-apt) buildpack.

## Usage

Run the commands below to add this buildpack and apt buildpack to your app:

```
$ heroku buildpacks:add --index 1 https://github.com/heroku/heroku-buildpack-apt
$ heroku buildpacks:add --index 2 https://github.com/brandoncc/heroku-buildpack-vips
```

Create a new file named `Aptfile` in your project root with the following contents:

```
libglib2.0-0
libglib2.0-dev
libpoppler-glib8
```

Git add the files and deploy to Heroku. You can verify the result by running this command:

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
