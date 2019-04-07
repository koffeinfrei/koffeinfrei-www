---

title: Why you need to see your test fail
date: 2019-04-07 18:10 UTC
tags:

---

## Red / green (/ refactor)

When developing using TDD or test-first the first step is to write a test. This
test will initially fail, because there isn't an implementation yet.

A test-first workflow implicitly ensures that a test is failing before turning
green. Read up on the [The Cycles of
TDD](https://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html) if
you're not familiar with it.

When writing a test after writing the production code you'll never see the test
fail, because the correct implementation is already there.

## So? What's the problem with this?

The problem is that if you never see your test fail **you don't know if your
test is actually testing the right thing**, or testing anything at all.

The main purpose of a test is to make sure that your code is working properly.
(If you're doing TDD, driving the design of your production code actually is
the main purpose of writing a test.)

If you don't know if your code is actually testing the right thing, you can't
have confidence in your test, and you can't have confidence in your production
code.

If you ever write a test after, you need to temporarily change the
implementation to see your test fail. Don't change the test, **change the
production code**.

## Real life example

Say we want to fix a bug. Before fixing it, we create a test that asserts that
the bug exists in the first place. This means that the test needs to fail. We
are at an equivalent as the first step in the TDD cycle.

Only after writing the test we fix the bug. After fixing the bug, the test goes
green.

Imagine we write the test after fixing the bug. How do we know that the test
actually tests that the bug does not exist anymore? Worst case is that we
haven't actually fixed the bug.

To make sure that we actually have, we need to undo the fix, run the test and
make sure that the test fails. By doing that we verify that the bug has an
effect on our test that represents the expected behaviour of our production
code.

When re-applying the fix and the test goes green we can be pretty confident
that we are testing the bug fix, and thus that the bug does not exist anymore
(at least not in the form that our test case covers).

## The bottom line

If you want to trust your code you need to be able to trust your tests. You
can't do that unless you've seen your tests fail.

So don't get lazy. Don't just assume that your test is fine. **See**. **it**.
**fail**.
