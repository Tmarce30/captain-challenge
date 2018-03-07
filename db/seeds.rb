puts 'Cleaning database'
Personnage.destroy_all

puts 'Creating personnages'

nom_personnages = %w(mickey minnie donald pluto aladin bambie)

nom_personnages.each do |n|
  vie = (20..90).to_a.sample
  attaque = 100 - vie
  Personnage.create!(
    nom:              n.capitalize,
    points_vie:       vie,
    points_attaque:   attaque,
  )
end

puts 'Finished'
