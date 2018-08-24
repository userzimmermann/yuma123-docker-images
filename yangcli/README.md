# The yuma123/yangcli docker image

**Image source:** https://github.com/userzimmermann/yuma123-docker-images/blob/master/yangcli/Dockerfile

## About yangcli

`yangcli` is an interactive [NETCONF][netconf] command line client and part of the [Yuma123][yuma123] OpenSource project

[netconf]: https://en.wikipedia.org/wiki/NETCONF

[yuma123]: http://yuma123.org

## Running

This docker image defines `yangcli` as default command. So all you need to do for pulling the image, creating a container, and starting an interactive `yangcli` session is:

```console
docker run -ti yuma123/yangcli
```

Further usage instructions for `yangcli` itself will be printed before the first `yangcli>` prompt

## Configuration

The `yangcli>` prompt is based on [GNU Readline][readline]. You can easily add your custom [readline init] configuration to the container by putting it into a `READLINE_INIT` environment variable. The content of that variable will be written to `~/.inputrc` before starting `yangcli`. E.g. for enabling [vi mode]:

[readline]: https://tiswww.case.edu/php/chet/readline/rltop.html

[readline init]: https://tiswww.case.edu/php/chet/readline/readline.html#SEC10

[vi mode]: https://tiswww.case.edu/php/chet/readline/readline.html#SEC22

```console
docker run -ti -e READLINE_INIT="set editing-mode vi" yuma123/yangcli
```

For defining a more complex readline init configuration, you can also run this docker image as a [docker-compose] service. In a `docker-compose.yml` file, a `yangcli` service could look like:

[docker-compose]: https://docs.docker.com/compose/

```yaml
services:
  yangcli:
    image: yuma123/yangcli
    environment:
      READLINE_INIT: |
        set editing-mode vi
        set show-mode-in-prompt on
```

Then you can simply start an interactive `yangcli` session with:

```console
docker-compose run yangcli
```
