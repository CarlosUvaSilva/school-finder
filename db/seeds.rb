schools = [
  {
    name: "Centro Infantil 1",
    street_name: "Avenida de Roma",
    street_number: "79",
    apartment_number: "R/C",
    zip_code: "1700-334",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "217972554"
  },
  {
    name: "Centro Infantil 2",
    street_name: "Avenida de Roma",
    street_number: "113",
    apartment_number: "R/C",
    zip_code: "1700-336",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "217802391"
  },
  {
    name: "Centro Infantil de Alvalade/Campo Grande",
    street_name: "Rua Ernesto de Vasconcelos",
    street_number: "8",
    apartment_number: nil,
    zip_code: "1700-162",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "210939709"
  },
  {
    name: "Centro Social Paroquial de São João de Deus",
    street_name: "Rua Brás Pacheco",
    street_number: "4",
    apartment_number: nil,
    zip_code: "1000-074",
    parish: "Areeiro",
    city: "Lisboa",
    phone_number: "218474116"
  },
  {
    name: "Centro Infantil Maria de Monserrate",
    street_name: "Rua Margarida de Abreu",
    street_number: "4",
    apartment_number: nil,
    zip_code: "1900-362",
    parish: "Areeiro",
    city: "Lisboa",
    phone_number: "211368514"
  },
  {
    name: "Externato Nobel",
    street_name: "Alameda Dom Afonso Henriques",
    street_number: "78A",
    apartment_number: nil,
    zip_code: "1000-125",
    parish: "Areeiro",
    city: "Lisboa",
    phone_number: "218465505"
  },
  {
    name: "Os Fraldas",
    street_name: "Rua Egas Moniz",
    street_number: "8",
    apartment_number: nil,
    zip_code: "1900-218",
    parish: "Areeiro",
    city: "Lisboa",
    phone_number: "218465505"
  }
]

schools.each do |school|
  School.where(
    name: school[:name]
  ).first_or_initialize.tap do |new_school|
    new_school.street_name = school[:street_name]
    new_school.street_number = school[:street_number]
    new_school.apartment_number = school[:apartment_number]
    new_school.zip_code = school[:zip_code]
    new_school.parish = school[:parish]
    new_school.city = school[:city]
    new_school.phone_number = school[:phone_number]
    new_school.save
  end
end

education_levels = [
  {
    name: "Creche"
  },
  {
    name: "Pré-Escolar"
  },
  {
    name: "Primeiro Ciclo"
  }
]

education_levels.each do |education_level|
  EducationLevel.where(
    name: education_level[:name]
  ).first_or_initialize.tap do |new_education_level|
    new_education_level.save
  end
end

SchoolEducationLevel.find_or_create_by(
  school: School.find_by(name: "Centro Infantil 1"),
  education_level: EducationLevel.find_by(name: "Creche")
)

SchoolEducationLevel.find_or_create_by(
  school: School.find_by(name: "Centro Infantil 2"),
  education_level: EducationLevel.find_by(name: "Creche")
)

SchoolEducationLevel.find_or_create_by(
  school: School.find_by(name: "Centro Infantil de Alvalade/Campo Grande"),
  education_level: EducationLevel.find_by(name: "Creche")
)

SchoolEducationLevel.find_or_create_by(
  school: School.find_by(name: "Centro Infantil de Alvalade/Campo Grande"),
  education_level: EducationLevel.find_by(name: "Pré-Escolar")
)

SchoolEducationLevel.find_or_create_by(
  school: School.find_by(name: "Centro Infantil de Alvalade/Campo Grande"),
  education_level: EducationLevel.find_by(name: "Primeiro Ciclo")
)
