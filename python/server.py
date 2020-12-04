"""
XSA Python buildpack app example
Author: Andrew Lunde
"""
from flask import Flask
from flask import request
from flask import Response

from flask import send_from_directory

import os
import json
from cfenv import AppEnv

# from sap.cf_logging import flask_logging
#
# https://help.sap.com/viewer/0eec0d68141541d1b07893a39944924e/2.0.03/en-US/d12c86af7cb442d1b9f8520e2aba7758.html
from hdbcli import dbapi


app = Flask(__name__)
env = AppEnv()

# Get port from environment variable or choose 9099 as local default
# If you are testing locally (i.e. not with xs or cf deployments,
# Be sure to pull all the python modules locally
# with pip using XS_PYTHON unzipped to /tmp
# mkdir -p local
# pip install -t local -r requirements.txt -f /tmp
port = int(os.getenv("PORT", 9099))
hana = env.get_service(label='hana')

# This module's Flask webserver will respond to these three routes (URL paths)
# If there is no path then just return Hello World and
# this module's instance number
# Requests passed through the app-router will never hit this route.


@app.route('/')
def hello_world():
    output = '<strong>Python SecureStore! Instance ' + \
             str(os.getenv("CF_INSTANCE_INDEX", 0)) + \
             '</strong> Try these links.</br>\n'
    output += '<a href="/python/links">/python/links</a><br />\n'
    return output


# Satisfy browser requests for favicon.ico so that don't return 404
@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico',
                               mimetype='image/vnd.microsoft.icon')


# Coming through the app-router
@app.route('/python/links')
def python_links():
    output = '<strong>Python SecureStore! Instance ' + \
             str(os.getenv("CF_INSTANCE_INDEX", 0)) + \
             '</strong> Try these links.</br>\n'
    output += '<a href="/python/insert">/python/insert</a><br />\n'
    output += '<a href="/python/retrieve">/python/retrieve</a><br />\n'
    output += '<a href="/python/delete">/python/delete</a><br />\n'
    return output


@app.route('/python/insert')
def unauth_ss_insert():
    output = 'Python UnAuthorized SecureStore Insert. \n'

    schema = hana.credentials['schema']
    host = hana.credentials['host']
    port = hana.credentials['port']
    user = hana.credentials['user']
    password = hana.credentials['password']

    # The certificate will available for HANA service instances that
    # require an encrypted connection
    # Note: This was tested to work with python hdbcli-2.3.112 tar.gz package
    # not hdbcli-2.3.14 provided in XS_PYTHON00_0-70003433.ZIP
    if 'certificate' in hana.credentials:
        haascert = hana.credentials['certificate']

    output += 'schema: ' + schema + '\n'
    output += 'host: ' + host + '\n'
    output += 'port: ' + port + '\n'
    output += 'user: ' + user + '\n'
    output += 'pass: ' + password + '\n'

    # Connect to the python HANA DB driver using the connection info
    # User for HANA as a Service instances
    if 'certificate' in hana.credentials:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema,
            encrypt="true",
            sslValidateCertificate="true",
            sslCryptoProvider="openssl",
            sslTrustStore=haascert
        )
    else:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema
        )

    # Prep a cursor for SQL execution
    cursor = connection.cursor()

    # Form an SQL statement to retrieve some data

    string2store = 'Whatever!'

    import codecs
    hex2store = (codecs.encode(str.encode(string2store), "hex")).decode()

    try:
        cursor.callproc("SYS.USER_SECURESTORE_INSERT",
                        ("TestStoreName", False, "TestKey", hex2store))
        output += 'key TestKey with value ' + string2store + '=' + \
                  hex2store + ' was inserted into store TestStoreName.\n'
    except:
        output += 'key TestKey likely already exists. Try deleting first.\n'

    # Close the DB connection
    connection.close()

    # Return the results
    return Response(output, mimetype='text/plain', status=200,)


