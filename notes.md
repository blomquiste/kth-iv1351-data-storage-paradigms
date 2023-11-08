# Diskussioner

* Kontaktuppgifts tabell med personID som aktörerna är kopplade till. Eller en
  supertyp PERSON som aktörerna "instansieras" ifrån. 
* PersonID, StudentID, InstruktörsID bytas ut mot personnummer:
    * Förenklad lösning
    * Personnummer är unikt

# COMMENTS
* With inheritance duplicate contact information is stored for persons that are both instructors and students. Perhaps, person can be switched to contact_detail/contact_info?
or one can use person_id. 

* **ice** -> A contact person for several students? How should one insure uniqueness? 

* **id** -> system generated. "person number" (a.k.a. personnummer, social security nbr) should not be a requirement for ICE

* **name-issue** -> You can always construct a full name from its components, but you can't always deconstruct a full name into its components
' https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
' https://stackoverflow.com/questions/1122328/first-name-middle-name-last-name-why-not-full-name 

* **ensemble** -> Should it be a subtype of parent or its own? 
The instructions seperate them

# MODELLERINGSFRÅGOR
* NOT NULL?
* OPTIONAL??
* KARDINALITET

# TODO
* Make two versions. One with inheritance and the other without (vilket är ett krav). Detta kan du göra i olika rutor? Som packages eller olika sidor? Ska det rutan in? Nice to have 

* all UNIQUEs should have NOT NULL
* UNIQUE -> is a Candidate key
* Choose a naming convention and style guide:
  D = WE WILL USE MOZILLA
  * https://www.sqlstyle.guide/
  * https://docs.telemetry.mozilla.org/concepts/sql_style
  * https://about.gitlab.com/handbook/business-technology/data-team/platform/sql-style-guide/

  * https://www.sqlshack.com/learn-sql-naming-conventions/
* sibling -> as an attribute in student? siblings [0..*]


* Students pay per lesson and instructors get payed per lesson
* A group lesson has a specified nbr of places (which may vary):
  - Ska den då har en egen "entity"??
* ska minimum nbr of students logiken vara med i en dB?
* Ska genre och level vara egna entities eller typ enums?
* Finns fixed time slots och non fixed schedual för privata lektioner. Är det något som ska speglas i dBn?

* Admin staff? Ska det vara en database eller via en "app providing a user interface"---dvs bokningssystem

Bookings entity instead of lessons!! Eller ska lessons vara en parent och bookings något separat.

Enbart ensemble har maximium

Contact-details för studenter, instruktörer och contact person. Contact person ska inte ha personnumber och address!!!!!

Vilka bokar lektioner direkt och indirekt?

One price for beginner and intermediate, and one for advanced. -- Men kommer du
alltid att gälla? Inte bra för flex. Vidare står det att they might not always
have the same price for beginners and intermediate lessons

Are ensembles with or without instructors??

Delivery-address? Billing address? Home-address?