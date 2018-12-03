# TrelloR-additions
These are scripts I wrote to either update or use those in the TrelloR package

get_card_custfields replaces the current get_card_fields, which breaks with the updates to the Trello API

merge_custfields does the following
* loops through a list of card ids in df
* opens the Trello API and retrieves a dataframe, cust_fields, with the custom fields for each card using get_card_custfields
* creates a column for each custom field in df, if not already there
* adds the relevant data from cust_fields to df for each card

**Example:**
My df consists of card ids for a list of contacts.

```{r}
  id                        name
1 5bb0d9c24cc5fc390b660534  Egwene al'Vere 
2 5bbc9ac576ab110ee4cb30bd  Nynaeve al'Meara
3 5be605998f57462238b47f07  Mat Cauthon
4 5bb3fc2b4dc8f94b373be0d9  Rand al'Thor
5 5beec868c27235777f682a49  Padan Fain
```

The custom fields included things like "Title", "Company", "Email", ect... Get_card_custfields returns a dataframe, cust_fields, of custom fields that looks like this;

```{r}
  id                        idCustomField             idModel                   modelType   value.text                       
1 5bb0d9c2be606a4cb96b4ed5  5b96b843ab73431867ca0b9d  5bb0d9c24cc5fc390b660534  card        Amyrlin Seat
2 5bb0d9c24e3ba86e9a98a139  5b96b827ee1fa0573596282a  5bb0d9c24cc5fc390b660534  card        Aes Sedai
3 5bb0d9c2ee2ac80f0e209772  5b966f1efe0c7d8b11b65a40  5bb0d9c24cc5fc390b660534  card        EalVere@whitetower.com
4 5bb0d9c29b0321178bdab2b2  5b966f1efe0c7d8b11b65a3f  5bb0d9c24cc5fc390b660534  card        https://www.linkedin.com/in/egwene-alvere-96853717
```


+ id - id number for the custom field entry
+ idCustomField - id number for the custom field "type", e.g. Title
+ idModel - id number for the card being queried
+ value.text - the custom field value

I wanted to add the custom field values (value.text) for each contact to their row in df, in a organized fasion (all Titles in the same column).

The result of merge_custfields is;

```{r}
  id                        Name              Title             Company                Email                    Twitter
1 5bb0d9c24cc5fc390b660534  Egwene al'Vere    Amyrlin Seat      Aes Sedai              EalVere@whitetower.com   NA
2 5bbc9ac576ab110ee4cb30bd  Nynaeve al'Meara  Queen             Malkier                HRM@malkierkingdom.com   braidtugger
3 5be605998f57462238b47f07  Mat Cauthon       Captain-General   Band of the Red Hand   NA                       rollofthedice
4 5bb3fc2b4dc8f94b373be0d9  Rand al'Thor      Dragon Reborn     Asha'man               dragon@dragonreborn.com  NA
5 5beec868c27235777f682a49  Padan Fain        Mad Man           Mashadar               Pfain@daggerismine.com   daggerlover98 
```
