# sed

## uncomment lines

`sed -E '/ swap /s/#+(.*)$/\1/g' /etc/fstab`

```/etc/fstab
/dev/mapper/rhel-home   /home                   xfs     defaults        0 0
#/dev/mapper/rhel-swap   none                    swap    defaults        0 0

to:

/dev/mapper/rhel-home   /home                   xfs     defaults        0 0
/dev/mapper/rhel-swap   none                    swap    defaults        0 0
```

substitute first line in file (requires GNU sed)

`for i in $( ls * ); do sed -i '1 s/^/This is my first line\n/' $i; done`

`sed -n` suppress output
`sed 's/test/test/p'` -p prints the patterns that match, can be combined with -n

# subsitute in different files recursively using ripgrep (rg)

rg 'mypattern' -l | xargs sed -i 's/thispattern/newpattern/g'

1. **Basic Text Replacement:**

   ```shell
   sed 's/old_pattern/new_pattern/g'
   ```

   This replaces all occurrences of `old_pattern` with `new_pattern` in the input text.

2. **Deleting Lines:**

   ```shell
   sed '/pattern/d'
   ```

   This deletes all lines that match the given `pattern`.

3. **Printing Lines:**

   ```shell
   sed -n '5,10p'
   ```

   This prints lines from 5 to 10 (inclusive) of the input.

4. **Numbering Lines:**

   ```shell
   sed = filename | sed 'N;s/\\n/ /'
   ```

   This numbers each line of the input.

5. **Replacing Delimiters:**

   ```shell
   sed 's|old_path|new_path|g'
   ```

   You can use different delimiters (e.g., `|`, `#`, etc.) to avoid escaping slashes in paths.

6. **Using Variables:**

   ```shell
   var="new_text"
   echo "old_text" | sed "s/old/$var/"
   ```

   You can use variables in your `sed` commands.

7. **In-Place Editing:**

   ```shell
   sed -i 's/pattern/replacement/g' filename
   ```

   Edit the file in place, replacing `pattern` with `replacement`.

8. **Using Capture Groups:**

   ```shell
   echo "Name: John" | sed 's/Name: \\(.*\\)/\\1 is my name/'
   ```

   Capture groups allow you to reference matched content in the replacement.

9. **Multiple Operations:**

   ```shell
   sed -e 's/pattern1/replacement1/g' -e 's/pattern2/replacement2/g' filename
   ```

   You can apply multiple `sed` commands sequentially.

10. **Conditional Replacements:**

    ```shell
    sed '/pattern/s/find/replace/' filename
    ```

    This only replaces `find` with `replace` in lines containing `pattern`.

11. **Appending and Inserting Lines:**

    ```shell
    sed '/pattern/a\\This is an appended line' filename
    sed '/pattern/i\\This is an inserted line' filename
    ```

    Append or insert lines after or before a pattern match.

12. **Using Extended Regular Expressions:**
    ```shell
    sed -E 's/pattern/replacement/g' filename
    ```
    `-E` enables extended regular expressions (more powerful patterns).

Remember that `sed` uses regular expressions, so mastering regex will greatly
enhance your `sed` skills. Also, always be careful when using `-i` (in-place
editing) as it directly modifies files.
