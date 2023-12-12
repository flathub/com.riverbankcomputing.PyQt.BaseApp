#!/bin/bash

# pyqt
rm -rfv ${FLATPAK_DEST}/bin/py{lupdate,rcc,uic}5
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5/bindings
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5/{pylupdate,pyrcc}*
rm -rfv ${FLATPAK_DEST}/share/qt

# pyqt-builder
rm -rfv ${FLATPAK_DEST}/bin/pyqt-{bundle,qt-wheel}
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt_builder-*
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/pyqtbuild

# pyqt-sip
# TODO: figure out if this can be removed, required by pyqt
#rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5/sip.cpython-*-${FLATPAK_ARCH}-linux-gnu.so
#rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5_sip-*.dist-info
#rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5_sip-*-py*.egg-info

# python-build
rm -rfv ${FLATPAK_DEST}/bin/pyproject-build
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/build
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/build-*.dist-info
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/build-*-py*.egg-info

# python-flit-core
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/flit_core
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/flit_core-*.dist-info
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/flit_core-*-py*.egg-info

# python-flit-core
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/installer
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/installer-*.dist-info
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/installer-*-py*.egg-info

# python-pep517
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/pep517
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/pep517-*.dist-info
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/pep517-*-py*.egg-info

# python-setuptools-scm
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/setuptools_scm
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/setuptools_scm-*.dist-info
rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/setuptools_scm-*-py*.egg-info

# sip
if [ -z "$BASEAPP_KEEP_SIP"]; then
  rm -rfv ${FLATPAK_DEST}/bin/sip-{build,distinfo,install,module,sdist,wheel}
  rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/sip-*.dist-info
  rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/sip-*-py*.egg-info
  rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/sipbuild
fi

# qtwebengine baseapp
[ -r ${FLATPAK_DEST}/cleanup-BaseApp-QtWebEngine.sh ] &&
  ${FLATPAK_DEST}/cleanup-BaseApp-QtWebEngine.sh

# remove pyqtwebengine
if [ -n "$BASEAPP_REMOVE_WEBENGINE" ] || [ -n "$BASEAPP_REMOVE_PYWEBENGINE" ]; then
  # krb5
  rm -rfv ${FLATPAK_DEST}/etc/krb5.conf
  rm -rfv ${FLATPAK_DEST}/lib/krb5
  rm -rfv ${FLATPAK_DEST}/lib/lib{com_err,gss{api_krb5,rpc},k5crypto,kadm5{clnt{,_mit},srv{,_mit}},kdb5,krad,krb5{,support},verto}.so*
  rm -rfv ${FLATPAK_DEST}/share/locale/*/LC_MESSAGES/mit-krb5.mo

  # libevent
  rm -rfv ${FLATPAK_DEST}/lib/libevent{,_core,_extra,_openssl,_pthreads}*.so*

  # minizip, pciutils, re2, snappy
  rm -rfv ${FLATPAK_DEST}/lib/lib{minizip,pci,re2,snappy}.so*

  # pyqtwebengine
  rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQt5/QtWebEngine{,Core,Widgets}.abi3.so
  rm -rfv ${FLATPAK_DEST}/lib/python*/site-packages/PyQtWebEngine-*.dist-info

  # qtwebview
  rm -rfv ${FLATPAK_DEST}/lib/qml/QtWebView
  rm -rfv ${FLATPAK_DEST}/lib/plugins/webview
  rm -rfv ${FLATPAK_DEST}/lib/${FLATPAK_ARCH}-linux-gnu/libQt*WebView.so*

  # qtwebengine
  rm -rfv ${FLATPAK_DEST}/bin/QtWebEngineProcess
  rm -rfv ${FLATPAK_DEST}/lib/plugins/imageformats
  rm -rfv ${FLATPAK_DEST}/lib/qml/{QtQuick/Pdf,QtWebEngine}
  rm -rfv ${FLATPAK_DEST}/lib/${FLATPAK_ARCH}-linux-gnu/libQt*{Pdf{,Widgets},WebEngine{,Core,Widgets}}.so*
  rm -fv ${FLATPAK_DEST}/lib/libQt*{Pdf{,Widgets},WebEngine{,Core,Widgets}}.so*
  rm -rfv ${FLATPAK_DEST}/qtwebengine_dictionaries
  rm -rfv ${FLATPAK_DEST}/resources/qtwebengine*.pak
  rm -rfv ${FLATPAK_DEST}/share/locale/*/qtwebengine_dictionaries
  rm -rfv ${FLATPAK_DEST}/translations/qtwebengine_locales

fi

# empty folders
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/etc
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/lib/plugins
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/lib/qml/QtQuick
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/lib/qml
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/lib/${FLATPAK_ARCH}-linux-gnu
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/resources
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/locale/*/LC_MESSAGES

# test if separate-locales is enabled
if [ -d ${FLATPAK_DEST}/share/runtime/locale ]; then
  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/runtime/locale/*/share/*
  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/runtime/locale/*/share
  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/runtime/locale/*

  for e in ${FLATPAK_DEST}/share/locale/*; do
    # remove broken locale symlinks
    if [ -L "$e" ]; then
      [ -e "$e" ] || rm -fv "$e"
    else
      # english locales are kept in the app
      rmdir -v --ignore-fail-on-non-empty "$e"
    fi
  done

  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/runtime/locale
  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/runtime

else
  rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/locale/*
fi

rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/share/locale
rmdir -v --ignore-fail-on-non-empty ${FLATPAK_DEST}/translations

rm -rfv $(readlink -f "$0")
