---
title: DataGridView with an object data source
date: 2010-09-04 12:00:00 UTC
---

For my [Batch Replacer](https://github.com/koffeinfrei/batchreplacer) I am
using a
[DataGridView](http://msdn.microsoft.com/en-us/library/system.windows.forms.datagridview.aspx)
with an object data source, meaning that I have a collection class that holds
the data to be displayed. At first that class inherited from a usual
[List&lt;T&gt;](http://msdn.microsoft.com/en-us/library/6sh2ey19.aspx), which
led to the problem that the data binding wasn’t two-way. As soon as I bound
data to the DataGridView, it wasn’t possible to add any new rows to it in my
user interface. After some research I found out that instead of using a normal
`List&lt;T&gt;` I was supposed to use a
[BindingList&lt;T&gt;](http://msdn.microsoft.com/en-us/library/ms132679.aspx).
Using that the binding is two-way, and the user interface is normally editable
and new rows can be added. Also, of course, all modifications done in the user
interface are reflected in the object (meaning e.g.  that when a new row is
added, the object data source contains a corresponding entry).
