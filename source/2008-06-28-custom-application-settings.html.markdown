---
title: custom application settings
date: 2008-06-28 12:00:00 UTC
---

Within a c\# winform application I needed to store a [generic
collection](http://msdn.microsoft.com/en-us/library/ms379564(VS.80).aspx) to my
settings, which I found out was not possible out of the box. It is possible
though to set the required type in the properties designer dialog, but the
serialization’s output is always nothing.

On my research on the internet for a solution i stumbled upon the post [Tips
for C\# .NET Software
Developers](http://www.personalmicrocosms.com/pages/dotnettips.aspx?c=27&amp;t=44#tip),
which described that the attribute
`[SettingsSerializeAs(SettingsSerializeAs.Binary)]` was required for the
settings property, and to set it accordingly in the `Settings.Designer.cs`
file. The problem here is that modifying designer generated code file is not
the best of all ideas, as the manual changes are overwritten every time the
settings are modified by the designer.  Thus, I followed the msn article on
[how to create application
settings](http://msdn.microsoft.com/en-us/library/ms171565(VS.80).aspx), which
told me to create a custom settings class. The drawback with this solution is
that I now have two settings classes, and not only one single to cover it all.

Here’s an example of the settings class. Note the use of the
SettingsSerializeAs attribute, as it is the key to the successful
serialization.

<pre><code class="language-csharp">
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;

namespace Koffeinfrei
{
    /// &lt;summary&gt;
    ///   This class provides extended settings. Use this class for types that need to have special     
    ///   attributes for serialization, that cannot be set using the config designer dialog.
    /// &lt;/summary&gt;
    internal class ExtendedSettings : ApplicationSettingsBase
    {
        private static readonly ExtendedSettings defaultInstance =
            ((ExtendedSettings) (Synchronized(new ExtendedSettings())));

        /// &lt;summary&gt;
        ///   Returns the default instance of this class.
        /// &lt;/summary&gt;
        /// &lt;remarks&gt;
        ///   Get the value of the &lt;see name="defaultInstance" /&gt; member.
        /// &lt;/remarks&gt;
        public static ExtendedSettings Default
        {
            get { return defaultInstance; }
        }

        /// &lt;summary&gt;
        ///   The &lt;see cref="SomeCustomClass" /&gt;s stored in the user scoped settings.
        /// &lt;/summary&gt;
        /// &lt;remarks&gt;
        ///   Get / set the value of the &lt;c&gt;CustomClasses&lt;/c&gt; property.
        /// &lt;/remarks&gt;
        [UserScopedSetting]
        [DebuggerNonUserCode]
        [SettingsSerializeAs(SettingsSerializeAs.Binary)]
        public Queue&lt;SomeCustomClass&gt; CustomClasses
        {
            get { return ((Queue&lt;SomeCustomClasses&gt;) (this["CustomClasses"])); }
            set { this["CustomClasses"] = value; }
        }
    }
}
</code></pre>

#### EDIT

Thanks to partial classes you can merge the custom settings to the main
settings. Just use the same class name `internal class Settings`.
