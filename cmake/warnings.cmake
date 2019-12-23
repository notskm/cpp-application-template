option(
    WARNINGS_AS_ERRORS
    "Treat warnings as errors"
    OFF
)

# cmake-format: off

# Warnings are taken from
# https://github.com/lefticus/cppbestpractices/blob/master/02-Use_the_Tools_Available.md

# cmake-format: on

function (target_enable_warnings target)
    if (MSVC)
        target_compile_options(
            ${target}
            PRIVATE
                # enforces standard conformance
                /permissive-
                # all reasonable warnings
                /W4
                # 'identfier': conversion from 'type1' to 'type1', possible loss
                # of data
                /w14242
                # 'operator': conversion from 'type1:field_bits' to
                # 'type2:field_bits', possible loss of data
                /w14254
                # 'function': member function does not override any base class
                # virtual member function
                /w14263
                # 'classname': class has virtual functions, but destructor is
                # not virtual instances of this class may not be destructed
                # correctly
                /w14265
                # 'operator': unsigned/negative constant mismatch
                /w14287
                # nonstandard extension used: 'variable': loop control variable
                # declared in the for-loop is used outside the for-loop scope
                /we4289
                # 'operator': expression is always 'boolean_value'
                /w14296
                # 'variable': pointer truncation from 'type1' to 'type2'
                /w14311
                # expression before comma evaluates to a function which is
                # missing an argument list
                /w14545
                # function call before comma missing argument list
                /w14546
                # 'operator': operator before comma has no effect; expected
                # operator with side-effect
                /w14547
                # 'operator': operator before comma has no effect; did you
                # intend 'operator'?
                /w14549
                # expression has no effect; expected expression with side-effect
                /w14555
                # Enable warning on thread un-safe static member initialization
                /w14640
                # Conversion from 'type1' to 'type_2' is sign-extended. This may
                # cause unexpected runtime behavior.
                /w14826
                # wide string literal cast to 'LPSTR'
                /w14905
                # string literal cast to 'LPWSTR'
                /w14906
                # illegal copy-initialization; more than one user-defined
                # conversion has been implicitly applied
                /w14928
        )
    else ()
        target_compile_options(
            ${target}
            PRIVATE
                # reasonable and standard
                -Wall
                # reasonable and standard
                -Wextra
                # warn if a vairable declaration shadows one from a parent
                # context
                -Wshadow
                # warn if a class with virtual functions has a non-virtual
                # destructor
                -Wnon-virtual-dtor
                # warn for c-style casts
                -Wold-style-cast
                # warn for potential performance problem casts
                -Wcast-align
                # warn on anything being unused
                -Wunused
                # warn if you overload (not override) a virtual function
                -Woverloaded-virtual
                # warn if non-standard C++ is used
                -Wpedantic
                # warn on type conversions that may lose data
                -Wconversion
                # warn on sign conversions
                -Wsign-conversion
                # warn if a null dereference is detected
                -Wnull-dereference
                # warn if float is implicit promoted to double
                -Wdouble-promotion
                # warn on security issues around functions that format output
                # (ie printf)
                -Wformat=2
        )
    endif ()

    if (
        ${CMAKE_CXX_COMPILER_ID}
        STREQUAL
        "GNU"
    )
        target_compile_options(
            ${target}
            PRIVATE
                # warn if indentation implies blocks where blocks do not exist
                -Wmisleading-indentation
                # warn if if / else chain has duplicated conditions
                -Wduplicated-cond
                # warn if if / else branches have duplicated code
                -Wduplicated-branches
                # warn about logical operations being used where bitwise were
                # probably wanted
                -Wlogical-op
                # warn if you perform a cast to the same type
                -Wuseless-cast
        )
    endif ()

    if (${WARNINGS_AS_ERRORS})
        if (MSVC)
            target_compile_options(${target} PRIVATE /WX)
        else ()
            target_compile_options(${target} PRIVATE -Werror)
        endif ()
    endif ()
endfunction ()
