# SchemaSmith Enterprise Demos

Demo database schema packages for SQL Server, PostgreSQL, and MySQL, deployed by [SchemaForge](https://github.com/Schema-Smith/SchemaForge) (SchemaQuench).

## Demo Products

| Product | SQL Server | PostgreSQL | MySQL |
|---------|:---:|:---:|:---:|
| ValidProduct | Done | Done | Done |
| AdventureWorks | Done | Done | Pending |
| Northwind | Done | Done | Pending |
| DVDRental | -- | Done | -- |
| Sakila | -- | -- | Done |

## Quick Start

Choose a platform and run:

```bash
# SQL Server
cd SqlServer && docker compose pull && docker compose build && docker compose up

# PostgreSQL
cd PostgreSQL && docker compose pull && docker compose up

# MySQL
cd MySQL && docker compose pull && docker compose up
```

Each platform folder contains:
- Demo schema packages (product folders)
- A `docker-compose.yml` that spins up the database server and runs SchemaQuench to deploy the demo schemas
- A `.env` file with default credentials

SQL Server requires `docker compose build` because it uses a custom Dockerfile to install Full-Text Search.

## Sample Menu Commands

The `Sample Menu Commands/` folder contains importable menu configurations for [SchemaHammer](https://github.com/Schema-Smith/SchemaForge):
- `Sample Context Menu.MenuExport` -- right-click tree view commands
- `Sample Extension Menu.MenuExport` -- top-level Extensions menu commands

## Additional Resources

- [SchemaSmith Website](https://schemasmith.com) -- documentation and getting started guides
- [SchemaForge](https://github.com/Schema-Smith/SchemaForge) -- the unified schema management toolset
