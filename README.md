Neo4j Dating Site with Location
===============================

This is a Neo4j sample Dating Site with Location.

1. Install Required Gems:

        bundle

2. Install Neo4j and Neo4j Spatial:

        rake neo4j:install
        rake neo4j:get_spatial

3. Install Unmanaged extension (see directions in unmanaged folder)

4. Load Data:

        rake neo4j:import

5. Start Neo4j server.

        rake neo4j:start

6. Start Application Server

        rackup

