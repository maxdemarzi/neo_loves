package org.neo4j.example.unmanagedextension;

import org.neo4j.graphdb.RelationshipType;

public enum RelationshipTypes implements RelationshipType {
    LIVES_IN,
    WANTS,
    HAS
}