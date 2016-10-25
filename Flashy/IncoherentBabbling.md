# Incoherent babbabbling

---

## Forenote: 
If you have braved the dangers of digging through this nearly unreadable file network that Xcode spits out and calls an app, I applaud you. But, you will only find a checklist of things I need to do, some refrences to TeamTreehouse and resources of a simmilar nature. If you are looking for a checklist of things I need to do, some refrences to TeamTreehouse and resources of a simmilar nature, then congratulations, you made it.*

---

### An explenation of certian ideas.

Unique identifiers:

All cardsets have a unique identifier, for now, all it does is signify what file the data for that cardset is stored in. Depending on when you're reading this, I've either already or are planning to convert all cardsets to an array that can be appended to when needed by the user. Every time a new cardset is created, it is set to the number of GeneralModel.swift's "idMarker", then the number is raised by 1, and the cycle of life does it's thing.

So, when saving, the app saves/will save/should save ONLY the highest unique identifier, and then, when being unarchived, the cardsets are reclaimed via a for-loop iteration between 1 (the first cardset ID) and the highest ID out there.

---

* Make use of the print function, Crash reports can be genned that way.
* Harder, Better, Faster, Stronger.
* Carbon colorset: Background #101010.
* Generate SolarLight colorset. See Ethan's bit.
* **Add timestamps to the print log.**
* Fix bug where both buttons can dissapeer.

---

# EOF
