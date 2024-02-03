[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/GTp3VxVz)
# CS3217 Problem Set 2

**Name:** Lee Hern Ping

**Matric No:** A0217990W

## Tips
1. CS3217's docs is at https://cs3217.github.io/cs3217-docs. Do visit the docs often, as
   it contains all things relevant to CS3217.
2. A Swiftlint configuration file is provided for you. It is recommended for you
   to use Swiftlint and follow this configuration. We opted in all rules and
   then slowly removed some rules we found unwieldy; as such, if you discover
   any rule that you think should be added/removed, do notify the teaching staff
   and we will consider changing it!

   In addition, keep in mind that, ultimately, this tool is only a guideline;
   some exceptions may be made as long as code quality is not compromised.
3. Do not burn out. Have fun!

## Notes
SwiftLint: Turned off
- conditional_returns_on_newline: 
I feel that 
        guard isPointInView(position, ballSize: BallView.ballSize, in: size) else { return }
        guard !isPointOverlapping(position, ballSize: BallView.ballSize) else { return }
is easier to parse than
        guard isPointInView(position, ballSize: BallView.ballSize, in: size) else { 
            return 
        }
        guard !isPointOverlapping(position, ballSize: BallView.ballSize) else { 
            return 
        }

- file_name:
I use XXXEnum.swift to name my enum files but the enums themselves are just named XXX
 
- vertical_whitespace:
I use 2 newlines between my functions for readability

- implicit_return
Even if it is a one statement function, seeing the word 'return' helps with readability




## Dev Guide

### Model

1. Ball - Protocol

- Blue Ball 

- Orange Ball



## Tests
If you decide to write how you are going to do your tests instead of writing
actual tests, please write in this section. If you decide to write all of your
tests in code, please delete this section.

## Written Answers

### Design Tradeoffs
> When you are designing your system, you will inevitably run into several
> possible implementations, in which you need to choose one among all. Please
> write at least 2 such scenarios and explain the trade-offs in the choices you
> are making. Afterwards, explain what choices you choose to implement and why.
>
> For example (might not happen to you -- this is just hypothetical!), when
> implementing a certain touch gesture, you might decide to use the method
> `foo` instead of `bar`. Explain what are the advantages and disadvantages of
> using `foo` and `bar`, and why you decided to go with `foo`.

Your answer here

### Persistence Justification
> Please justify your choice of persistence method in your `README.md`. In
> other words, write your considerations in weighing the pros and cons of the
> persistence methods you have considered.

Your answer here
