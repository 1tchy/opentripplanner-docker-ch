FROM openjdk:8-jre-alpine

ENV OTP_BASE /var/otp
ENV OTP_GRAPHS $OTP_BASE/graphs

RUN set -x && \
    apk add --no-cache ca-certificates openssl zip ttf-dejavu && \
    mkdir -p $OTP_BASE/scripting $OTP_GRAPHS/switzerland && \
    wget -O $OTP_BASE/otp.jar https://repo1.maven.org/maven2/org/opentripplanner/otp/1.4.0/otp-1.4.0-shaded.jar && \
    wget -O $OTP_BASE/jython.jar http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.1/jython-standalone-2.7.1.jar && \
    wget -O $OTP_GRAPHS/switzerland/timetable-2020-gtfs.zip https://opentransportdata.swiss/de/dataset/timetable-2020-gtfs/permalink && \
    unzip $OTP_GRAPHS/switzerland/timetable-2020-gtfs.zip routes.txt -d $OTP_GRAPHS/switzerland && \
    sed -i -- 's/"Sesselbahn","1700"/"Sesselbahn","1304"/g' $OTP_GRAPHS/switzerland/routes.txt && \
    sed -i -- 's/"Taxi","1501"/"Taxi","715"/g' $OTP_GRAPHS/switzerland/routes.txt && \
    zip -ju $OTP_GRAPHS/switzerland/timetable-2020-gtfs.zip $OTP_GRAPHS/switzerland/routes.txt && \
    rm $OTP_GRAPHS/switzerland/routes.txt && \
    wget -O $OTP_GRAPHS/switzerland/switzerland-latest.osm.pbf https://download.geofabrik.de/europe/switzerland-latest.osm.pbf && \
    java -Xmx8G -jar /var/otp/otp.jar --build /var/otp/graphs/switzerland && \
    rm $OTP_GRAPHS/switzerland/timetable-2020-gtfs.zip && \
    rm $OTP_GRAPHS/switzerland/switzerland-latest.osm.pbf

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT [ "java", "-Xmx6G", "-Xverify:none", "-cp", "/var/otp/otp.jar:/var/otp/jython.jar", "org.opentripplanner.standalone.OTPMain" ]

CMD [ "--help" ]
