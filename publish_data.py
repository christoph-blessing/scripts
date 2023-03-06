from types import ModuleType

import datajoint as dj

# CIN database server credentials
dj.config["database.host"] = "134.2.118.234:55222"
dj.config["database.user"] = "lhoefling"
dj.config["database.password"] = "mypassword"

# Establish connection to database server containing to be published data using appropriate credentials
source_connection = dj.Connection("somehostname", "myusername", "mypassword")
# Create virtual module of schema containing to be published data using previously created connection
source_tables = dj.create_virtual_module("source", "myschema", connection=source_connection)

# Specify names of tables that contain to be published data
to_be_created = ["SomeTable", "AnotherTable"]
# Specify name of schema that will contain the published data
target_schema = dj.schema("rgc_colour")
target_tables = ModuleType("target")
for name in source_tables.__dict__:
    if name not in to_be_created:
        continue
    source_table = getattr(source_tables, name)
    target_table = type(name, (dj.Manual,), {"definition": source_table.definition})
    target_schema(target_table)
    target_tables.__dict__[name] = target_table

# Copy entries from source to target tables, e.g. to copy all data do:
target_tables.SomeTable.insert(source_tables.SomeTable.fetch())
