package org.neo4j.example.unmanagedextension;

import com.sun.jersey.api.client.Client;
import org.codehaus.jackson.map.ObjectMapper;
import org.junit.Test;
import org.neo4j.graphdb.*;
import org.neo4j.graphdb.index.Index;
import org.neo4j.graphdb.schema.IndexDefinition;
import org.neo4j.graphdb.schema.Schema;
import org.neo4j.server.NeoServer;
import org.neo4j.server.helpers.CommunityServerBuilder;
import org.neo4j.server.rest.JaxRsResponse;
import org.neo4j.server.rest.RestRequest;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.TimeUnit;

import static org.junit.Assert.assertEquals;

public class MyServiceFunctionalTest {

    public static final Client CLIENT = Client.create();
    public static final String MOUNT_POINT = "/ext";
    private ObjectMapper objectMapper = new ObjectMapper();

    private static final RelationshipType KNOWS = DynamicRelationshipType.withName("KNOWS");

    //@Test
    public void shouldReturnFriends() throws IOException {
        NeoServer server = CommunityServerBuilder.server()
                .onPort(7575)
                .withThirdPartyJaxRsPackage("org.neo4j.example.unmanagedextension", MOUNT_POINT)
                .build();
        server.start();
        populateDb(server.getDatabase().getGraph());
        RestRequest restRequest = new RestRequest(server.baseUri().resolve(MOUNT_POINT), CLIENT);
        JaxRsResponse response = restRequest.get("service/loves/P1");
        System.out.println(response.getEntity());
        List<HashMap<String, Object>> actual = objectMapper.readValue(response.getEntity(), List.class);

        List<HashMap<String, Object>> expected = new ArrayList<>();
        HashMap<String, Object> result = new HashMap<String, Object>(){{
            put("location", "L1");
            put("name", "P2");
            put("matching_wants", 1);
            put("matching_has", 2);
            put("my_interests", Arrays.asList("T5"));
            put("their_interests", Arrays.asList("T1", "T3"));

        }};
        expected.add(result);

        assertEquals(expected, actual);
        server.stop();
    }

