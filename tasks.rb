require 'neography'

class Tasks

  def self.orientation
    if rand < 0.95 
      "straight"
    else
      "gay"
    end
  end

  def self.hashify(results)
    results["data"].map {|row| Hash[*results["columns"].zip(row).flatten] }
  end

  def self.import   
    @neo = Neography::Rest.new
     
    cypher = "CREATE INDEX ON :Person(name)" 
    @neo.execute_query(cypher)

    cypher = "CREATE INDEX ON :Location(name)" 
    @neo.execute_query(cypher)

    cypher = "CREATE INDEX ON :Thing(name)" 
    @neo.execute_query(cypher)
     
    guys = %w[Adalberto Adolfo Adolph Adrian Ahmad Ahmed Al Alan Albert Alberto Alejandro Alex Alfonso Alonzo Alphonse Amado Andrea Andreas Anibal Anthony Antonia Antwan Arden Arlie Arnulfo Arron Arthur August Augustine Austin Barrett Bart Barton Beau Ben Benedict Bennett Bennie Benton Bernardo Berry Bill Billie Blair Blake Bo Bobbie Bobby Boyd Brant Brendan Brendon Brent Bret Britt Broderick Bruno Bryant Bryon Bud Buddy Burl Burt Burton Buster Calvin Cameron Carl Carmen Carson Cary Casey Cedric Chad Chadwick Charlie Chas Chase Chet Chris Christoper Chung Clayton Clement Cleo Clinton Clyde Cody Cole Coleman Colin Columbus Connie Conrad Cortez Courtney Craig Cristobal Cruz Dale Damian Damion Darell Dario Darrel Darren Darrick Darrin Darron Darwin David Dean Deandre Denver Deon Derick Desmond Devin Devon Dewitt Dexter Dick Dominic Don Donnie Donovan Dorian Doug Douglas Duane Dudley Duncan Dylan Earl Eddy Edgar Edgardo Edmond Edmund Edmundo Edwardo Eldon Eldridge Elisha Elliott Elmer Elvis Emery Emile Erick Erin Ernest Ernesto Erwin Ethan Ezekiel Ezra Fabian Felix Felton Fletcher Florencio Florentino Floyd Foster Francis Francisco Frank Freddy Fredric Fredrick Garland Garret Garrett Garry Gary Gaston Gayle Gene Geraldo German Gilberto Giovanni Giuseppe Glen Gordon Grady Granville Gregg Gregorio Gregory Grover Hai Hans Harlan Harland Harley Harold Harris Harrison Hayden Haywood Heath Henry Herbert Heriberto Herschel Hilton Hiram Hobert Hollis Homer Hosea Houston Huey Hugo Humberto Hung Hyman Ian Irving Irwin Isiah Isidro Isreal Ivan Jack Jackson Jaime Jamar Jamey Jamie Jarred Jarvis Jason Jasper Javier Jc Jefferey Jeffery Jeffry Jeramy Jeremiah Jeromy Jerry Jessie Jewell Joaquin Jody Joe Johnathon Jon Jonas Jonathan Jordan Joseph Josh Joshua Jude Julius Kasey Keith Ken Kendall Keneth Kenneth Kevin Kory Kraig Kristopher Kurtis Kyle Lacy Lance Lane Lawerence Leandro Lee Len Lenny Leo Leon Leonel Leopoldo Lester Lewis Lincoln Lindsay Lindsey Lino Linwood Lionel Lloyd Long Louie Louis Lowell Lucas Luciano Lucius Lupe Luther Lyndon Mac Malik Man Manual Marc Marcel Marcellus Marco Margarito Maria Mariano Marion Mark Markus Marlin Marlon Mason Matt Max Maximo Mckinley Mel Melvin Micah Michael Michal Micheal Miguel Mike Mikel Minh Mitch Moises Monroe Monte Morgan Myles Myron Nathan Nathanael Neal Ned Neil Nestor Nicholas Nicky Nicolas Noble Noe Normand Norris Numbers Ollie Orval Orville Osvaldo Oswaldo Otha Otto Pablo Paris Parker Patrick Pedro Phil Philip Porfirio Porter Preston Quentin Quincy Quinton Rafael Rashad Raul Ray Rayford Raymond Raymundo Reed Refugio Reggie Reginald Reinaldo Renato Rey Reynaldo Rhett Richard Rigoberto Riley Robbie Robt Rocco Rocky Rodney Rodolfo Rodrigo Roland Rolando Rolf Rolland Ron Ronnie Rosario Rosendo Ross Roy Royce Ruben Rubin Rueben Rufus Russel Rusty Ryan Sal Salvatore Samual Sandy Sang Santiago Scottie Scotty Sebastian Seymour Shaun Shawn Shelton Sherman Sherwood Shirley Shon Sid Silas Sol Solomon Stan Stanford Stephen Sterling Stewart Sung Sydney Ted Teodoro Terence Terrance Terrence Thad Theron Thurman Tim Titus Tobias Tommie Tommy Travis Trent Trevor Trey Trinidad Troy Truman Tuan Ty Tyler Tyrone Tyson Ulysses Val Vaughn Vern Victor Vince Vincent Von Wally Walton Warren Wayne Werner Wesley Whitney Wilburn Wiley Willy Wilmer Wilson Winston Wyatt Yong Young Zachariah Zachery Zack Zane]
    girls = %w[Adelaida Adrianne Adriene Aileen Akilah Alaine Albertina Alesha Aleta Aletha Alexandria Alfreda Alice Aline Alisa Allyn Alverta Alysa Amiee Anabel Analisa Anastacia Angeles Angelina Angla Anjanette Annabel Annalisa Annie Annika Antoinette Antonietta Ardelia Argentina Arlyne Ashli Astrid Audrea Aurelia Ava Barrie Bebe Bee Bernadine Bernetta Bethany Birgit Blythe Bobbi Bobbye Brandee Brenna Brigid Brigitte Calandra Carli Carmelia Carmelita Carmina Carolynn Carrie Casimira Cassie Cathy Cecily Celeste Chanel Charlotte Chasity Chery Chieko Chiquita Chrissy Christiana Christy Ciera Claudia Cleotilde Cleta Clorinda Colette Colleen Collette Conchita Coretta Cristal Cyndi Daniela Danille Dannielle Danyel Darcel Darcey Daria Dayna Deadra Debi Deena Deetta Delaine Delmy Delora Denise Denita Denna Desire Desiree Dia Diedra Dionne Dollie Dominque Domitila Donette Donnetta Dorene Dorinda Dorothea Dottie Drusilla Dyan Earnestine Edda Edna Edra Eileen Elayne Eleanore Elease Eleonore Eliana Elinor Elinore Elke Ellan Elna Elza Ema Emely Emerald Emmaline Ena Enriqueta Erica Esther Ethelene Evangelina Eve Evelyne Evie Fatima Fay Fredda Frida Gabrielle Gaynelle Genevive Georgine Ginette Ginny Golda Griselda Gudrun Guillermina Gwenda Harriett Harriette Hazel Helene Herlinda Hermelinda Hermila Hertha Hettie Hilaria Hui Jacalyn Jacqualine Jacque Jamee Jammie Janett Janise Janna Jannet Jasmine Jayne Jazmin Jeanett Jeanetta Jeanmarie Jeanna Jennie Jerica Jerilyn Jerri Jesica Jessenia Jessica Jin Joane Joanie Joanna Joannie Johnetta Joie Joselyn Joy Judith Julee Juli Juliane Julissa Justa Kacey Kaila Kala Kandis Kandra Kanisha Kara Karisa Karissa Karma Karoline Kasie Katharine Katheryn Kathryne Kayleigh Keeley Keena Kellie Kellye Kenna Kira Kittie Kori Kortney Krissy Kristina Krystal Kylee Kymberly Kyra Laci Lakeshia Lakiesha Lang Lani Lanie Laquanda Laquita Larhonda Larraine Larue Latanya Latoya Lavenia Leah Leatrice Leena Leilani Lennie Leonida Leontine Lera Lien Ligia Lila Liliana Lillie Lisette Lissette Livia Loida Lora Lorelei Lorina Louetta Lovella Lu Lucia Lucienne Lucile Lucy Lula Luvenia Lynsey Mabel Mabelle Mable Madalene Madeleine Madelene Madge Maegan Maia Maire Maisha Malika Mammie Manda Mandi Mandy Mao Marcelina Marcella Marcene Marcy Margarette Marge Marguerite Marie Marilee Marivel Markita Marlyn Marvella Maryland Maryrose Mathilde Meaghan Mechelle Meghann Mei Melisa Melodie Melody Melynda Mercedes Merideth Michaela Mika Mindi Minta Mirian Misty Moira Mollie Mona Myra Myrle Myrna Nakisha Nancee Nanette Natalya Natasha Nathalie Nelda Neoma Nicholle Nicole Nida Nilsa Nita Noella Odelia Ok Olympia Onita Ozie Pa Page Pamela Patrica Paulina Petrina Princess Pura Rachael Rachel Rachele Rachell Racquel Raelene Raguel Ramona Ramonita Reanna Rebeca Reina Reita Renda Renea Retta Riva Rosaura Roxanna Ruthann Ruthe Sacha Sachiko Salena Salina Samara Sarai Sarina Shae Shalonda Shaneka Shanelle Shanice Shanon Shantay Sharika Sharolyn Shavonda Shawanna Shelia Shelli Shemeka Shenna Sherice Sherie Sherise Sherlyn Sherril Sherry Sheryl Shila Shira Sibyl Simonne So Starla Stasia Stefania Stephanie Stephenie Stephnie Sumiko Susan Susann Susanna Suzette Suzy Syble Syreeta Tabetha Tai Takako Takisha Tamiko Tammara Tarah Tarsha Tatiana Tawana Tegan Teisha Tequila Terisa Tesha Theola Theresa Therese Thresa Tiesha Tiffany Tobie Tomiko Tona Toni Torri Tracee Tran Treasa Trinity Trista Trula Twana Twanna Tynisha Valene Valeria Valery Vallie Vannessa Vasiliki Verline Vernita Veronique Veta Vicky Vincenza Wendie Wenona Willa Williemae Wilma Xuan Yen Yolonda Yuki Zandra Zofia Zola Zula]
    cities = %w[Austin Baltimore Charlotte Chicago Dallas Detroit Miami Oakland Philadelphia Wichita]
    attributes = %w[Able Accepting Adventurous Aggressive Ambitious Annoying Arrogant Articulate Athletic Awkward Boastful Bold Bossy Brave Bright Busy Calm Careful Careless Caring Cautious Cheerful Clever Clumsy Compassionate Complex Conceited Confident Considerate Cooperative Courageous Creative Curious Dainty Daring Dark Defiant Demanding Determined Devout Disagreeable Disgruntled Dreamer Eager Efficient Embarrassed Energetic Excited Expert Fair Faithful Fancy Fighter Forgiving Free Friendly Friendly Frustrated Fun-loving Funny Generous Gentle Giving Gorgeous Gracious Grouchy Handsome Happy Hard-working Helpful Honest Hopeful Humble Humorous Imaginative Impulsive Independent Intelligent Inventive Jealous Joyful Judgmental Keen Kind Knowledgeable Lazy Leader Light Light-hearted Likeable Lively Lovable Loving Loyal Manipulative Materialistic Mature Melancholy Merry Messy Mischievous NaÃ¯ve Neat Nervous Noisy Obnoxious Opinionated Organized Outgoing Passive Patient Patriotic Perfectionist Personable Pitiful Plain Pleasant Pleasing Poor Popular Pretty Prim Proper Proud Questioning Quiet Radical Realistic Rebellious Reflective Relaxed Reliable Religious Reserved Respectful Responsible Reverent Rich Rigid Rude Sad Sarcastic Self-confident Self-conscious Selfish Sensible Sensitive Serious Short Shy Silly Simple Simple-minded Smart Stable Strong Stubborn Studious Successful Tall Tantalizing Tender Tense Thoughtful Thrilling Timid Tireless Tolerant Tough Tricky Trusting Ugly Understanding Unhappy Unique Unlucky Unselfish Vain Warm Wild Willing Wise Witty Zany]
  
    cypher = "CREATE (n:Person {nodes}) RETURN  ID(n) AS id, n.name AS name"

    nodes = []
    guys.each { |n| nodes <<  {"name" => n, "gender" => "male", "orientation" => orientation} }
    girls.each { |n| nodes << {"name" => n, "gender" => "female", "orientation" => orientation} }
    users = hashify(@neo.execute_query(cypher, {:nodes => nodes}))

    cypher = "CREATE (n:Location {nodes}) RETURN  ID(n) AS id, n.name AS name"
    nodes = []
    cities.each { |n| nodes << {"name" => n} }
    cities = hashify(@neo.execute_query(cypher, {:nodes => nodes}))
  
    cypher = "CREATE (n:Thing {nodes}) RETURN  ID(n) AS id, n.name AS name"
    nodes = []  
    attributes.each { |n| nodes << {"name" => n} }
    attributes = hashify(@neo.execute_query(cypher, {:nodes => nodes}))
  
    commands = []
    users.each do |user| 
      commands << [:create_relationship, "LIVES_IN", user["id"], cities.sample["id"], nil]    
    end  
    @neo.batch *commands

    users.each do |user| 
      commands = []
      attributes.sample(10 + rand(10)).each do |att|
        commands << [:create_relationship, "HAS", user["id"], att["id"], nil]    
      end
      @neo.batch *commands
    end  

    users.each do |user| 
      commands = []
      attributes.sample(10 + rand(10)).each do |att|
        commands << [:create_relationship, "WANTS", user["id"], att["id"], nil]    
      end
      @neo.batch *commands
    end  

  end
end