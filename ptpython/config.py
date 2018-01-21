"""
More config examples in:
    https://github.com/jonathanslenders/ptpython/blob/master/examples/ptpython_config/config.py
"""
from __future__ import unicode_literals

__all__ = (
    'configure',
)


def configure(repl):
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = True

    # Vi mode.
    repl.vi_mode = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Enable auto suggestions.
    # (Pressing right arrow will complete the input based on the history)
    repl.enable_auto_suggest = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True
