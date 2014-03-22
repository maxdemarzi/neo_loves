class NeoLoves < Sinatra::Application
  configure :development do |config|
    register Sinatra::Reloader
  end
  
  set :app_file, __FILE__
  set :haml, :format => :html5 

  $neo = Neography::Rest.new    

  configure do
    set :guys , %w[Adalberto Adolfo Adolph Adrian Ahmad Ahmed Al Alan Albert Alberto Alejandro Alex Alfonso Alonzo Alphonse Amado Andrea Andreas Anibal Anthony Antonia Antwan Arden Arlie Arnulfo Arron Arthur August Augustine Austin Barrett Bart Barton Beau Ben Benedict Bennett Bennie Benton Bernardo Berry Bill Billie Blair Blake Bo Bobbie Bobby Boyd Brant Brendan Brendon Brent Bret Britt Broderick Bruno Bryant Bryon Bud Buddy Burl Burt Burton Buster Calvin Cameron Carl Carmen Carson Cary Casey Cedric Chad Chadwick Charlie Chas Chase Chet Chris Christoper Chung Clayton Clement Cleo Clinton Clyde Cody Cole Coleman Colin Columbus Connie Conrad Cortez Courtney Craig Cristobal Cruz Dale Damian Damion Darell Dario Darrel Darren Darrick Darrin Darron Darwin David Dean Deandre Denver Deon Derick Desmond Devin Devon Dewitt Dexter Dick Dominic Don Donnie Donovan Dorian Doug Douglas Duane Dudley Duncan Dylan Earl Eddy Edgar Edgardo Edmond Edmund Edmundo Edwardo Eldon Eldridge Elisha Elliott Elmer Elvis Emery Emile Erick Erin Ernest Ernesto Erwin Ethan Ezekiel Ezra Fabian Felix Felton Fletcher Florencio Florentino Floyd Foster Francis Francisco Frank Freddy Fredric Fredrick Garland Garret Garrett Garry Gary Gaston Gayle Gene Geraldo German Gilberto Giovanni Giuseppe Glen Gordon Grady Granville Gregg Gregorio Gregory Grover Hai Hans Harlan Harland Harley Harold Harris Harrison Hayden Haywood Heath Henry Herbert Heriberto Herschel Hilton Hiram Hobert Hollis Homer Hosea Houston Huey Hugo Humberto Hung Hyman Ian Irving Irwin Isiah Isidro Isreal Ivan Jack Jackson Jaime Jamar Jamey Jamie Jarred Jarvis Jason Jasper Javier Jc Jefferey Jeffery Jeffry Jeramy Jeremiah Jeromy Jerry Jessie Jewell Joaquin Jody Joe Johnathon Jon Jonas Jonathan Jordan Joseph Josh Joshua Jude Julius Kasey Keith Ken Kendall Keneth Kenneth Kevin Kory Kraig Kristopher Kurtis Kyle Lacy Lance Lane Lawerence Leandro Lee Len Lenny Leo Leon Leonel Leopoldo Lester Lewis Lincoln Lindsay Lindsey Lino Linwood Lionel Lloyd Long Louie Louis Lowell Lucas Luciano Lucius Lupe Luther Lyndon Mac Malik Man Manual Marc Marcel Marcellus Marco Margarito Maria Mariano Marion Mark Markus Marlin Marlon Mason Matt Max Maximo Mckinley Mel Melvin Micah Michael Michal Micheal Miguel Mike Mikel Minh Mitch Moises Monroe Monte Morgan Myles Myron Nathan Nathanael Neal Ned Neil Nestor Nicholas Nicky Nicolas Noble Noe Normand Norris Numbers Ollie Orval Orville Osvaldo Oswaldo Otha Otto Pablo Paris Parker Patrick Pedro Phil Philip Porfirio Porter Preston Quentin Quincy Quinton Rafael Rashad Raul Ray Rayford Raymond Raymundo Reed Refugio Reggie Reginald Reinaldo Renato Rey Reynaldo Rhett Richard Rigoberto Riley Robbie Robt Rocco Rocky Rodney Rodolfo Rodrigo Roland Rolando Rolf Rolland Ron Ronnie Rosario Rosendo Ross Roy Royce Ruben Rubin Rueben Rufus Russel Rusty Ryan Sal Salvatore Samual Sandy Sang Santiago Scottie Scotty Sebastian Seymour Shaun Shawn Shelton Sherman Sherwood Shirley Shon Sid Silas Sol Solomon Stan Stanford Stephen Sterling Stewart Sung Sydney Ted Teodoro Terence Terrance Terrence Thad Theron Thurman Tim Titus Tobias Tommie Tommy Travis Trent Trevor Trey Trinidad Troy Truman Tuan Ty Tyler Tyrone Tyson Ulysses Val Vaughn Vern Victor Vince Vincent Von Wally Walton Warren Wayne Werner Wesley Whitney Wilburn Wiley Willy Wilmer Wilson Winston Wyatt Yong Young Zachariah Zachery Zack Zane]
    set :girls , %w[Adelaida Adrianne Adriene Aileen Akilah Alaine Albertina Alesha Aleta Aletha Alexandria Alfreda Alice Aline Alisa Allyn Alverta Alysa Amiee Anabel Analisa Anastacia Angeles Angelina Angla Anjanette Annabel Annalisa Annie Annika Antoinette Antonietta Ardelia Argentina Arlyne Ashli Astrid Audrea Aurelia Ava Barrie Bebe Bee Bernadine Bernetta Bethany Birgit Blythe Bobbi Bobbye Brandee Brenna Brigid Brigitte Calandra Carli Carmelia Carmelita Carmina Carolynn Carrie Casimira Cassie Cathy Cecily Celeste Chanel Charlotte Chasity Chery Chieko Chiquita Chrissy Christiana Christy Ciera Claudia Cleotilde Cleta Clorinda Colette Colleen Collette Conchita Coretta Cristal Cyndi Daniela Danille Dannielle Danyel Darcel Darcey Daria Dayna Deadra Debi Deena Deetta Delaine Delmy Delora Denise Denita Denna Desire Desiree Dia Diedra Dionne Dollie Dominque Domitila Donette Donnetta Dorene Dorinda Dorothea Dottie Drusilla Dyan Earnestine Edda Edna Edra Eileen Elayne Eleanore Elease Eleonore Eliana Elinor Elinore Elke Ellan Elna Elza Ema Emely Emerald Emmaline Ena Enriqueta Erica Esther Ethelene Evangelina Eve Evelyne Evie Fatima Fay Fredda Frida Gabrielle Gaynelle Genevive Georgine Ginette Ginny Golda Griselda Gudrun Guillermina Gwenda Harriett Harriette Hazel Helene Herlinda Hermelinda Hermila Hertha Hettie Hilaria Hui Jacalyn Jacqualine Jacque Jamee Jammie Janett Janise Janna Jannet Jasmine Jayne Jazmin Jeanett Jeanetta Jeanmarie Jeanna Jennie Jerica Jerilyn Jerri Jesica Jessenia Jessica Jin Joane Joanie Joanna Joannie Johnetta Joie Joselyn Joy Judith Julee Juli Juliane Julissa Justa Kacey Kaila Kala Kandis Kandra Kanisha Kara Karisa Karissa Karma Karoline Kasie Katharine Katheryn Kathryne Kayleigh Keeley Keena Kellie Kellye Kenna Kira Kittie Kori Kortney Krissy Kristina Krystal Kylee Kymberly Kyra Laci Lakeshia Lakiesha Lang Lani Lanie Laquanda Laquita Larhonda Larraine Larue Latanya Latoya Lavenia Leah Leatrice Leena Leilani Lennie Leonida Leontine Lera Lien Ligia Lila Liliana Lillie Lisette Lissette Livia Loida Lora Lorelei Lorina Louetta Lovella Lu Lucia Lucienne Lucile Lucy Lula Luvenia Lynsey Mabel Mabelle Mable Madalene Madeleine Madelene Madge Maegan Maia Maire Maisha Malika Mammie Manda Mandi Mandy Mao Marcelina Marcella Marcene Marcy Margarette Marge Marguerite Marie Marilee Marivel Markita Marlyn Marvella Maryland Maryrose Mathilde Meaghan Mechelle Meghann Mei Melisa Melodie Melody Melynda Mercedes Merideth Michaela Mika Mindi Minta Mirian Misty Moira Mollie Mona Myra Myrle Myrna Nakisha Nancee Nanette Natalya Natasha Nathalie Nelda Neoma Nicholle Nicole Nida Nilsa Nita Noella Odelia Ok Olympia Onita Ozie Pa Page Pamela Patrica Paulina Petrina Princess Pura Rachael Rachel Rachele Rachell Racquel Raelene Raguel Ramona Ramonita Reanna Rebeca Reina Reita Renda Renea Retta Riva Rosaura Roxanna Ruthann Ruthe Sacha Sachiko Salena Salina Samara Sarai Sarina Shae Shalonda Shaneka Shanelle Shanice Shanon Shantay Sharika Sharolyn Shavonda Shawanna Shelia Shelli Shemeka Shenna Sherice Sherie Sherise Sherlyn Sherril Sherry Sheryl Shila Shira Sibyl Simonne So Starla Stasia Stefania Stephanie Stephenie Stephnie Sumiko Susan Susann Susanna Suzette Suzy Syble Syreeta Tabetha Tai Takako Takisha Tamiko Tammara Tarah Tarsha Tatiana Tawana Tegan Teisha Tequila Terisa Tesha Theola Theresa Therese Thresa Tiesha Tiffany Tobie Tomiko Tona Toni Torri Tracee Tran Treasa Trinity Trista Trula Twana Twanna Tynisha Valene Valeria Valery Vallie Vannessa Vasiliki Verline Vernita Veronique Veta Vicky Vincenza Wendie Wenona Willa Williemae Wilma Xuan Yen Yolonda Yuki Zandra Zofia Zola Zula]
  end
  
  get '/' do
    @user = (settings.guys + settings.girls).sample

    cypher = "
              MATCH (me:Person {name: {user}})-[:lives_in]->city<-[:lives_in]-person
              WHERE me.orientation = person.orientation AND
                  ((me.gender <> person.gender AND me.orientation = \"straight\") OR
                   (me.gender = person.gender AND me.orientation = \"gay\")) AND
                    me-[:wants]->()<-[:has]-person AND 
                    me-[:has]->()<-[:wants]-person
              WITH DISTINCT city.name AS city_name, person, me
              MATCH  me-[:wants]->attributes<-[:has]-person-[:wants]->requirements<-[:has]-me
              RETURN city_name, person.name AS person_name,
                     COLLECT(DISTINCT attributes.name) AS my_interests,
                     COLLECT(DISTINCT requirements.name) AS their_interests,
                     COUNT(DISTINCT attributes) AS matching_wants, 
                    COUNT(DISTINCT requirements) AS matching_has
              ORDER BY matching_wants / (1.0 / matching_has) DESC
              LIMIT 10"                                  
                        
    @loves = $neo.execute_query(cypher, {:user => @user})["data"]   
    haml :index
  end
  
  get '/user/:user' do
    @user = params[:user]
    cypher = "MATCH (wants)<-[:wants]-(me:Person {name: {user}})-[:has]->has
              RETURN COLLECT(DISTINCT wants.name) AS wants,
                     COLLECT(DISTINCT has.name) AS has"
    @wants_and_has = $neo.execute_query(cypher, {:user => @user})["data"]   
    haml :user
  end
  
end