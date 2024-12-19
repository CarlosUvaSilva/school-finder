schools = [
  {
    name: "Centro Infantil 1",
    street_name: "Avenida de Roma",
    street_number: 79,
    apartment_number: "R/C",
    zip_code: "17000-334",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "217972554"
  },
  {
    name: "Centro Infantil 2",
    street_name: "Avenida de Roma",
    street_number: 113,
    apartment_number: "R/C",
    zip_code: "17000-336",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "217802391"
  },
  {
    name: "Centro Infantil de Alvalade/Campo Grande",
    street_name: "Rua Ernesto de Vasconcelos",
    street_number: 8,
    apartment_number: nil,
    zip_code: "17000-162",
    parish: "Alvalade",
    city: "Lisboa",
    phone_number: "210939709"
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
