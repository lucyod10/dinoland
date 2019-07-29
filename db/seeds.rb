User.destroy_all
puts "Creating Users"
u1 = User.create :email => "wow@wow.com", :username => "wow", :password => "chicken", :coins => 100, :profile_image => "https://previews.123rf.com/images/ksuklein/ksuklein1705/ksuklein170500095/79142510-cute-green-dinosaur-cartoon-dino-character-isolated-vector-illustration-for-kids.jpg"
u2 = User.create :email => "cool@cool.com", :username => "cool", :password => "chicken", :coins => 100, :profile_image => "https://images-na.ssl-images-amazon.com/images/I/717HdTD-HhL._SL1500_.jpg"
u3 = User.create :email => "rad@rad.com", :username => "rad", :password => "chicken", :coins => 100, :profile_image => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk2wUIkmHsWcCOAmu_urFK-gsvn6cYu2k8QEGPDRQ3pp-YDXpU"
u4 = User.create :email => "admin@dinoland.com", :username => "admin", :password => "chicken", :admin => true, :coins => 1000, :profile_image => "https://images-na.ssl-images-amazon.com/images/I/41LUoRjxmIL.jpg"

Accessory.destroy_all
puts "Creating Accessories"
a1 = Accessory.create :name => "Beanie", :image => "https://www.trzcacak.rs/myfile/detail/188-1885962_cartoon-pictures-of-hats-winter-hat-cartoon-png.png", :cost => "25"
a2 = Accessory.create :name => "Scarf", :image => "https://previews.123rf.com/images/pandavector/pandavector1702/pandavector170207794/72601242-yellow-striped-wool-scarf-scarves-and-shawls-single-icon-in-cartoon-style-vector-symbol-stock-illust.jpg", :cost => "105"
a3 = Accessory.create :name => "Cowboy Hat", :image => "https://i.pinimg.com/236x/e1/71/32/e171320f51df193d0b419313f5e9baa7--cowboy-western-cowboy-hats.jpg?nii=t", :cost => "40"

Character.destroy_all
puts "Creating Characters"
c1 = Character.create :name => "Moe", :age => 1, :talent => "Juggling"
c2 = Character.create :name => "Berty", :age => 50, :talent => "Balancing a beer on his head"
c3 = Character.create :name => "Gummo", :age => 5, :talent => "Chewing gum"

Species.destroy_all
puts "Creating Species"
s1 = Species.create :genus => "Stegosaurus", :order => "Ornithischia", :diet => "Herbivore", :fun_fact => "Although the Stegosaurus body was large, the size of their brain was only around the size of a dog’s.", :image => "http://www.sciencekids.co.nz/images/pictures/dinosaurs/stegosaurus/stegosauruscartoon.jpg"
s2 = Species.create :genus => "Diplodocus", :order => "Saurischia", :diet => "Herbivore", :fun_fact => "Diplodocuses are the longest known dinosaur.", :image => "https://image.shutterstock.com/image-vector/cute-animals-dinosaur-diplodocus-illustrations-260nw-1288028704.jpg"
s3 = Species.create :genus => "Troodon", :order => "Saurischia", :diet => "Omnivore", :fun_fact => "Its brain is proportionally larger than those found in living reptiles, so the animal may have been as intelligent as modern birds, which are more similar in brain size.", :image => "https://thumbs.dreamstime.com/b/happy-dinosaur-cartoon-illustration-isolated-white-56473501.jpg"


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
