# PyQt BaseApp

This base application is designed to be used for packaging Flatpak applications that use PyQt,  
Riverbank Computing's Python bindings for [The Qt Company's](https://www.qt.io/) Qt application framework.

**Note: This packaging is not affilated with, or supported by Riverbank Computing Limited.**

*To help improve this documentation, open a pull request against the [wiki branch](https://github.com/flathub/com.riverbankcomputing.PyQt.BaseApp/tree/wiki).*

## What's included?

* [QtWebEngine base application](https://github.com/flathub/io.qt.qtwebengine.BaseApp) (not in all branches, see table below)
* [PyQt](https://riverbankcomputing.com/software/pyqt/) Python bindings for Qt
* [PyQtWebEngine](https://riverbankcomputing.com/software/pyqtwebengine) Python bindings for QtWebEngine
* Run-time dependencies for the above, including:
  * krb5
  * libevent

### Build tools and their dependencies

Build tools are included to help package extra PytQt bindings and Python modules. These tools are removed by the  
`BaseApp-cleanup.sh` script.

#### Python module build tools

* python-build
* python-flit-core
* python-installer
* python-pep517 (has been replaced by pyproject_hooks in newer versions)
* pyproject_hooks
* python-setuptools-scm

#### PyQt build tools

* pyqt-builder
* pyqt-sip
* sip

#### Retained Python modules

While the following Python modules are dependencies of the mentioned build tools, they are not removed by the  
`BaseApp-cleanup.sh` script, as they might be needed by the Flatpak application.

* python-packaging
* python-ply
* python-pyparsing
* python-toml
* python-tomli
* python-typing-extensions

## Branch Comparison

| Branch     | Maintained | QtWebEngine |
|------------|------------|-------------|
| 5.15-21.08 | Yes        | Yes         |
| 5.15-22.08 | Yes        | Yes         |
| 6.2        | No         | Yes         |
| 6.3        | Yes        | Yes         |
| 6.4        | Yes        | No          |

## How to use?

### Example: PyQtWebEngine application

```yaml
app-id: org.kde.PyQtWebEngineApp
runtime: org.kde.Platform
runtime-version: '6.3'
sdk: org.kde.Sdk
base: com.riverbankcomputing.PyQt.BaseApp
base-version: '6.3'
cleanup-commands:
  - /app/cleanup-BaseApp.sh
modules:
  - name: PyQtWebEngineApp
...
```

### Example: PyQt application

While it's not required, it's possible to set the environment variable `BASEAPP_REMOVE_WEBENGINE` to have the  
`BaseApp-cleanup.sh` script remove the PyQtWebEngine bindings and QtWebEngine with its dependencies.

```yaml
app-id: org.kde.PyQtApp
runtime: org.kde.Platform
runtime-version: '6.3'
sdk: org.kde.Sdk
base: com.riverbankcomputing.PyQt.BaseApp
base-version: '6.3'
cleanup-commands:
  - /app/cleanup-BaseApp.sh
build-options:
  env:
    - BASEAPP_REMOVE_WEBENGINE=1
modules:
  - name: PyQtApp
...
```

### Note on QtWebEngine

QtWebEngine in only available for those versions for those the [QtWebEngine BaseApp](https://github.com/flathub/io.qt.qtwebengine.BaseApp) is available. If the QtWebEngine BaseApp is aviable after a new versions of this BaseApp has been released, it will be added. SO make sure, you set BASEAPP_REMOVE_WEBENGINE to 1 if you don't need them to be future proof.
