import Foundation
import SwiftUI
import UniformTypeIdentifiers

public enum AgeGroup: CaseIterable {
    static let diverseNames = ["Alex", "Robin", "Chris", "Sam", "Charlie", "Max", "Taylor", "Jamie", "Jordan", "Casey", "Jules", "Sascha", "Kim", "Pat", "Rene", "Nico", "Stevie", "Sky", "Elliot", "Marian", "Andrea", "Jan", "Noa", "Toni", "Jo", "Francis", "Morgan", "Angel", "Alexis", "Dominique", "Luca", "Eden", "Ari", "Noel", "Dakota", "Remy", "Sage", "Quinn", "Emery", "Rowan", "Rio", "Cameron", "Avery", "Finley", "Harley", "Jesse", "Logan", "Shay", "Evelyn", "Addison"]
    
    case child
    case teenager
    case youngAdult
    case adult
    case middleAge
    case senior
    case elderly
    
    static func getAgeGroup(birthYear: Int) -> AgeGroup {
        let currentYear = Calendar.current.component(.year, from: Date())
        let age = currentYear - birthYear
        
        switch age {
        case 0...12: return .child
        case 13...19: return .teenager
        case 20...30: return .youngAdult
        case 31...40: return .adult
        case 41...60: return .middleAge
        case 61...80: return .senior
        default: return .elderly
        }
    }
    