    private void populateDb(GraphDatabaseService db) {
        IndexDefinition locationIndexDefinition;
        IndexDefinition personIndexDefinition;
        IndexDefinition thingIndexDefinition;

        try ( Transaction tx = db.beginTx() )
        {
            Schema schema = db.schema();
            locationIndexDefinition = schema.indexFor( Labels.Location )
                    .on( "name" )
                    .create();
            personIndexDefinition = schema.indexFor( Labels.Person )
                    .on( "name" )
                    .create();
            thingIndexDefinition = schema.indexFor( Labels.Thing )
                    .on( "name" )
                    .create();

            tx.success();
        }

        try ( Transaction tx = db.beginTx() )
        {
            Schema schema = db.schema();
            schema.awaitIndexOnline( locationIndexDefinition, 10, TimeUnit.SECONDS );
            schema.awaitIndexOnline( personIndexDefinition, 10, TimeUnit.SECONDS );
            schema.awaitIndexOnline( thingIndexDefinition, 10, TimeUnit.SECONDS );
            tx.success();
        }

        try ( Transaction tx = db.beginTx() )
        {
            Node person1 = createNode(db, person1Hash, "Person");
            Node person2 = createNode(db, person2Hash, "Person");
            Node person3 = createNode(db, person3Hash, "Person");
            Node person4 = createNode(db, person4Hash, "Person");
            Node person5 = createNode(db, person5Hash, "Person");

            Node location1 = createNode(db, location1Hash, "Location");
            Node location2 = createNode(db, location2Hash, "Location");

            Node thing1 = createNode(db, thing1Hash, "Thing");
            Node thing2 = createNode(db, thing2Hash, "Thing");
            Node thing3 = createNode(db, thing3Hash, "Thing");
            Node thing4 = createNode(db, thing4Hash, "Thing");
            Node thing5 = createNode(db, thing5Hash, "Thing");

            person1.createRelationshipTo(location1, RelationshipTypes.LIVES_IN);
            person2.createRelationshipTo(location1, RelationshipTypes.LIVES_IN);
            person3.createRelationshipTo(location2, RelationshipTypes.LIVES_IN);
            person4.createRelationshipTo(location2, RelationshipTypes.LIVES_IN);
            person5.createRelationshipTo(location2, RelationshipTypes.LIVES_IN);

            person1.createRelationshipTo(thing1, RelationshipTypes.HAS);
            person1.createRelationshipTo(thing2, RelationshipTypes.HAS);
            person1.createRelationshipTo(thing3, RelationshipTypes.HAS);
            person2.createRelationshipTo(thing4, RelationshipTypes.HAS);
            person2.createRelationshipTo(thing5, RelationshipTypes.HAS);
            person3.createRelationshipTo(thing1, RelationshipTypes.HAS);
            person3.createRelationshipTo(thing3, RelationshipTypes.HAS);
            person3.createRelationshipTo(thing4, RelationshipTypes.HAS);
            person4.createRelationshipTo(thing2, RelationshipTypes.HAS);
            person4.createRelationshipTo(thing5, RelationshipTypes.HAS);
            person5.createRelationshipTo(thing2, RelationshipTypes.HAS);
            person5.createRelationshipTo(thing4, RelationshipTypes.HAS);
            person5.createRelationshipTo(thing5, RelationshipTypes.HAS);

            person1.createRelationshipTo(thing1, RelationshipTypes.WANTS);
            person1.createRelationshipTo(thing2, RelationshipTypes.WANTS);
            person1.createRelationshipTo(thing5, RelationshipTypes.WANTS);
            person2.createRelationshipTo(thing1, RelationshipTypes.WANTS);
            person2.createRelationshipTo(thing3, RelationshipTypes.WANTS);
            person3.createRelationshipTo(thing4, RelationshipTypes.WANTS);
            person3.createRelationshipTo(thing5, RelationshipTypes.WANTS);
            person4.createRelationshipTo(thing1, RelationshipTypes.WANTS);
            person4.createRelationshipTo(thing4, RelationshipTypes.WANTS);
            person5.createRelationshipTo(thing1, RelationshipTypes.WANTS);
            person5.createRelationshipTo(thing3, RelationshipTypes.WANTS);
            person5.createRelationshipTo(thing4, RelationshipTypes.WANTS);
            tx.success();
        }

    }

    private Node createNode(GraphDatabaseService db, HashMap<String, Object> values, String type) {
        Label label = DynamicLabel.label(type);

        Node node = db.createNode(label);
        for (Map.Entry<String, Object> entry : values.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            node.setProperty(key, value);
        }
        return node;
    }

    static HashMap<String, Object> person1Hash = new HashMap<String, Object>(){{
        put("name","P1");
        put("gender", "female");
        put("orientation", "straight");
    }};

    static HashMap<String, Object> person2Hash = new HashMap<String, Object>(){{
        put("name","P2");
        put("gender", "male");
        put("orientation", "straight");
    }};

    static HashMap<String, Object> person3Hash = new HashMap<String, Object>(){{
        put("name","P3");
        put("gender", "female");
        put("orientation", "gay");
    }};

    static HashMap<String, Object> person4Hash = new HashMap<String, Object>(){{
        put("name","P4");
        put("gender", "female");
        put("orientation", "gay");
    }};

    static HashMap<String, Object> person5Hash = new HashMap<String, Object>(){{
        put("name","P5");
        put("gender", "female");
        put("orientation", "gay");
    }};

    static HashMap<String, Object> location1Hash = new HashMap<String, Object>(){{
        put("name","L1");
    }};

    static HashMap<String, Object> location2Hash = new HashMap<String, Object>(){{
        put("name","L2");
    }};

    static HashMap<String, Object> thing1Hash = new HashMap<String, Object>(){{
        put("name","T1");
    }};

    static HashMap<String, Object> thing2Hash = new HashMap<String, Object>(){{
        put("name","T2");
    }};

    static HashMap<String, Object> thing3Hash = new HashMap<String, Object>(){{
        put("name","T3");
    }};

    static HashMap<String, Object> thing4Hash = new HashMap<String, Object>(){{
        put("name","T4");
    }};

    static HashMap<String, Object> thing5Hash = new HashMap<String, Object>(){{
        put("name","T5");
    }};

}
