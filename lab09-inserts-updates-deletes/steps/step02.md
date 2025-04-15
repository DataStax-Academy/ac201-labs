In this step you will perform use `DELETE` at different scopes

❗ <strong>Warning:</strong> 
`DELETE` operations insert tombstones in the database and may have a negative impact on performance.

✅ Execute a query to retrieve all of the scores
```
SELECT * FROM scores;
```{{exec}}

Next you are going to delete Rick's score from week 2.
You are not going to delete the whole row, just the score column.

✅ Execute a query to delete the score
```
DELETE score FROM scores 
  WHERE team = 'EP' AND player = 'Rick' AND week = 2; 
```{{exec}}

✅ Execute a query to retrieve all of Rick's  scores
```
SELECT * FROM scores  WHERE team = 'EP' AND player = 'Rick';
```{{exec}}

There is still an entry for Rick for week 2 but the score column now displays null/

![deleted score](https://killrcoda-file-store.s3.us-east-1.amazonaws.com/AC201/Lab09/delete-score-only.jpg)

You can delete an entire row by specifying the its full *primary key* in the `WHERE` clause.
You can also delete a whole partition by specifying just the *partition key* in the `WHERE` clause.

✅ Delete the entire EP team
```
DELETE FROM scores WHERE team = 'EP';
```{{exec}}

✅ Verify that the EP team as been deleted
```
SELECT * FROM scores;
```{{exec}}

You should see that all the rows of the *EP* partition have been deleted.