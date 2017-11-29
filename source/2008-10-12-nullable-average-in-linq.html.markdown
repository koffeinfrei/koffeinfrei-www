---
title: nullable average in linq
date: 2008-10-12 12:00:00 UTC
---

The following code is one possibility (there may be more elegant solutions to
this) to handle a nullable average from a linq query. The problem arises when
the linq query does not return a result, thus the average being null. If you
don’t use a nullable type, you’ll get an exception. To get a nullable average
from an integer value you’ll need to provide a transform function to the
`Average` function.

<pre><code class="language-csharp">
double? nullableAverage =   
    (from m in dataContext.Moods     
    join g in dataContext.Groups on m.GroupGUID equals g.GUID    
    where g.GUID == groupGUID    
    select m.Level)     
    .Average&lt;int&gt;(x =&gt; new double?(x));  
int average = (int)Math.Round(nullableAverage.HasValue ? nullableAverage.Value : 0, 0);  
// ... 
</code></pre>
