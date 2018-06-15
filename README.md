# docker-dat-server

A lightweight image which runs [hypercored](https://github.com/amarburg/hypercored), a "central server" for the [dat Project](https://datproject.org).   In contrast to the user-facing `dat` program hypercored is designed to serve multiple feeds, but the data is not in a user-usable version (sort of like a Git "bare" repository?).

It has one _required_ environment variable:

 - `FEEDS_DAT` is a `dat://` URL to a dataset which contains a feeds file for hypercored.

If set `FEEDS_FILE` is set, it is the name of the file __within__ `FEEDS_DAT` used to configure
hypercored.   If not set, defaults to `feeds`.

Stores all data on the volume `/data`.  Mount this as a volume if you want
data to persist between runs.
