# aa

[![ci](https://github.com/jonaprieto/aa/actions/workflows/ci.yml/badge.svg)](https://github.com/jonaprieto/aa/actions/workflows/ci.yml)
[![python](https://img.shields.io/badge/python-3.9%2B-3776ab)](https://www.python.org)
[![dependencies](https://img.shields.io/badge/dependencies-none-brightgreen)](aa)
[![license](https://img.shields.io/github/license/jonaprieto/aa)](LICENSE)
[![Homebrew](https://img.shields.io/badge/brew-jonaprieto%2Faa-fbb040?logo=homebrew)](#install)

Search for a book or paper from the terminal, pick one, and get a verified, well-named file.

```
$ aa introduction to algorithms

   2  Introduction to Algorithms 4
      Thomas H. Cormen, Charles E. Leiserson et al.
       PDF   12 MB  2022

   3  Introduction to Algorithms 3rd edition
      Leiserson, Charles E., Rivest, Ronald L. et al.
       PDF   5 MB  2009

  10 of 100+ shown   2 download  1,3-5 several  i2 info  t2 torrent  m more  any text new search  q quit
aa> 2
  [2] Introduction to Algorithms 4  pdf, 12 MB
  trying libgen ...
  saved ~/Downloads/2022-cormen-introduction-to-algorithms-4.pdf
```

`aa` is a single Python file with no dependencies beyond the standard library.

## Install

With Homebrew:

```sh
brew tap jonaprieto/aa https://github.com/jonaprieto/aa
brew trust --formula jonaprieto/aa/aa   # third-party taps need it
brew install aa
```

Or grab the single file, which only needs Python 3.9 or newer:

```sh
curl -fsSL https://raw.githubusercontent.com/jonaprieto/aa/main/aa -o ~/.local/bin/aa
chmod +x ~/.local/bin/aa
aa selftest
```

Or clone the repo and symlink `aa` into a directory on your `PATH`.

## Usage

```
aa [query...]            interactive: search, pick by number, download
aa search <query...>     print md5, format, size, year and title per result
aa info <md5>            Anna's Archive record summary
aa get <md5> [-o DIR]    download one file
aa torrent <md5>         magnet link and the file's path inside the torrent
aa selftest              offline checks
```

At the `aa>` prompt:

| input | does |
|---|---|
| `2`, `1,3-5` | download those results |
| `i2` | details for result 2 |
| `t2` | torrent for result 2 |
| `m` or Enter | show more results, fetching the next page when needed |
| any other text | new search (`/1984` forces a search for something numeric) |
| `q` | quit |

## Where files come from

Search uses libgen.li, because Anna's Archive search sits behind a browser challenge. For each download `aa` tries, in order:

1. the Anna's Archive member API, when `AA_KEY` is set;
2. LibGen's direct download link;
3. public IPFS gateways, when Anna's Archive exposes the file's IPFS CID.

A file is kept only if its md5 matches the one you picked. Gateways often answer with an HTML page and a success status, so the md5 is what decides.

## Filenames

Downloads are named `[year]-[author]-[title]` in lowercase with ASCII-only words and the title cut at 40 characters on a word boundary, the Reference preset from [papershelf](https://github.com/jonaprieto/papershelf), for example `2022-cormen-introduction-to-algorithms-4.pdf`. An existing file is never overwritten; the new one gets an md5 suffix instead.

## Configuration

| variable | default | meaning |
|---|---|---|
| `AA_DIR` | `~/Downloads` | download folder |
| `AA_NAME` | `[year]-[author]-[title]` | filename pattern; `original` keeps the server's name |
| `AA_OPEN` | `1` | set to `0` to not open files after an interactive download |
| `AA_KEY` | | Anna's Archive member secret key, for fast downloads |
| `AA_DOMAIN` | `annas-archive.gl` | Anna's Archive domain, which moves from time to time |
| `LG_DOMAIN` | `libgen.li` | LibGen mirror (`libgen.bz`, `libgen.gl` and `libgen.vg` serve the same data) |

## Limits

- Search only covers what LibGen indexes. Files that only Anna's Archive holds need their md5, for `aa get`.
- Anna's Archive record JSON is members-only for most files, so without `AA_KEY` the `info` and `torrent` commands show less.
- The md5 check catches broken and substituted downloads. It cannot catch a hostile mirror, because the md5 comes from the same server as the file.
- Sites change their HTML. If search suddenly returns nothing, run `aa selftest` and open an issue.

## Legal

Many files on these sites are under copyright. Downloading them may be illegal where you live. Use `aa` for material you have the right to access.

## License

[MIT](LICENSE)