    var firstNames: [GermanName.NameGender: [String]] {
        switch self {
        case .child:
            return [
                GermanName.NameGender.female: ["Leonie", "Amelie", "Marie", "Hannah", "Lina", "Emilia", "Sophia", "Clara", "Mia", "Ella", "Lilly", "Luisa", "Nele", "Charlotte", "Anna", "Emma", "Leni", "Elisa", "Emily", "Johanna", "Greta", "Mathilda", "Mara", "Zoe", "Antonia", "Nora", "Isabella", "Victoria", "Thea", "Carla", "Mila", "Helena", "Stella", "Paula", "Frieda", "Melina", "Amalia", "Florentine", "Rosalie", "Anni", "Eva", "Josephine", "Jette", "Valentina", "Lara", "Ida", "Merle", "Sophia-Marie", "Annika", "Tilda", "Malia", "Juna", "Ava", "Livia", "Nia", "Romy", "Clara-Marie", "Sophie", "Pia", "Marlene", "Fiona", "Lia", "Amira", "Malina", "Olivia", "Tessa", "Lilian", "Sienna", "Marla", "Cleo", "Liana", "Viktoria", "Kira", "Alina", "Aline", "Lana", "Jolina", "Lucia", "Adele", "Mina", "Noelle", "Stine", "Chiara", "Nela", "Anouk", "Elisabeth", "Celina", "Mathea", "Jasmin", "Anastasia", "Ina", "Selma", "Amelie-Marie", "Emely", "Alea", "Helene", "Marie-Claire", "Sarah", "Magdalena", "Evelina", "Joy", "Milena", "Cecilia", "Alma", "Selina", "Aurora", "Leila", "Alice", "Tabea", "Saskia", "Samira", "Nina", "Vanessa", "Aurelia", "Fabienne", "Carolin", "Estelle", "Tamara", "Melanie", "Freya", "Linda", "Annalena", "Vivien", "Malena", "Alessia", "Adriana", "Joleen", "Marlina", "Sina", "Melody", "Linnea", "Eleni", "Lucie", "Verena", "Rebecca", "Jana", "Mira", "Rabea", "Eliana", "Luna", "Ria", "Juliana", "Madita", "Emilia-Sophie", "Marina", "Noa", "Martha", "Florina", "Elina", "Alessa", "Isabel", "Sofie", "Marie-Therese", "Nathalie", "Jolie", "Serafina", "Angelina", "Alexandra", "Janina", "Rieke", "Camilla", "Amira-Lou", "Amara", "Melisa", "Amalia-Marie", "Viviana", "Mona", "Julina", "Felicitas", "Marie-Luise", "Hedi", "Celine", "Ariana", "Lilith", "Selena", "Carina", "Evelin", "Alicia", "Larissa", "Tatjana", "Luzia", "Cosima", "Melinda", "June", "Savanna", "Paulina", "Malia", "Raffaela", "Emelie", "Theresa", "Lilian", "Madeleine", "Yara", "Eliya", "Karolina", "Lilian-Marie", "Naomi", "Ines", "Juliane", "Amilia", "Cassandra", "Florence", "Leona", "Samantha", "Amélie", "Annelie", "Philippa", "Flora", "Elodie", "Henriette", "Loreen", "Emanuela", "Emilia-Claire", "Josephina", "Svenja", "Greta-Marie", "Elif", "Marie-Antonia", "Meline", "Hedda", "Liliana", "Zora", "Marie-Elisa", "Sophia-Claire", "Anette", "Emily-Joy", "Anabel", "Valeria", "Mariana", "Maren", "Elira", "Nathalia", "Ivy", "Anastasia-Claire", "Milina", "Vivien-Marie", "Jolie-Marie"],
                GermanName.NameGender.male: ["Ben", "Lukas", "Jonas", "Finn", "Elias", "Noah", "Leon", "Paul", "Maximilian", "Tim", "Luca", "Henry", "Felix", "Moritz", "Luis", "Julian", "Tom", "David", "Matteo", "Emil", "Linus", "Jakob", "Simon", "Mats", "Jannik", "Philipp", "Samuel", "Erik", "Oskar", "Levi", "Alexander", "Niklas", "Julius", "Max", "Fabian", "Tobias", "Jonathan", "Lennard", "Mika", "Sebastian", "Theo", "Lennox", "Vincent", "Johannes", "Jan", "Florian", "Michael", "Emanuel", "Nico", "Levin", "Marc", "Rafael", "Dominic", "Christopher", "Gabriel", "Adrian", "Eddie", "Maurice", "Fabio", "Jannis", "Colin", "Henrik", "Bastian", "Kai", "Oliver", "Benjamin", "Elian", "Joshua", "Timo", "Lorenz", "Aaron", "Jannis", "Christoph", "Patrick", "Robin", "Malte", "Lars", "Daniel", "Markus", "Cedric", "Richard", "Finnley", "Silas", "Timothy", "Sandro", "Dominik", "Flavio", "Brian", "Kilian", "Valentin", "Joris", "Manuel", "Tristan", "Maxim", "Steffen", "Tony", "Piet", "Frederik", "Nikolas", "Omar", "Arthur", "Gustav", "Erwin", "Stefan", "Jonah", "Roman", "Bruno", "Marlon", "Samuel"],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .teenager:
            return [
                GermanName.NameGender.female: ["Anna", "Laura", "Julia", "Marie", "Leonie", "Sophia", "Lena", "Hannah", "Lisa", "Sarah", "Mia", "Amelie", "Lara", "Johanna", "Emma", "Clara", "Emily", "Nele", "Paula", "Maja", "Charlotte", "Isabella", "Katharina", "Melina", "Greta", "Alina", "Luisa", "Fiona", "Elisa", "Lilly", "Theresa", "Jana", "Selina", "Franziska", "Julia-Sophie", "Carina", "Ella", "Helena", "Annika", "Sophie", "Josephine", "Nina", "Valentina", "Nora", "Frieda", "Leni", "Marlene", "Antonia", "Isabel", "Carolin", "Vivien", "Zoe", "Pia", "Vanessa", "Luise", "Evelyn", "Melanie", "Elena", "Tabea", "Verena", "Chiara", "Lina", "Alicia", "Angelina", "Romy", "Sandra", "Lea", "Rieke", "Annelie", "Samira", "Mira", "Anastasia", "Marie-Claire", "Jette", "Amalia", "Florentine", "Rabea", "Stefanie", "Celine", "Jasmin", "Alessia", "Yara", "Fabienne", "Tessa", "Malina", "Aurelia", "Eliana", "Lilia", "Juliane", "Rebecca", "Alma", "Carla", "Isabell", "Mina", "Martha", "Anja", "Thea", "Estelle", "Tamara", "Janina", "Eleni", "Marina", "Viktoria", "Melinda", "Selma", "Cecilia", "Freya", "Larissa", "Mona", "Magdalena", "Alessa", "Naomi", "Jolina", "Linnea", "Celina", "Serafina", "Marie-Luise", "Kira", "Nathalie", "Ava", "Adele", "Ida", "June", "Helene", "Jolie", "Luana", "Valerie", "Marla", "Juliana", "Paulina", "Talia", "Lilian", "Annalena", "Larina", "Rafaela", "Saskia", "Maike", "Jolien", "Aline", "Marit", "Alexandra", "Silke", "Emanuela", "Noelle", "Leona", "Aline-Marie", "Luzia", "Cleo", "Amira", "Sina", "Felicia", "Anina", "Alyssa", "Ines", "Jil", "Adriana", "Lucia", "Marie-Antonia", "Karina", "Angelique", "Dana", "Annemarie", "Henriette", "Ruth", "Tina", "Lucie", "Alisia", "Lina-Marie", "Nadia", "Sophia-Claire", "Cassandra", "Florina", "Milla", "Irina", "Stina", "Jasmina", "Luna", "Manuela", "Elodie", "Sofie", "Anita", "Simone", "Selina-Marie", "Lea-Marie", "Victoria", "Amélie", "Jessica", "Marisa", "Alida", "Silvia", "Adina", "Ella-Marie", "Daria", "Rosa", "Amely", "Mirja", "Evelina", "Corinna", "Alexia", "Veronika", "Madita", "Inga", "Bea", "Stella", "Carolina", "Franka", "Catarina", "Claudia", "Diana", "Jana-Sophie", "Jasmina-Marie", "Rina", "Nele-Marie", "Milena", "Sophia-Marie", "Marietta", "Joline", "Therese", "Anica", "Loreen", "Emily-Joy", "Gabriela", "Kristin", "Natascha", "Denise", "Doreen", "Elvira", "Miriam", "Madeleine", "Cornelia", "Louisa", "Sophie-Anne", "Marie-Christin", "Judith", "Lena-Marie", "Jacqueline", "Mia-Sophie", "Dalia", "Annalise", "Marie-Julie", "Katrin", "Lea-Sophie", "Martha-Marie", "Janna", "Nelli", "Marianne", "Gabriele", "Brigitte", "Antonia-Marie", "Stefania", "Anna-Maria", "Birgit", "Theresia", "Juliette", "Kerstin", "Marlies"],
                GermanName.NameGender.male: ["Tim", "Maximilian", "Paul", "Ben", "Jonas", "Felix", "Lukas", "Leon", "Elias", "Noah", "Mats", "Henry", "Finn", "Luca", "David", "Julian", "Tom", "Luis", "Linus", "Matteo", "Jonathan", "Simon", "Nico", "Max", "Samuel", "Philipp", "Erik", "Jakob", "Emil", "Jan", "Moritz", "Theo", "Vincent", "Oskar", "Mika", "Lennart", "Alexander", "Sebastian", "Adrian", "Julius", "Niklas", "Florian", "Rafael", "Levi", "Christoph", "Lenny", "Frederik", "Johannes", "Fabian", "Patrick", "Malte", "Aaron", "Marcel", "Kilian", "Robin", "Tristan", "Cedric", "Valentin", "Oliver", "Benedikt", "Arthur", "Stefan", "Dominik", "Piet", "Jannis", "Hannes", "Tony", "Lars", "Gabriel", "Tobias", "Jannik", "Kai", "Ricardo", "Tommy", "Daniel", "Christian", "Leander", "Markus", "Roman", "Friedrich", "Bruno", "Silas", "Janek", "Dominic", "Karsten", "Frederik", "Bastian", "Maurice", "Lennox", "Emanuel", "Richard", "Michael", "Steffen", "Torben", "Carsten", "Finnley", "Gustav", "Wilhelm", "Lorenz", "Konrad", "Otto", "Kevin", "Benno", "Wolfram", "Bernd", "Maxim", "Johann", "Jörg", "Achim", "Armin", "Marko", "Dirk", "Gero", "Sascha", "Claas", "Jens", "Andreas", "Franz", "Alfred", "Rudolf", "Gregor", "Heiko", "Tobias", "Volker"
],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .youngAdult:
            return [
                GermanName.NameGender.female: ["Lisa", "Katharina", "Michelle", "Sarah", "Anna", "Laura", "Julia", "Sabrina", "Vanessa", "Leonie", "Nadine", "Melanie", "Christina", "Nicole", "Sandra", "Lena", "Hannah", "Sophie", "Jennifer", "Theresa", "Marie", "Franziska", "Tanja", "Rebecca", "Stefanie", "Carina", "Jessica", "Miriam", "Elena", "Sophia", "Claudia", "Selina", "Jana", "Marlene", "Alina", "Patricia", "Fabienne", "Annika", "Antonia", "Johanna", "Carolin", "Pia", "Janine", "Romy", "Kathrin", "Celina", "Isabell", "Alicia", "Larissa", "Linda", "Amelie", "Helena", "Verena", "Pauline", "Fiona", "Melina", "Anja", "Louisa", "Emilia", "Nina", "Diana", "Tamara", "Eva", "Andrea", "Jacqueline", "Valentina", "Isabella", "Victoria", "Mona", "Tabea", "Lisa-Marie", "Nele", "Amalia", "Anna-Lena", "Elisa", "Anastasia", "Madeline", "Marlina", "Vanessa-Marie", "Jasmin", "Lara", "Aline", "Stella", "Yvonne", "Julia-Marie", "Annette", "Christin", "Marina", "Nathalie", "Martha", "Michaela", "Alessa", "Linda-Marie", "Carola", "Ina", "Elisabeth", "Alexandra", "Freya", "Melinda", "Janina", "Bianca", "Natalie", "Sarah-Marie", "Angelina", "Elisa-Marie", "Clara", "Marisa", "Lia", "Emely", "Luisa", "Monika", "Alyssa", "Sabine", "Celine", "Milena", "Jette", "Annina", "Kathleen", "Josephine", "Vera", "Carina-Marie", "Manuela", "Mira", "Sina", "Tatjana", "Malina", "Saskia", "Therese", "Yara", "Florence", "Lea", "Helene", "Marie-Claire", "Evelin", "Natascha", "Veronika", "Karolina", "Gabriela", "Marie-Therese", "Claudine", "Janett", "Magdalena", "Corinna", "Samira", "Rabea", "Merle", "Henriette", "Miriam-Sophie", "Doreen", "Aurelia", "Madita", "Leona", "Philippa", "Sophia-Marie", "Carolin-Marie", "Maja", "Melanie-Marie", "Livia", "Serafina", "Carmen", "Evelyn", "Jasmina", "Larina", "Annelie", "Sabina", "Ivana", "Florina", "Chiara", "Rosa", "Elaine", "Anna-Sophie", "Juliane", "Madeleine", "Bea", "Regina", "Ruth", "Viola", "Eileen", "Iris", "Lisa-Sophie", "Daria", "Selma", "Franziska-Marie", "Mila", "Anita", "Carolin-Sophie", "Marit", "Olivia", "Theresia", "Estelle", "Selena", "Nelia", "Melody", "Noemi", "Anna-Maria", "Katharina-Marie", "Lara-Marie", "Mathilda", "Simone", "Leona-Marie", "Lucia", "Alicia-Marie", "Amira", "Britta", "Dina", "Karina", "Isabell-Marie", "Anika", "Amalia-Marie", "Viktoria", "Rieke", "Denise", "Felicia", "Florentine", "Alice", "Lilly", "Cleo", "Ina-Marie", "Rosalie", "Samantha", "Yasmin", "Isabelle", "Anna-Claire", "Annalena", "Adele", "Elina", "Lucie", "Elli", "Carolina", "Kim", "Martha-Marie", "Maja-Sophie", "Steffi", "Ines", "Henrike", "Felicitas", "Marie-Elena", "Andrea-Sophie"],
                GermanName.NameGender.male: ["Kevin", "Tobias", "Christian", "Daniel", "Michael", "Maximilian", "Lukas", "Julian", "Florian", "Sebastian", "Felix", "Marcel", "Patrick", "Nico", "Jonas", "Paul", "Leon", "Markus", "Philipp", "Andreas", "Jan", "Simon", "David", "Stefan", "Matthias", "Alexander", "Tim", "Dominik", "Fabian", "Sascha", "Thomas", "Benjamin", "Elias", "Jannik", "Samuel", "Jonas", "Marco", "Christopher", "Erik", "Matteo", "Marc", "Niklas", "Julius", "Adrian", "Levi", "Benedikt", "Lennart", "Robin", "Rafael", "Aaron", "Timo", "Mika", "Vincent", "Cedric", "Valentin", "Johannes", "Richard", "Malte", "Kai", "Moritz", "Jonathan", "Arthur", "Tom", "Lennox", "Marlon", "Henry", "Emanuel", "Piet", "Hannes", "Kilian", "Bastian", "Jannis", "Frederik", "Oliver", "Lars", "Max", "Daniel", "Tobias", "Bruno", "Marko", "Steffen", "Finn", "Tristan", "Gabriel", "Linus", "Theodor", "Maurice", "Rene", "Roland", "Karsten", "Dominic", "Christian-Marie", "Nils", "Otto", "Nikolas", "Konrad", "Gustav", "Dirk", "Franz", "Alfred", "Heinrich", "Jörg", "Karim", "Volker", "Wilhelm", "Gregor", "Dieter", "Achim", "Bernd", "Torsten", "Walter", "Uwe", "Wolfram", "Norbert", "Armin", "Lutz", "Jürgen", "Gero", "Reinhard", "Sven", "Claas", "Rüdiger", "Holger", "Ludwig", "Axel", "Hubert", "Klaus", "Ewald", "Arnold", "Berthold", "Manfred", "Bernhard", "Friedrich", "Lorenz", "Hans", "Volkmar", "Gottfried", "Otmar", "Jörg", "Oskar", "Stephan", "Torben", "Markus", "Willy", "Wolfgang", "Udo", "Georg", "Rolf", "Kurt", "Thomas", "Dietmar", "Albrecht", "Ferdinand", "Joachim", "Winfried", "Helmut", "Adolf", "Günter"],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .adult:
            return [
                GermanName.NameGender.female: ["Sandra", "Nadine", "Melanie", "Christina", "Nicole", "Julia", "Sarah", "Stefanie", "Anna", "Katharina", "Vanessa", "Daniela", "Jennifer", "Sabrina", "Jessica", "Laura", "Lisa", "Carina", "Miriam", "Sonja", "Franziska", "Claudia", "Bianca", "Verena", "Martina", "Tanja", "Nina", "Alexandra", "Maria", "Michaela", "Monika", "Petra", "Susanne", "Andrea", "Manuela", "Kerstin", "Silke", "Jana", "Leonie", "Eva", "Anja", "Carolin", "Katrin", "Michelle", "Christine", "Elisabeth", "Tamara", "Jacqueline", "Theresa", "Melina", "Isabella", "Antonia", "Marina", "Annika", "Pia", "Victoria", "Kathrin", "Angelina", "Josephine", "Pauline", "Luisa", "Amelie", "Clara", "Nele", "Helena", "Marianne", "Lea", "Celine", "Rebecca", "Jasmin", "Marleen", "Elena", "Fiona", "Patricia", "Alicia", "Lena", "Jana-Marie", "Romy", "Anastasia", "Alina", "Johanna", "Selina", "Marleen", "Janine", "Natalie", "Fabienne", "Elisa", "Caroline", "Julia-Marie", "Diana", "Marlene", "Larissa", "Vera", "Helene", "Florentine", "Sophia", "Mona", "Greta", "Sophie", "Marie", "Louisa", "Evelyn", "Juliane", "Miriam", "Christin", "Ruth", "Claudine", "Amalia", "Gabriele", "Nathalie", "Nadine-Marie", "Melinda", "Martha", "Linda", "Madeleine", "Henriette", "Magdalena", "Gabriela", "Leona", "Karina", "Estelle", "Bea", "Simone", "Franziska-Marie", "Anna-Maria", "Adriana", "Alexia", "Angelique", "Corinna", "Sabine", "Vanessa-Marie", "Ines", "Isabell", "Joline", "Silvia", "Annemarie", "Janett", "Miriam-Sophie", "Veronika", "Brigitte", "Karolina", "Chiara", "Milena", "Selma", "Annalena", "Alice", "Lara", "Elli", "Noemi", "Mathilda", "Karin", "Alexandra", "Claudine", "Nelly", "Emanuela", "Annette", "Viktoria", "Serafina", "Rosalie", "Anna-Lena", "Ava", "Anita", "Sabina", "Victoria-Marie", "Paulina", "Elodie", "Lena-Marie", "Annika-Sophie", "Dana", "Marion", "Marisa", "Therese", "Florina", "Larina", "Amira", "Sophia-Marie", "Lucia", "Freya", "Leni", "Jette", "Anina", "Alessa", "Yara", "Alma", "Juliana", "Eveline", "Sina", "Thea", "Ina", "Vera-Marie", "Henrike", "Estella", "Marla", "Aurelia", "Vivien", "Manuela", "Tamara-Marie", "Carolina", "Tessa", "Rieke", "Marit", "Franka", "Merle", "Anika", "Nia", "Alena", "Helga", "Doreen", "Marta", "Lea-Marie", "Annalise", "Nina-Marie", "Cecilia", "Carmen", "Nora", "Isabella-Marie", "Katrin-Marie", "Felicia", "Gisela", "Amalia-Marie", "Annemarie", "Victoria-Sophie"],
                GermanName.NameGender.male: ["Daniel", "Michael", "Stefan", "Thomas", "Christian", "Tobias", "Andreas", "Patrick", "Jan", "Alexander", "Sebastian", "Florian", "Kevin", "Markus", "Lukas", "Benjamin", "Julian", "Dominik", "Simon", "Philipp", "Nico", "Jonas", "Matthias", "Marc", "Felix", "Marcel", "Maximilian", "David", "Stephan", "Christopher", "Oliver", "Fabian", "Kai", "Rene", "Robin", "Jens", "Tim", "Benedikt", "Leon", "Matteo", "Elias", "Moritz", "Vincent", "Kilian", "Jannik", "Samuel", "Aaron", "Adrian", "Johannes", "Hannes", "Valentin", "Rafael", "Marlon", "Lennart", "Tom", "Max", "Cedric", "Lennox", "Arthur", "Richard", "Malte", "Gabriel", "Tristan", "Frederik", "Henry", "Erik", "Niklas", "Jonathan", "Lars", "Silas", "Emil", "Paul", "Marko", "Linus", "Julius", "Piet", "Lorenz", "Theodor", "Maurice", "Konrad", "Friedrich", "Rolf", "Bernd", "Achim", "Karsten", "Manuel", "Dirk", "Gregor", "Nils", "Frank", "Torben", "Gustav", "Wilhelm", "Otto", "Sascha", "Bruno", "Armin", "Reinhard", "Jürgen", "Torsten", "Kurt", "Franz", "Berthold", "Alfred", "Walter", "Norbert", "Arnold", "Hubert", "Volker", "Wolfgang", "Gero", "Axel", "Helmut", "Uwe", "Winfried", "Klaus", "Lutz", "Joachim", "Andrej", "Gottfried", "Rainer", "Dietmar", "Friedhelm", "Albrecht", "Ewald", "Hartmut", "Günther", "Holger", "Steffen", "Ernst", "Roland", "Werner", "Detlef", "Egon", "Kornelius", "Siegfried", "Arndt", "Otmar", "Carsten", "Knut", "Udo", "Horst", "Gert", "Dietrich", "Hermann", "Heinrich", "Rudolf", "Henrik", "Adolf", "Georg", "Mark", "Oskar", "Wolf", "Bertram", "Hubertus", "Sigmar", "Wilfried"
],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .middleAge:
            return [
                GermanName.NameGender.female: ["Andrea", "Petra", "Claudia", "Susanne", "Monika", "Kerstin", "Birgit", "Sandra", "Nadine", "Melanie", "Nicole", "Christine", "Barbara", "Ulrike", "Heike", "Manuela", "Martina", "Sabrina", "Sonja", "Daniela", "Silke", "Anja", "Stephanie", "Gabriele", "Cornelia", "Brigitte", "Jutta", "Elke", "Angelika", "Sabine", "Carina", "Christina", "Marion", "Katharina", "Tanja", "Jennifer", "Annette", "Jana", "Renate", "Katrin", "Lisa", "Jessica", "Ute", "Anke", "Bettina", "Carola", "Michaela", "Beate", "Elisabeth", "Franziska", "Melanie", "Theresa", "Vanessa", "Eva", "Sarah", "Patricia", "Miriam", "Anna", "Helga", "Diana", "Alexandra", "Stephanie", "Maria", "Nina", "Verena", "Julia", "Anneliese", "Lena", "Martina", "Johanna", "Ilona", "Elena", "Nathalie", "Jennifer", "Marina", "Heidemarie", "Monique", "Claudine", "Antonia", "Alina", "Sabina", "Janine", "Jessica", "Helene", "Tamara", "Ingrid", "Carolin", "Angelina", "Aline", "Pia", "Rebecca", "Amelie", "Marianne", "Lilian", "Therese", "Annika", "Fabienne", "Isabella", "Amalia", "Felicitas", "Valentina", "Carmen", "Stella", "Anita", "Selina", "Gerda", "Evelyn", "Jasmin", "Tina", "Doreen", "Annalena", "Marlene", "Margrit", "Elisabeth-Marie", "Ursula", "Hanna", "Sophia", "Roswitha", "Iris", "Kathrin", "Astrid", "Nele", "Viktoria", "Ellen", "Amira", "Carla", "Gabriela", "Veronika", "Ruth", "Sabine-Marie", "Lore", "Liane", "Gisela", "Cecilia", "Saskia", "Magdalena", "Margarete", "Irma", "Louise", "Klara", "Cora", "Annika-Marie", "Susanna", "Eveline", "Lisa-Marie", "Clara", "Martha", "Frieda", "Annemarie", "Karin", "Britta", "Renée", "Adelheid", "Bärbel", "Ines", "Ilse", "Regina", "Lydia", "Rosalie", "Anna-Maria", "Aurelia", "Stefanie", "Vera", "Yvonne", "Margrit", "Helene-Marie", "Sybille", "Waltraud", "Adele", "Mathilda", "Florentine", "Theresia", "Alexis", "Selma", "Gertrud", "Angelika-Marie", "Helga-Marie", "Svenja", "Janette", "Christiane", "Irmgard", "Elsa", "Esther", "Dorothea", "Claudia-Marie", "Margit", "Adriana", "Franka", "Rosina", "Elisabeth-Sophie", "Henriette", "Therese-Marie", "Marlies", "Gundula", "Agneta", "Carola-Marie", "Ingrid-Marie", "Evelina", "Antje", "Dagmar", "Ulrike-Marie", "Trude", "Melina", "Greta", "Käthe", "Nora", "Wilhelmine", "Hedwig", "Ute-Marie", "Erika", "Thea", "Frida", "Marisa", "Gudrun", "Liane-Marie", "Claudette", "Wiebke", "Ylva", "Solveig"],
                GermanName.NameGender.male: ["Thomas", "Frank", "Andreas", "Wolfgang", "Michael", "Stefan", "Peter", "Markus", "Klaus", "Manfred", "Rolf", "Norbert", "Hans", "Jürgen", "Dieter", "Joachim", "Reinhard", "Walter", "Karl", "Günter", "Horst", "Uwe", "Rainer", "Werner", "Helmut", "Herbert", "Bernd", "Detlef", "Alfred", "Volker", "Friedrich", "Dirk", "Wilhelm", "Siegfried", "Holger", "Carsten", "Torsten", "Ernst", "Roland", "Sven", "Hartmut", "Gottfried", "Adolf", "Berthold", "Otto", "Hubert", "Heinrich", "Ludwig", "Achim", "Axel", "Norbert", "Egon", "Konrad", "Eberhard", "Martin", "Armin", "Arnold", "Fritz", "Georg", "Gerhard", "Rüdiger", "Christian", "Alexander", "Wolf-Dieter", "Gregor", "Ferdinand", "Matthias", "Wilfried", "Horst-Dieter", "Lothar", "Jürgen-Karl", "Jörg", "Hans-Dieter", "Hans-Jürgen", "Ralf", "Udo", "Oskar", "Friedhelm", "Heinz", "Erich", "Gert", "Rudi", "Eckart", "Hanno", "Knut", "Hermann", "Wilbert", "Lars", "Wolfram", "Ingolf", "Otmar", "Ruprecht", "Reto", "Gunnar", "Nils", "Rico", "Wieland", "Felix", "Johann", "Dietmar", "Philipp", "Benedikt", "Simon", "Hans-Peter", "Maximilian", "Julian", "Leon", "Henry", "Fabian", "Jonas", "Tobias", "Marcel", "Niklas", "Matthias", "Elias", "Jan", "Nico", "Dominik", "Jonathan", "Kai", "Malte", "Vincent", "Robin", "Julius", "Mark", "Tim", "Adrian", "Felipe", "Lennard", "Moritz", "Theodor", "Ruben", "Valentin", "Konstantin", "Sebastian", "Oscar", "Linus", "Hanno", "Florian", "Aaron", "Gabriel", "Tristan", "Leopold", "Matteo", "Luis", "Anton", "Paul", "Alexander-Marie", "Götz", "Rene", "Cornelius", "André", "Christian-Marie", "Roland-Marie"],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .senior:
            return [
                GermanName.NameGender.female: ["Renate", "Ursula", "Gisela", "Elisabeth", "Ingrid", "Helga", "Marianne", "Gerda", "Hildegard", "Anneliese", "Karin", "Christa", "Erika", "Margarete", "Barbara", "Brigitte", "Hannelore", "Ilse", "Lore", "Waltraud", "Ruth", "Anna", "Josefine", "Bärbel", "Monika", "Margot", "Irmgard", "Sigrid", "Edeltraud", "Maria", "Käthe", "Edith", "Ingeborg", "Ellen", "Gabriele", "Beate", "Ute", "Petra", "Roswitha", "Angela", "Cornelia", "Astrid", "Elfriede", "Claudia", "Regina", "Silvia", "Angelika", "Antje", "Lieselotte", "Doris", "Sibylle", "Andrea", "Susanne", "Jutta", "Dagmar", "Gudrun", "Christine", "Johanna", "Herta", "Therese", "Rosalinde", "Magdalena", "Klara", "Veronika", "Christiane", "Karola", "Martina", "Sabine", "Manuela", "Anita", "Gundula", "Heidemarie", "Frieda", "Erna", "Wilhelmine", "Melitta", "Hedwig", "Greta", "Ilona", "Gertrud", "Marion", "Rita", "Almut", "Irma", "Marianne", "Traudel", "Lore", "Trudel", "Annette", "Franziska", "Gisela-Marie", "Alfreda", "Theresia", "Carla", "Ursula-Marie", "Brigitta", "Charlotte", "Inka", "Meta", "Hedda", "Adelheid", "Jolanda", "Lucia", "Eleonore", "Grete", "Anneliese-Marie", "Florentine", "Ottilie", "Magda", "Gertrude", "Elsa", "Pauline", "Emilie", "Betty", "Luise", "Leokadia", "Vera", "Margit", "Hermine", "Cäcilia", "Silke", "Margreth", "Kornelia", "Rosalia", "Evelyne", "Erika-Marie", "Susanna", "Karolina", "Margrit", "Hanna", "Annelore", "Isolde", "Christel", "Ida", "Elise", "Else", "Elfriede-Marie", "Wiltrud", "Adelinde", "Gretel", "Henriette", "Ottilia", "Theresia-Marie", "Annelie", "Berta", "Thekla", "Hannelore-Marie", "Felicitas", "Lilli", "Clementine", "Hilaria", "Edelgard", "Bertha", "Edwina", "Agathe", "Ernestine", "Elsbeth", "Mathilde", "Irina", "Rosamunde", "Marlies", "Albertine", "Ria", "Verena", "Otilia", "Ottilie-Marie", "Irmgard-Marie", "Elisabeth-Marie", "Selma", "Heide", "Adele", "Friedgard", "Brunhilde", "Rosa", "Emilia", "Helene", "Leonie", "Augusta", "Iduna", "Erna-Marie", "Antonia", "Auguste", "Clarissa", "Elfriede-Luise", "Johanne", "Marika", "Wilhelma", "Brunhild", "Marianna", "Mathilda", "Berta-Marie", "Cecilia", "Senta", "Hedwig-Marie", "Alma", "Gertrudis", "Henrike", "Evelin", "Elfriede-Margot", "Ernestina", "Marianne-Luise", "Friedrun", "Wiltrude", "Ottilie-Elisabeth", "Lydia", "Emma", "Charlotte-Marie"],
                GermanName.NameGender.male: ["Hans", "Heinz", "Wolfgang", "Karl", "Wilhelm", "Walter", "Franz", "Friedrich", "Werner", "Horst", "Herbert", "Günther", "Manfred", "Gustav", "Jürgen", "Rudolf", "Helmut", "Erwin", "Siegfried", "Otto", "Reinhard", "Bernd", "Peter", "Paul", "Rainer", "Dieter", "Joachim", "Klaus", "Gerhard", "Ludwig", "Eberhard", "Edgar", "Adolf", "Arnold", "Gottfried", "Harald", "Georg", "Norbert", "Rolf", "Ferdinand", "Heinrich", "Kurt", "Willi", "Alfred", "Erich", "Anton", "Fritz", "Hermann", "Matthias", "Wilfried", "Hubert", "Egon", "Lothar", "Volker", "Axel", "Rüdiger", "Holger", "Udo", "Andreas", "Markus", "Martin", "Detlef", "Ewald", "Hans-Jürgen", "Konrad", "Otmar", "Bruno", "Oskar", "Stefan", "Theodor", "Heiko", "Armin", "Wolf", "Carsten", "Falk", "Hans-Peter", "Dietrich", "Artur", "Hans-Dieter", "Norbert-Marie", "Philipp", "Valentin", "Gregor", "Johannes", "Alwin", "Benedikt", "Matthias-Marie", "Edmund", "Ingo", "Achim", "Friedbert", "Eckhard", "Wilfried-Marie", "Sven", "Eckart", "Reto", "Lutz", "Hans-Otto", "Knut", "Rainer-Marie", "Christoph", "Torsten", "Ruprecht", "Adrian", "Arndt", "Vincent", "Elo", "Rudiger", "Hans-Werner", "Hans-Christian", "Harro", "Karl-Heinz", "August", "Theo", "Albert", "Berthold", "Lukas", "Leonhard", "Fridolin", "Sigmar", "Winfried", "Albrecht", "Herwig", "Roland", "Gero", "Wolfram", "Hanno", "Wolf-Dieter", "Jörg", "Hans-Dieter", "Falko", "Hagen", "Herwig-Marie", "Hartmut", "Friedhelm", "Kuno", "Eginhard", "Hans-Wilhelm", "Jochen", "Raimund", "Siegbert", "Götz", "Dietmar", "Otmar-Marie", "Bernhard", "Alfons", "Engelbert", "Friedwald", "Gerold", "Hans-Hermann", "Eugen", "Maximilian", "Leopold", "Dominik", "Tristan", "Franz-Josef"
],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        case .elderly:
            return [
                GermanName.NameGender.female: ["Erna", "Margarete", "Elisabeth", "Hedwig", "Anna", "Maria", "Frieda", "Wilhelmine", "Auguste", "Luise", "Clara", "Mathilde", "Emma", "Rosa", "Helene", "Johanna", "Theresia", "Anneliese", "Agnes", "Berta", "Gertrud", "Martha", "Ottilie", "Charlotte", "Herta", "Ida", "Amalie", "Adele", "Leokadia", "Thekla", "Cäcilia", "Elsa", "Marianne", "Meta", "Bertha", "Lina", "Grete", "Margot", "Rosalie", "Friedrike", "Henriette", "Susanna", "Caroline", "Brunhilde", "Adelheid", "Josefine", "Annelore", "Alma", "Johanne", "Ottilia", "Irmgard", "Clothilde", "Gertrude", "Wiltrud", "Rosalinde", "Melitta", "Edelgard", "Florentine", "Elisabeth-Marie", "Pauline", "Eleonore", "Henrike", "Elfriede", "Leonie", "Gundula", "Irma", "Regina", "Magdalena", "Adelinde", "Augusta", "Berthilde", "Lieselotte", "Roswitha", "Dorothea", "Walburga", "Annemarie", "Sibylle", "Ruth", "Edith", "Else", "Elise", "Ottilie-Marie", "Clementine", "Theodora", "Hedwig-Marie", "Benedikta", "Angelina", "Bernadette", "Johannine", "Philomena", "Hilaria", "Frida", "Eveline", "Ernestine", "Aurelia", "Veronika", "Esther", "Gisela", "Brigitta", "Antonia", "Margreth", "Hildegard-Marie", "Amalia", "Mathilda", "Trudel", "Frederika", "Elvira", "Irene", "Klara", "Anna-Marie", "Leontine", "Berit", "Senta", "Sabina", "Eulalia"],
                GermanName.NameGender.male: ["Wilhelm", "Karl", "Friedrich", "Hans", "Otto", "Heinrich", "Paul", "Franz", "Rudolf", "Ernst", "Hermann", "Theodor", "Josef", "Walter", "Johann", "August", "Alfred", "Georg", "Gustav", "Adolf", "Ludwig", "Bernhard", "Richard", "Anton", "Oskar", "Peter", "Jakob", "Konrad", "Armin", "Siegfried", "Eugen", "Ewald", "Waldemar", "Hans-Joachim", "Willi", "Kurt", "Fritz", "Herbert", "Werner", "Erwin", "Bruno", "Eberhard", "Rainer", "Joachim", "Hartmut", "Manfred", "Jürgen", "Gerhard", "Holger", "Klaus", "Rolf", "Bernd", "Volker", "Dietrich", "Martin", "Harald", "Axel", "Reinhard", "Rüdiger", "Edgar", "Helmut", "Arnold", "Sven", "Tobias", "Friedhelm", "Christian", "Christoph", "Albert", "Hans-Dieter", "Berthold", "Heiko", "Vinzenz", "Matthias", "Gottfried", "Eckhard", "Lorenz", "Wolf", "Hans-Georg", "Florian", "Elias", "Niklas", "Maximilian", "Leonhard", "Philipp", "Benjamin", "Friedrich-Marie", "Sigmund", "Benedikt", "Falk", "Gunther", "Detlef", "Adrian", "Torsten", "Gerhart", "Oswald", "Raimund", "Hubert", "Erhard", "Wiltrud", "Valentin", "Dominikus", "Patrik", "Helmuth", "Konstantin", "Balthasar", "Vincent", "Hans-Heinrich"],
                GermanName.NameGender.diverse: AgeGroup.diverseNames
            ]
        }
    }
}

public struct GermanName: Identifiable, Codable, Equatable, Hashable {
    public enum NameGender: String, Codable, CaseIterable {
        case female = "Frau"
        case male = "Mann"
        case diverse = "Divers"
    }
    
    public let id: String
    public let firstName: String
    public let lastName: String
    public let gender: NameGender
    public let birthYear: Int
    public var isFavorite: Bool
    
    public init(firstName: String, lastName: String, gender: NameGender, birthYear: Int, isFavorite: Bool = false) {
        self.id = "\(firstName)_\(lastName)_\(birthYear)"
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthYear = birthYear
        self.isFavorite = isFavorite
    }
    
    public static func == (lhs: GermanName, rhs: GermanName) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func generateNames(
        count: Int = 50,
        gender: NameGender,
        birthYear: Int,
        useAlliteration: Bool = false,
        useDoubleName: Bool = false
    ) -> [GermanName] {
        let ageGroup = AgeGroup.getAgeGroup(birthYear: birthYear)
        var names: [GermanName] = []
        
        let firstNames = ageGroup.firstNames[gender] ?? []
        
        // Group and select one random last name per letter
        let lastNames = Dictionary(grouping: ["Müller", "Schmidt", "Schneider", "Fischer", "Weber", "Meyer", "Wagner", "Becker", "Schulz", "Hoffmann", "Schäfer", "Koch", "Bauer", "Richter", "Klein", "Wolf", "Schröder", "Neumann", "Schwarz", "Zimmermann", "Braun", "Krüger", "Hofmann", "Hartmann", "Lange", "Schmitt", "Peters", "Otto", "Jung", "Imhoff", "Quandt", "Ullrich", "Vogel", "Thiel", "Dietrich", "Conrad", "Albrecht", "Gruber", "Ebert"]) {
            $0.prefix(1).lowercased()
        }
        .mapValues { names in
            names.randomElement() ?? ""
        }
        .values
        .sorted()
        
        let availableLastNames = Array(lastNames)
        
        // Generate one name for each available last name
        for lastName in availableLastNames {
            var firstName = firstNames.randomElement() ?? ""
            
            if useAlliteration {
                // Get all first names that start with the same letter as the last name
                let matchingFirstNames = firstNames.filter {
                    $0.prefix(1).lowercased() == lastName.prefix(1).lowercased()
                }
                
                if matchingFirstNames.isEmpty {
                    continue
                }
                
                firstName = matchingFirstNames.randomElement() ?? ""
                
                if useDoubleName {
                    // Get a different matching first name for the second part
                    let secondFirstName = matchingFirstNames
                        .filter { $0 != firstName }
                        .randomElement() ?? matchingFirstNames.randomElement() ?? ""
                    
                    names.append(GermanName(
                        firstName: "\(firstName)-\(secondFirstName)",
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                } else {
                    names.append(GermanName(
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            } else {
                if useDoubleName {
                    let secondFirstName = firstNames.randomElement() ?? ""
                    names.append(GermanName(
                        firstName: "\(firstName)-\(secondFirstName)",
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                } else {
                    names.append(GermanName(
                        firstName: firstName,
                        lastName: lastName,
                        gender: gender,
                        birthYear: birthYear
                    ))
                }
            }
            
            // Stop if we've reached the requested count
            if names.count >= count {
                break
            }
        }
        
        return names.sorted { first, second in
            if first.lastName == second.lastName {
                return first.firstName < second.firstName
            }
            return first.lastName < second.lastName
        }
    }
}
