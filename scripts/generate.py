import os
import sqlite3

from shared import DB_PATH, DOCS_PATH, get_package, get_resources

package = get_package()
resources = get_resources()


def generate_docs():
    # Make package markdown file as README.md for documentation folder
    package_md_path = DOCS_PATH / "README.md"

    package_md = package.to_markdown(package_md_path.absolute().as_posix()).replace(
        "- `description`", "\n- `description`"
    )

    with open(package_md_path, "w") as package_doc:
        package_doc.write(package_md)

    for resource in resources:
        resource_md_path = DOCS_PATH / (resource.name + ".md")

        resource_markdown = resource.to_markdown(
            resource_md_path.absolute().as_posix(),
            True,
        ).replace("  | name", "\n  | name")

        with open(resource_md_path, "w") as resource_doc:
            resource_doc.write(resource_markdown)


def generate_db():
    # Create blank CSV files so that we don't get errors when creating the SQLite DB
    files_to_delete = []
    for resource in resources:
        if type(resource.path) is str:
            file_to_create = resource.path
            if not os.path.exists(file_to_create):
                with open(file_to_create, "a+"):
                    files_to_delete.append(file_to_create)

    # Use https://alpha.sqliteviewer.app/ for verification!
    os.remove(DB_PATH / "gmns.sqlite")
    package.publish("sqlite:///" + (DB_PATH / "gmns.sqlite").absolute().as_posix())

    # Get list of every table and its schema
    connection = sqlite3.connect(DB_PATH / "gmns.sqlite")
    for table_name, table_sql in connection.execute(
        "SELECT name, sql FROM sqlite_master WHERE type='table';"
    ):
        with open(DB_PATH / f"{table_name}.sql", "w") as table_file:
            # Add "IF NOT EXISTS" condition
            table_sql = table_sql.replace("CREATE TABLE", "CREATE TABLE IF NOT EXISTS")
            table_file.write(table_sql)
    connection.close()

    # Remove temp files we created earlier
    for file_to_delete in files_to_delete:
        os.remove(file_to_delete)


if __name__ == "__main__":
    generate_docs()
    generate_db()
