import sqlite3


def updateStatus(node, url, status):
    conn = sqlite3.connect(SQL_DB_NAME)
    crsr = conn.cursor()
    checkTableExists(crsr, SQL_TABLE_NAME)
    updateNodeStatus(crsr, SQL_TABLE_NAME, node, url, status)
    conn.commit()
    conn.close()


def updateNodeStatus(crsr, table, node, url, status):
    crsr.execute(
        "SELECT pollTime, node, url, status FROM %s WHERE node='%s' ORDER BY pollTime DESC LIMIT 1" % (table, node))
    row = crsr.fetchone()
    if row == None or status == "DOWN" or row[3] != status:
        crsr.execute("INSERT INTO %s (pollTime, node, url, status) VALUES ('%s','%s','%s','%s')" % (
            SQL_TABLE_NAME, current_time(), node, url, status))
        alert(node, url, status)


def checkTableExists(crsr, table):
    crsr.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='%s'" % (table))
    if crsr.fetchone() == None:
        print "creating %s table" % (SQL_TABLE_NAME)
        crsr.execute("CREATE TABLE nodes (pollTime date, node text, url text, status text)")
