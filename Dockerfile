FROM openjdk:8-jre-alpine

ENV OTP_BASE /var/otp
ENV OTP_GRAPHS $OTP_BASE/graphs

RUN set -x && \
    apk add --no-cache ca-certificates openssl ttf-dejavu && \
    mkdir -p $OTP_BASE/scripting $OTP_GRAPHS/switzerland && \
    wget -O $OTP_BASE/otp.jar https://repo1.maven.org/maven2/org/opentripplanner/otp/1.2.0/otp-1.2.0-shaded.jar && \
    wget -O $OTP_BASE/jython.jar http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar && \
    wget -O $OTP_GRAPHS/switzerland/timetable-2018-gtfs.zip https://opentransportdata.swiss/dataset/timetable-2018-gtfs/permalink && \
    wget -P $OTP_GRAPHS/switzerland https://download.geofabrik.de/europe/switzerland-latest.osm.pbf && \
    java -Xmx8G -jar /var/otp/otp.jar --build /var/otp/graphs/switzerland

EXPOSE 8080
EXPOSE 8081

ENTRYPOINT [ "java", "-Xmx6G", "-Xverify:none", "-cp", "/var/otp/otp.jar:/var/otp/jython.jar", "org.opentripplanner.standalone.OTPMain" ]

CMD [ "--help" ]
