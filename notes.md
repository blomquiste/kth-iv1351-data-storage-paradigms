# Diskussioner

* Kontaktuppgifts tabell med personID som aktörerna är kopplade till. Eller en
  supertyp PERSON som aktörerna "subtypas" ifrån. 
* PersonID, StudentID, InstruktörsID bytas ut mot personnummer:
    * Förenklad lösning
    * Personnummer är unikt
  Men en kontaktpersons personnummer är ju irrelant så nej

* With inheritance duplicate contact information is stored for persons that are both instructors and students. Perhaps, person can be switched to contact_detail/contact_info?
or one can use person_id. 

JOINT "person" with contact details. A person has a contact ID and can be a contact person, student and/or instructor. No duplicats. The person has an ID.

Contact-details för studenter, instruktörer och contact person. Contact person ska inte ha personnumber och address!!!!!

* **id** -> system generated. "person number" (a.k.a. personnummer, social security nbr) should not be a requirement for ICE


* **name-issue** -> 
You can always construct a full name from its components, but you can't always deconstruct a full name into its components
' https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
' https://stackoverflow.com/questions/1122328/first-name-middle-name-last-name-why-not-full-name 

* **ensemble** -> Should it be a subtype of lesson-parent (the parent for group and individual) or its own?  The instructions separate them.

* A group lesson has a specified nbr of places (which may vary) -- WHAT DOES THAT MEAN?
Enbart ensemble har maximium? Men places i group betyder max? Eller?
  - Ska den då har en egen "entity"??
* ska minimum nbr of students logiken vara med i en dB?
* Ska genre och level vara egna entities eller typ enums?
* Finns fixed time slots och non fixed schedual för privata lektioner. Är det något som ska speglas i dBn?

* Admin staff? Ska det vara en database eller via en "app providing a user interface"---dvs bokningssystem

Bookings entity instead of lessons!! Eller ska lessons vara en parent och bookings något separat.

One price for beginner and intermediate, and one for advanced. -- Men kommer det alltid att gälla? Inte bra för flex. Vidare står det att they might not always
have the same price for beginners and intermediate lessons


# OTHER COMMENTS
* Choose a naming convention and style guide:
  D = WE WILL USE MOZILLA
  * https://www.sqlstyle.guide/
  * https://docs.telemetry.mozilla.org/concepts/sql_style
  * https://about.gitlab.com/handbook/business-technology/data-team/platform/sql-style-guide/

  * https://www.sqlshack.com/learn-sql-naming-conventions/
* sibling -> as an attribute in student? siblings [0..*]

* Students pay per lesson and instructors get payed per lesson
Vilka bokar lektioner direkt och indirekt?
elivery-address? Billing address? Home-address?