@app.route('/python/retrieve')
def unauth_ss_retrieve():
    output = 'Python UnAuthorized SecureStore Retrieve.\n'

    schema = hana.credentials['schema']
    host = hana.credentials['host']
    port = hana.credentials['port']
    user = hana.credentials['user']
    password = hana.credentials['password']

    # The certificate will available for HANA service instances
    # that require an encrypted connection
    # Note: This was tested to work with python hdbcli-2.3.112 tar.gz package
    # not hdbcli-2.3.14 provided in XS_PYTHON00_0-70003433.ZIP
    if 'certificate' in hana.credentials:
        haascert = hana.credentials['certificate']

    output += 'schema: ' + schema + '\n'
    output += 'host: ' + host + '\n'
    output += 'port: ' + port + '\n'
    output += 'user: ' + user + '\n'
    output += 'pass: ' + password + '\n'

    # Connect to the python HANA DB driver using the connection info
    # User for HANA as a Service instances
    if 'certificate' in hana.credentials:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema,
            encrypt="true",
            sslValidateCertificate="true",
            sslCryptoProvider="openssl",
            sslTrustStore=haascert
        )
    else:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema
        )

    # Prep a cursor for SQL execution
    cursor = connection.cursor()

    # Form an SQL statement to retrieve some data

    # https://blogs.sap.com/2017/07/26/sap-hana-2.0-sps02-new-feature-updated-python-driver/

    # cursor.execute('call SYS.USER_SECURESTORE_RETRIEVE (\'TestStoreName\',
    # False, \'TestKey\', ?)')
    hexvalue = cursor.callproc("SYS.USER_SECURESTORE_RETRIEVE",
                               ("TestStoreName", False, "TestKey", None))

    # Close the DB connection
    connection.close()

    import codecs

    if hexvalue[3] is None:
        output += 'key TestKey does not exist in store TestStoreName. ' + \
                  'Try inserting a value first.\n'
    else:
        retrieved = codecs.decode(hexvalue[3].hex(), "hex").decode()
        output += 'key TestKey with value ' + retrieved + \
                  ' was retrieved from store TestStoreName.\n'

    # Return the results
    return Response(output, mimetype='text/plain', status=200,)


@app.route('/python/delete')
def unauth_ss_delete():
    output = 'Python UnAuthorized SecureStore Delete. \n'

    schema = hana.credentials['schema']
    host = hana.credentials['host']
    port = hana.credentials['port']
    user = hana.credentials['user']
    password = hana.credentials['password']

    # The certificate will available for HANA service instances
    # that require an encrypted connection
    # Note: This was tested to work with python hdbcli-2.3.112 tar.gz package
    # not hdbcli-2.3.14 provided in XS_PYTHON00_0-70003433.ZIP
    if 'certificate' in hana.credentials:
        haascert = hana.credentials['certificate']

    output += 'schema: ' + schema + '\n'
    output += 'host: ' + host + '\n'
    output += 'port: ' + port + '\n'
    output += 'user: ' + user + '\n'
    output += 'pass: ' + password + '\n'

    # Connect to the python HANA DB driver using the connection info
    # User for HANA as a Service instances
    if 'certificate' in hana.credentials:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema,
            encrypt="true",
            sslValidateCertificate="true",
            sslCryptoProvider="openssl",
            sslTrustStore=haascert
        )
    else:
        connection = dbapi.connect(
            address=host,
            port=int(port),
            user=user,
            password=password,
            currentSchema=schema
        )

    # Prep a cursor for SQL execution
    cursor = connection.cursor()

    # Form an SQL statement
    cursor.callproc("SYS.USER_SECURESTORE_DELETE",
                    ("TestStoreName", False, "TestKey"))

    # Close the DB connection
    connection.close()

    output += 'key TestKey was deleted from store TestStoreName.\n'

    # Return the results
    return Response(output, mimetype='text/plain', status=200,)


if __name__ == '__main__':
    # Run the app, listening on all IPs with our chosen port number
    # Use this for production
    # app.run(host='0.0.0.0', port=port)
    # Use this for debugging
    app.run(debug=True, host='0.0.0.0', port=port)
