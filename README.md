# heroku-buildpack-vips

Heroku buildpack with [libvips](https://github.com/libvips/libvips) installed. A VIPS buildpack for the modern Heroku stacks. It supports the following stacks:

- heroku-16
- heroku-18
- heroku-20

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
vips-8.12.2-Tue Jan 25 09:34:32 UTC 2022
```

## Build

[This](./build.sh) is the script used to build libvips using docker.

```
VIPS_VERSION=x.y.z ./build.sh
```

After building a tar file, it will be copied to the `build` directory. Then you should commit the changes to git.

## License

The buildpack is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
