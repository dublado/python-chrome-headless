FROM python:3.7.0-stretch
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install xorg xvfb gtk2-engines-pixbuf dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable -y
RUN apt install imagemagick x11-apps unzip -y
RUN apt-get install chromium -y
#RUN wget http://security.debian.org/debian-security/pool/updates/main/c/chromium-browser/chromedriver_69.0.3497.92-1~deb9u1_amd64.deb
#RUN dpkg -i chromedriver_69.0.3497.92-1~deb9u1_amd64.deb &> /dev/null
#RUN apt --fix-broken install -y
#RUN dpkg -i chromedriver_69.0.3497.92-1~deb9u1_amd64.deb
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver
RUN pip install pyvirtualdisplay
RUN pip install selenium
RUN Xvfb -ac :99 -screen01280x1024x16 &
RUN export DISPLAY=:99
VOLUME /scripts
WORKDIR /scripts
