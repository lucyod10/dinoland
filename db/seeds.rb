User.destroy_all
puts "Creating Users"
u1 = User.create :email => "wow@wow.com", :username => "wow", :password => "chicken", :coins => 100, :profile_image => "https://previews.123rf.com/images/ksuklein/ksuklein1705/ksuklein170500095/79142510-cute-green-dinosaur-cartoon-dino-character-isolated-vector-illustration-for-kids.jpg"
u2 = User.create :email => "cool@cool.com", :username => "cool", :password => "chicken", :coins => 100, :profile_image => "https://images-na.ssl-images-amazon.com/images/I/717HdTD-HhL._SL1500_.jpg"
u3 = User.create :email => "rad@rad.com", :username => "rad", :password => "chicken", :coins => 100, :profile_image => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk2wUIkmHsWcCOAmu_urFK-gsvn6cYu2k8QEGPDRQ3pp-YDXpU"
u4 = User.create :email => "admin@dinoland.com", :username => "admin", :password => "chicken", :admin => true, :coins => 1000, :profile_image => "https://images-na.ssl-images-amazon.com/images/I/41LUoRjxmIL.jpg"

Accessory.destroy_all
puts "Creating Accessories"
a1 = Accessory.create :name => "Beanie"
a2 = Accessory.create :name => "Scarf"
a3 = Accessory.create :name => "Cowboy Hat"

Character.destroy_all
puts "Creating Characters"
c1 = Character.create :name => "Moe", :age => 1, :talent => "Juggling"
c2 = Character.create :name => "Berty", :age => 50, :talent => "Balancing a beer on his head"
c3 = Character.create :name => "Gummo", :age => 5, :talent => "Chewing gum"

Species.destroy_all
puts "Creating Species"
s1 = Species.create :genus => "Stegosaurus", :order => "Ornithischia", :diet => "Herbivore", :fun_fact => "Although the Stegosaurus body was large, the size of their brain was only around the size of a dog’s."
s2 = Species.create :genus => "Diplodocus", :order => "Saurischia", :diet => "Herbivore", :fun_fact => "Diplodocuses are the longest known dinosaur."
s3 = Species.create :genus => "Troodon", :order => "Saurischia", :diet => "Omnivore", :fun_fact => "Its brain is proportionally larger than those found in living reptiles, so the animal may have been as intelligent as modern birds, which are more similar in brain size."


puts "Associations"
# Users and accessories
u1.accessories << a1
u2.accessories << a2
u3.accessories << a3

# Users and Species
u1.species << s1
u2.species << s2
u3.species << s3

# Users and Characters
u1.characters << c1
u2.characters << c2
u3.characters << c3

# Character and species
s1.characters << c1
s2.characters << c2
s3.characters << c3

# Accessory to Chatacters - many to many
c1.accessories << a1 << a3
c2.accessories << a1 << a2
c3.accessories << a2
