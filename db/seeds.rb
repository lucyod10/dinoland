User.destroy_all
puts "Creating Users"
u1 = User.create :email => "wow@wow.com", :username => "wow", :password => "chicken", :coins => 100, :profile_image => "accessory_tie.png"
u2 = User.create :email => "cool@cool.com", :username => "cool", :password => "chicken", :coins => 100, :profile_image => "accessory_bowtie.png"
u3 = User.create :email => "rad@rad.com", :username => "rad", :password => "chicken", :coins => 100, :profile_image => "accessory_cap_blue.png"
u4 = User.create :email => "admin@dinoland.com", :username => "admin", :password => "chicken", :admin => true, :coins => 1000, :profile_image => "accessory_sunglasses.png"
u5 = User.create :email => "amy@amy.amy", :username => "Amy", :password => "amyamyamy", :admin => false, :coins => 1000, :profile_image => "dino_01.png", :creator => true


Accessory.destroy_all
puts "Creating Accessories"
a1 = Accessory.create :name => "Bowtie", :image => "accessory_bowtie.png", :cost => "50"
a2 = Accessory.create :name => "Hat - blue cap", :image => "accessory_cap_blue.png", :cost => "15"
a3 = Accessory.create :name => "Hat - red cap", :image => "accessory_cap_red.png", :cost => "15"
a4 = Accessory.create :name => "Hat - propeller", :image => "accessory_hat_propeller.png", :cost => "32"
a5 = Accessory.create :name => "Monacle", :image => "accessory_monacle.png", :cost => "258"
a6 = Accessory.create :name => "Sunglasses", :image => "accessory_sunglasses.png", :cost => "24"
a7 = Accessory.create :name => "Tie", :image => "accessory_tie.png", :cost => "76"


Character.destroy_all
puts "Creating Characters"
c1 = Character.create :name => "Moe", :age => 1, :talent => "Juggling"
c2 = Character.create :name => "Berty", :age => 50, :talent => "Balancing a beer on his head"
c3 = Character.create :name => "Gummo", :age => 5, :talent => "Chewing gum"

Species.destroy_all
puts "Creating Species"
s1 = Species.create :genus => "Stegosaurus", :order => "Ornithischia", :diet => "Herbivore", :fun_fact => "Although the Stegosaurus body was large, the size of their brain was only around the size of a dog’s.", :image => "dino_03.png"
s2 = Species.create :genus => "Diplodocus", :order => "Saurischia", :diet => "Herbivore", :fun_fact => "Diplodocuses are the longest known dinosaur.", :image => "dino_01.png"
s3 = Species.create :genus => "Troodon", :order => "Saurischia", :diet => "Omnivore", :fun_fact => "Its brain is proportionally larger than those found in living reptiles, so the animal may have been as intelligent as modern birds, which are more similar in brain size.", :image => "dino_02.png"


puts "Associations"
# Users and accessories
u4.accessories << a1 << a2 << a3 << a4 << a5 << a6 << a7

# Users and Species
u4.species << s1 << s2 << s3


# Users and Characters
u1.characters << c1
u2.characters << c2
u3.characters << c3

# Character and species
s1.characters << c1
s2.characters << c2
s3.characters << c3
