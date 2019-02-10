---

title: Private methods are a code smell
date: 2019-02-09 21:09 UTC
tags: 

---

Just to get it out of the way up front: I'm not saying you should never use
private methods.

I'm trying to convey something a bit more nuanced. If you aren't a person that
can appreciate the grey zones of life this blog post may not be for you. Or
maybe even so. You should decide for yourself. If you can't do that, then this
blog post may not be for you. Or maybe it is nevertheless… Let's do this.


## Your private is someone else's public

The bottom line is that a private method of one class could be a public method
of another class. Every functionality is a public interface of something.

If it has to be made private this usually means that it is in the wrong place,
i.e. in the wrong class.

## Don't violate the SRP

Making a method private often means this: "This method doesn't really belong in
this class, so I'll just make it private so nobody notices." It's just sweeping
the dirt under the carpet. Just clean your floor properly and move this method
out of that class.

## Private methods should not be tested

I believe that private methods should not be tested, even if your language
supports calling them. Tests should only verify the public interface of a
class. A private method is an internal implementation detail which may change
and thus will break the test.

If the functionality of a private method is trivial it may be fine not to
explicitly test it. If it is non trivial though, testing the behavior of a
class’s private methods indirectly through the class’s public methods is pretty
much the same as testing it directly. If the private method has a complexity
that should be under test, it should be public. If it doesn't make sense to be
public in that class, it should be moved to another class.

If your goal is to achieve high test coverage, everything should be public and
therefore testable.

## Public interfaces should only expose what's relevant

The consumer of a public interface should not be bothered with unnecessary
internals. A method that does not seem to belong to the public interface
usually does not have any business of being part of that class and should
usually be moved somewhere else.

## Did you say reusability?

Having private methods excludes that functionality from being reused. If that
functionality is moved to a public method though it can be consumed by someone
else as well.

## Internal helper methods are (probably) fine

There are cases where a private method is fine. If a method is really just a
helper for a public method and doesn't make sense to live on its own in another
context then it's fine to keep it as a private method. If you start to touch
any of the guidelines mentioned before, this private method may evolve though
from being private.

## An example

This is just a really trivial academic example, but it should be enough to
illustrate my point:

```language-ruby
class Car
  def start
    ignite
  end

  private

  # Is ignition the responsibility of the `Car`?
  # Or rather of the motor?
  def ignite
  end
end
```

Let's move the private method to the `Motor` class:

```language-ruby
class Car
  attr_accessor :motor

  def start
    motor.ignite
  end
end

class Motor
  def ignite
  end
end
```

The "private" story here is this:

> The car starts by igniting itself

or

> The car starts by igniting the motor itself

The refactored story on the other hand is this:

> The car starts by telling the motor to ignite

## 4 questions to get private methods out of your face

If the answer to any of the following questions is "yes" you should consider
extracting the private method:

- Does this method violate the SRP?
- Should I test this method?
- Is this method relevant as part of the public interface?
- Could this method be reused and be consumed by another class as well?

## Perfection is never achieved

Having no private methods at all is the result of a perfect software design.
This doesn't imply that we cannot use private methods at all. It means that we
should try and strive towards a perfect design and reduce the use of private to
a minimum.
