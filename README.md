# SchemaSmithEnterpriseDemos

## Overview

The SchemaSmithEnterpriseDemos repository is a collection of demonstration sql server sample database definitions created to be deployed by our enterprise product suite to demonstrate the features and functionality they provide.

Each demo is self contained in one of the following subfolders

| Demo           | Status |
| -------------- | ------ |
| ValidProduct   | Done |
| Adventureworks | Done |
| Northwind      | Done |

## Quick Start Guide

Each demo has an associated docker service associated with it.  To deploy the full stack on windows or mac run the following from the root of the repository:

```bash
docker compose pull
docker compose build
docker compose up
```

## Additional Resources

Checkout our [wiki](https://github.com/Schema-Smith/SchemaSmithEnterpriseDemos/wiki) for documentation about how these tools work to make deploying sql server schema effortless.
