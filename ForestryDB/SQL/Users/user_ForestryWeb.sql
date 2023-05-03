USE [forest]

CREATE LOGIN [ForestryWeb] WITH PASSWORD = 'P@ssw0rd';
CREATE USER [ForestryWeb] FOR LOGIN [ForestryWeb]; 

GRANT SELECT TO [ForestryWeb];

GRANT INSERT TO [ForestryWeb];

GRANT UPDATE TO [ForestryWeb];

GRANT DELETE TO [ForestryWeb];

GRANT EXECUTE TO [ForestryWeb];