# Learning DOD using my old assignments

I know this sound a bit weird why I am still touching some of my old assignments where people don't want to see after all the pain and sorrow when they were working on it, but I choose this assignment for some good reasons.

This assignment has a precise requirement which give me a clear direction of building something meaningful, without ending up with an aimless direction and with no concern about any confidential data. While this assignment were written in an OOP manner, so that I can study how to convert the objects into rational table which is the fundamental of Data Oriented Design. I also know that this assignment were nicely done, fulfilling most of the basic OOP concepts such that I can have some materials to evaluate between two programming concept.

I won't fully replicate the whole assignment because it is NO LONGER an assignment, but an experiment to explore DOD based on some material and reflect from the project.

I am no longer a student in that school of that assignment, but after a bit of recovery, it is the time going back to learning to something I really need for my future goals.

# Reflections 
_Log 001:_
Working on the project, and it turns out using hashmap is not a good idea because I have get rid of the prepended letter to tell the type of the customer or the salable, and most of the time, I only use integer to represent a customer, or an product, which I can use an array to fulfil the task. Besides, there is no concern on removing or inserting new data where all of the data are appended at the end or updated in place. Hashmap in this example works, but the hashing function is way more complex than directly index access, result in much longer time on access the data, resulting in a worse performance if the amount of data to be processed is huge, and have no advantage to the better delete performance since it is not needed.

In the future, I need to be clear about the requirement before determining a data structure which in this case, hashmap actually offer not much advantage but it will stay to explore the following concepts.

_Log 002: I guess it is time to pause and going back to OpenGL_
After I have taken a deeper look to the data oriented design, but it turns out using my former assignment might be a poor material to apply data oriented design because some issues:

- There is nothing much we can do in parallel
- Nor there are any process can be done in batches
- Even if the one does, they need nearly all of the data from the database.

Seems like most of the process requires all of the data set while they are One-off process, like handling a payment and generate a receive. The process requires all data: for example, buying a products requires fetching the customer, reading the cost of products and generate histories for orders, and there is no way to limit the process to partially access the data to fetch a smaller block of memory to prevent cache miss, or such action is necessary because it is not done in a batch which the benefit seems negligible.

Or Perhaps, I have done something wrong in the design which it is technically not in a data oriented way, especially I am not entirely sure what exactly is data transformation and how to implement it at this point. For that situation, I will put a pause on this repo, going back to the OpenGL and read more about the idea of DOD before I continue on this exercise.