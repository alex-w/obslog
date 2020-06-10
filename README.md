# obslog
obslog - an elementary database model for logging astronomical observations

# Why obslog?
What happens when you have accumulated many years of observations as an amateur astronomer? If you have a sort of logbook you will avoid forgetting what you saw, where, when and with whom. However, a physical record can become hard to search and classify as it grows large. It is for this reason that I created obslog, a relational database for storing astronomical observations of the kind made by amateur astronomers. It was born out of the need for the long-term preservation and retrieval of my records as an amateur astronomer, for planning future sessions, and for keeping the memory fresh about good moments spent under the stars.

# Concept
The central idea in obslog is that everything an amateur astronomer does takes place during a session. A session occurs during a specific span of time, in a specific place, under a given weather, Moon phase and particularities. These properties are common to all activities that are carried on during a session and do not need to be entered more than once, that is, as a row in a table describing sessions.

In the same way, activities that amateur astronomers do during a session have different sets of properties that define them, although some elements might be common. For example, all observations have a target object, are done with an instrument, which can be fitted with an eyepiece, filter, accessories, and result in some kind of note, sketch or data.

I chose a relational database model because it is more flexible and powerful approach than a spreadsheet while being only a bit more complicated. In a relational database entities are described non-redundantly in tables and the retrieval of information is done through queries. Queries can be arbitrarily complicated and may involve information stored in many tables. Queries can also be scripted in an external program, for example in Perl or Python.

# Implementation
Following the relational database paradigm, redundancy is minimized by defining separate tables for specific classes of activity and equipment, like session, site, observation, object, instrument, eyepiece, etc. Data are stored once, in only one place, and given an unique identifier. Every specific item can thus be uniquely referred to in another table if necessary, minimizing the chance of errors.

As it is not always possible or desirable to fill all fields, I deliberately chose to avoid the not null clause in most fields except for the unique identifier (primary key). Also following the relational database model, anything that can be calculated from stored data is explicitly avoided, for example the magnification given by a certain combination of telescope and eyepiece, or the Julian date, which if needed can be calculated in suitable queries using functions available in most languages.

The current design of the database necessarily reflects my style of practicing the hobby: visual observational sessions, heavily leaning on visual variable star estimations. I therefore include a table with comment codes from the American Association of Variable Star Observers (AAVSO) that are only useful for variable star observers. Obviously, this layout might not be adequate for whom imaging is the entire purpose of her/his sessions. This should not be a problem, as obslog is free software and users have the code at their disposal to make modifications that satisfy their needs.

I also include complete tables of constellations, reporting codes, Bortle scale and a generic 5 step scale for describing, for example, seeing and transparency.

The current implementation is done in SQLite because of its simplicity and portability. The complete database fits within a single file. The code to generate the tables is written in standard SQL and can be used in any other relational database system.

# Using obslog
The database (obslog.sqlite) is most easily accessed using a database browser. I prefer sqlitebrowser. It just works like a spreadsheet.

One starts by opening the database and filling necessary details in the auxiliary tables: site, instrument, mount, eyepiece, lens, filter, accesory, object. The auxiliary tables objectType, constellation, codeAAVSO, codeBortle, coseScale and codeReport are already filled in the supplied example, but can be adapted to the user's needs. The planning table project can also be used if necessary to describe observing projects to which observations are linked.

Once the auxiliary tables are filled as necessary, one can start using the database to log observations. To do this one creates first an entry for a new session. A sessionID is automatically generated. One then proceeds to enter additional data: site, date and time for start and end, if summer time was used at the time (1 for yes, 0 for no), seeing and transparency (using codeScale), SQM measurements if available, temperature, humidity, wind, cloudiness and notes. Once the session is created and saved, one can start adding observations made during the session.

For logging observations the table obslog is used. To add a new observation just create a new record. An observation identifier is autmatically created. Then proceed to fill details as appropriate: obsNotes, obsInstrument (as indicated in instrument table), obsMount (idem for mount), obsEyepiece, obsLens, obsFilter, obsAccessory, obsProject (if the observation belongs to a project). The fields obsVSComp1 (comparison star), obsVSComp2 (check star), obsVSMagEst (magnitude estimate), obsVSMagEstErr (magnitude estimate error), obsVSFainterThan (fainter than magnitude, if applicable), obsVSAAVSOchart (AAVSO chart used), obsVSAAVSOcode (AAVSO comment code), obsReport (report code) are all used in the context of variable star observation. These do not need to be filled for other purposes.


# License
"obslog - an elementary database model for logging astronomical observations" is distributed under the GNU Lesser General Public License (LGPL) version 3 or later. Copies of the GNU General Public License (GPL) and the GNU Lesser General Public License (LGPL) are distributed along with the sources.

Permission to use, copy, modify, and distribute (with no more than a reasonable redistribution fee) this software and its documentation for any purpose is hereby granted, provided that the above copyright notice appear in all copies, that both that copyright notice and this permission notice appear in supporting documentation, and that the name of "obslog - an elementary database model for logging astronomical observations" not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission. The author makes no representations about the suitability of this software for any purpose. It is provided "as is" without expressed or implied warranty. It is provided with no support and without obligation on the part of the author to assist in its use, correction, modification, or enhancement.

