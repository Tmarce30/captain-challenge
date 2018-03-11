puts 'Cleaning database'
Personnage.destroy_all

puts 'Creating personnages'

personnages = [
  { nom: "mickey", photo_url: 'https://img00.deviantart.net/973f/i/2016/232/8/2/angry_mickey_mouse_by_trainboy48-daep3en.png'},
  { nom: "donald", photo_url: 'http://moziru.com/images/donald-duck-clipart-angry-4.gif'},
  { nom: "simba", photo_url: 'https://vignette.wikia.nocookie.net/kingdomhearts/images/9/95/Simba.png/revision/latest?cb=20120412143410&path-prefix=fr'},
  { nom: "scar", photo_url: 'http://weclipart.com/gimg/8D0DAE9091C517F3/clipprsc.gif'},
  { nom: "aladin", photo_url: 'https://vignette.wikia.nocookie.net/mugenpedia/images/8/8d/Aladdin.gif/revision/latest?cb=20131007165626&path-prefix=fr'},
  { nom: "bambie", photo_url: 'https://vignette.wikia.nocookie.net/disney/images/1/13/Bambi_angry.gif/revision/latest?cb=20141214192236'},
  ]


personnages.each do |perso|
  vie = (30..70).to_a.sample
  attaque = (20..60).to_a.sample
  agilité = 150 - (vie + attaque)
  new_personnage = Personnage.new(
    nom:              perso[:nom],
    points_vie:       vie,
    points_attaque:   attaque,
    points_agilité:   agilité,
  )
  new_personnage.remote_photo_url = perso[:photo_url]
  new_personnage.save!
end

puts 'Finished'
