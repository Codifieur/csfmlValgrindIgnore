##
## Codifieur PROJECT, 2019
## csfmlValgrindIgnore
## File description:
## Ignore valgrind error of sfml
##

require 'io/console'

class ValgrindIgnore

    def initialize()
        @toIgnoreContent = [
            ["at", "???"],
            ["by", "???"],
            ["by", "sf::"],
        ]
    end

    def Execute()
        Compute()
    end

    def isEmptyLine(line)
        tmp = line.dup
        tmp.gsub!(/(\n|\t|\s)/, "")
        if (/==\w+==$/.match(tmp))
            return true
        end
        return false
    end

    def isThereUnknownAddressLine(lines, i)
        validated = true
        while (lines[i] && !isEmptyLine(lines[i]))
            @toIgnoreContent.each { |x| 
                x.each { |e| validated = false if (!lines[i].include?(e))}
                if (validated == true) then return true else validated = true end
            }
            i += 1
        end
        return false
    end

    def getClearInput()
        inp = STDIN.read
        inp.gsub!(/\r\n?/, "\n")
        inp = inp.split("\n")
        return inp
    end

    def Compute()   
        inp = getClearInput
        i = 0
        passed = false

        while (inp[i])
            if (isEmptyLine(inp[i]))
                if (isThereUnknownAddressLine(inp, i + 1))
                    i += 1
                    passed = true
                    i += 1 while (!isEmptyLine(inp[i]))
                end
            end
            if (!passed)
                puts inp[i]
                i += 1
            end
            passed = false
        end
    end

end