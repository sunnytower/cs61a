CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name,size from dogs,sizes where height>min and height<=max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents,dogs where name=parent order by height desc;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT d1.name as s1,d2.name as s2 from dogs as d1,dogs as d2,parents as p1,parents as p2 where p1.parent=p2.parent and d1.name <d2.name and d1.name=p1.child and d2.name=p2.child;
-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT s1 ||" and " || s2 ||" are " ||sod1.size ||" siblings" from siblings,size_of_dogs as sod1,size_of_dogs as sod2 where sod1.name=s1 and sod2.name=s2 and sod1.size=sod2.size order by s1;
-- Total size for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur,sum(height) from dogs group by fur having max(height)<avg(height)*1.3 and min(height)>avg(height)*0.7;
