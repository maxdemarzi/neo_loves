package org.neo4j.example.unmanagedextension;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import org.codehaus.jackson.map.ObjectMapper;
import org.neo4j.graphdb.*;
import org.neo4j.helpers.collection.IteratorUtil;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Path("/service")
public class MyService {

    private static final ObjectMapper objectMapper = new ObjectMapper();

    private static final LoadingCache<Node, ArrayList<Node>> residents = CacheBuilder.newBuilder()
            .refreshAfterWrite(10, TimeUnit.MINUTES)
            .maximumSize(10000)
            .build(
                    new CacheLoader<Node, ArrayList<Node>>() {
                        public ArrayList<Node> load(Node location) {
                            return loadResidents(location);
                        }
                    });

    private static final ArrayList<Node> loadResidents(Node location){
        ArrayList<Node> people = new ArrayList<>();
        for (Relationship lives_in : location.getRelationships(RelationshipTypes.LIVES_IN, Direction.INCOMING)){
            people.add(lives_in.getStartNode());
        }
        return people;
    }

    private static final LoadingCache<Node, ArrayList<String>> peopleWants = CacheBuilder.newBuilder()
            .expireAfterWrite(1, TimeUnit.DAYS)
            .maximumSize(1000000)
            .build(
                    new CacheLoader<Node, ArrayList<String>>() {
                        public ArrayList<String> load(Node person) {
                            return loadWants(person);
                        }
                    });

    private static final ArrayList<String> loadWants(Node person){
        ArrayList<String> personWants = new ArrayList<>();
        for (Relationship wants : person.getRelationships(RelationshipTypes.WANTS, Direction.OUTGOING)){
            personWants.add((String) wants.getEndNode().getProperty("name"));
        }
        return personWants;
    }

    private static final LoadingCache<Node, ArrayList<String>> peopleHas = CacheBuilder.newBuilder()
            .maximumSize(1000000)
            .build(
                    new CacheLoader<Node, ArrayList<String>>() {
                        public ArrayList<String> load(Node person) {
                            return loadHas(person);
                        }
                    });

    private static final ArrayList<String> loadHas(Node person){
        ArrayList<String> personWants = new ArrayList<>();
        for (Relationship wants : person.getRelationships(RelationshipTypes.HAS, Direction.OUTGOING)){
            personWants.add((String) wants.getEndNode().getProperty("name"));
        }
        return personWants;
    }

    @GET
    @Path("/helloworld")
    public String helloWorld() {
        return "Hello World!";
    }

    @GET
    @Path("/loves/{name}")
    public Response getLoves(@PathParam("name") String name, @Context GraphDatabaseService db) throws Exception {

        List<HashMap<String, Object>> results = new ArrayList<>();
        HashSet<Node> people = new HashSet<>();
        HashMap<Node, ArrayList<String>> peopleWant = new HashMap<>();
        HashMap<Node, ArrayList<String>> peopleHave = new HashMap<>();

        try ( Transaction tx = db.beginTx() )
        {
            final Node user = IteratorUtil.singleOrNull(db.findNodesByLabelAndProperty(Labels.Person, "name", name));

            if(user != null) {
                String myGender = (String) user.getProperty("gender");
                String myOrientation = (String) user.getProperty("orientation");
                List<String> myWants = peopleWants.get(user);
                List<String> myHas = peopleHas.get(user);

                for(Relationship lives_in : user.getRelationships(RelationshipTypes.LIVES_IN, Direction.OUTGOING)){
                    Node location = lives_in.getEndNode();

                    for(Node person : residents.get(location)){

                        if(person.equals(user)){
                            continue;
                        }

                        if((myOrientation.equals("straight")) ^ (myGender == person.getProperty("gender") )){
                            people.add(person);
                            ArrayList<String> theirMatchingWants = new ArrayList<>();
                            ArrayList<String> theirMatchingHas = new ArrayList<>();

                            for(String wants : peopleWants.get(person)){
                                if(myHas.contains(wants)){
                                    theirMatchingWants.add(wants);
                                }
                            }

                            for(String has : peopleHas.get(person)){
                                if(myWants.contains(has)){
                                    theirMatchingHas.add(has);
                                }
                            }

                            peopleHave.put(person, theirMatchingHas);
                            peopleWant.put(person, theirMatchingWants);

                        }
                    }

                    String locationName = (String) location.getProperty("name");

                    for (Node person : people){
                        if(peopleHave.get(person).size() > 0 && peopleWant.get(person).size() > 0){
                            HashMap<String, Object> result = new HashMap<>();
                            result.put("location", locationName);
                            result.put("name", person.getProperty("name"));
                            result.put("my_interests", peopleHave.get(person));
                            result.put("their_interests", peopleWant.get(person));
                            result.put("matching_wants", peopleHave.get(person).size());
                            result.put("matching_has", peopleWant.get(person).size());
                            results.add(result);
                        }
                    }
                }
            }
            Collections.sort(results, resultComparator);
        }

        return Response.ok().entity(objectMapper.writeValueAsString(results.subList(0,Math.min(10, results.size())))).build();
    }


    private static final Comparator<HashMap<String, Object>> resultComparator =  new Comparator<HashMap<String, Object>>() {
        @Override
        public int compare(HashMap<String, Object> o1, HashMap<String, Object> o2) {
            double o1Value = ((int) o1.get("matching_wants") / (1.0/ (int) o1.get("matching_has")));
            double o2Value = ((int) o2.get("matching_wants") / (1.0/ (int) o2.get("matching_has")));
            return (int)(o2Value - o1Value);
        }
    };

}
