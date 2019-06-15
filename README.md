# obslog
obslog - an elementary database model for logging astronomical observations

# About
What happens when you have accumulated over 20 years of observations as an amateur astronomer? If you have a sort of logbook you will avoid forgetting what you saw, where, when and with whom. However, a physical record can become hard to search and classify as it grows large. It is for this reason that I created obslog, a relational database for storing astronomical observations of the kind made by amateur astronomers. It was born out of the need for the long-term preservation and retrieval of my records as an amateur astronomer, for planning future sessions, and for keeping the memory fresh about good moments spent under the stars.

# Concept
The central idea in obslog is that everything an amateur astronomer does, like visual observations, photography, spectroscopy, etc., takes place during a session. A session occurs during a specific span of time, in a specific place, under a given weather, Moon phase and particularities. These properties are common to all activities that are carried on during a session and do not need to be entered more than once, that is, as a row in a table describing sessions.

In the same way, activities that amateur astronomers do during a session have different sets of properties that define them, although some elements might be common. For example, all observations have a target object, are done with an instrument, which can be fitted with an eyepiece, filter, accessories, and result in some kind of note, sketch or data.

I chose a relational database model because it is more flexible and powerful approach than a spreadsheet while being only a bit more complicated. In a relational database entities are described non-redundantly in tables and the retrieval of information is done through queries. Queries can be arbitrarily complicated and may involve information stored in many tables.

# Implementation
Following the relational database paradigm, in obslog redundancy is minimized by defining separate tables for specific classes of activity and equipment, like session, site, observation, object, instrument, eyepiece, etc. Data are stored once, in only one place, and given an unique identifier. Every specific item can thus be uniquely referred to in another table if necessary, minimizing the chance of errors.

As it is not always possible or desirable to fill all fields, I deliberately chose to avoid the not null clause in most fields except for the unique identifier (primary key). Also following the relational database model, anything that can be calculated from stored data is explicitly avoided, for example the magnification given by a certain combination of telescope and eyepiece, or the Julian date, which if needed can be calculated in suitable queries using simple functions.

The current design of the database necessarily reflects my style of practicing the hobby: observational sessions, heavily leaning on visual variable star estimations. I therefore include a table with comment codes from the American Association of Variable Star Observers (AAVSO) that are only useful for variable star observers. Obviously, this layout might not be adequate for whom imaging is the entire purpose of her/his sessions. This should not be a problem, as obslog is free software and users have the code at their disposal to make modifications that satisfy their needs.

The current implementation is done in SQLite because of its simplicity and portability, as the complete database fits within a single file. The code to generate the tables is nevertheless written in standard SQL and can be used in any other relational database system.

# License
"obslog - an elementary database model for logging astronomical observations" is distributed under the GNU Lesser General Public License (LGPL) version 3 or later. Copies of the GNU General Public License (GPL) and the GNU Lesser General Public License (LGPL) are distributed along with the sources.

Permission to use, copy, modify, and distribute (with no more than a reasonable redistribution fee) this software and its documentation for any purpose is hereby granted, provided that the above copyright notice appear in all copies, that both that copyright notice and this permission notice appear in supporting documentation, and that the name of "obslog - an elementary database model for logging astronomical observations" not be used in advertising or publicity pertaining to distribution of the software without specific, written prior permission. The author makes no representations about the suitability of this software for any purpose. It is provided "as is" without expressed or implied warranty. It is provided with no support and without obligation on the part of the author to assist in its use, correction, modification, or enhancement.


