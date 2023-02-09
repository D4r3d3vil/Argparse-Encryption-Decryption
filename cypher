import optparse, random


def cypher(msg):
    text = msg
    charstr = text
    fingerprint = []
    chars = []
    encrypted_text = []
    for i in range(len(charstr)):
        if not charstr[i] in chars: 
            chars.append(charstr[i])
    for tr in range(len(chars)):
            rnum = random.random()
            fingerprint.append(rnum)
            fingerprint.append(chars[tr])
    for ind in range(len(text)):
        encrypted_text.append(fingerprint[fingerprint.index(text[ind]) - 1])
    return fingerprint, encrypted_text


def decypher(rsa, encmsg):
    decryption_key = eval(rsa)
    encrypted_text = eval(encmsg)
    decrypted_text = ""
    for i in range(len(encrypted_text)):
        decrypted_text += str(decryption_key[decryption_key.index(encrypted_text[i]) + 1])
    return decrypted_text


parser = optparse.OptionParser()

parser.add_option('-t', '--t',
    action="store", dest="text",
    help="\nuse plain text (must use qoutation marks ('))", default=False)
parser.add_option('-f', '--f',
    action="store", dest="file",
    help="\nget text (or encrypted text when using decypher) from a file", default=False)
parser.add_option('-c', '--c',
    action="store", dest="cypher",
    help="\ncypher (encrypt)", default=False)
parser.add_option('-d', '--d',
    action="store", dest="decypher",
    help="\ndecypher (decrypt)", default=False)
parser.add_option('--wt', '--wt',
    action="store", dest="write",
    help="\nspecify a file name to create that stores encrypted/decrypted (depending on operation) text.", default=False)
parser.add_option('--ft', '--ft',
    action="store", dest="fingerprint",
    help="\nspecify a fingerprint needed to decode the text (must use qoutation marks (')) (if --d parameter is being used).", default=False)
parser.add_option('--ftf', '--ftf',
    action="store", dest="fingerprint_file",
    help="\nspecify a fingerprint needed to decode the text (if --d parameter is being used). Must accept a file which contains fingerprint in the current directory.", default=False)
parser.add_option('--wf', '--wf',
    action="store", dest="wf",
    help="\nspecify a file name to create that stores the fingerprint", default=False)
options, args = parser.parse_args()
if options.decypher and options.cypher:
     print("you cant specify both --t and --f (text, file) you must choose only one")
     exit()
if options.cypher: 
    if options.file: 
            file = open(options.file, "r+")
            msg = file.read()
            file.close()
            i = cypher(msg)
            if not options.wf and not options.write:
                    print("\nfingerprint:\n\n " + str(i[0]) + "\n\n encrypted text:\n\n" + str(i[1]))
            if options.write:
                fp = open(options.write, 'w')
                fp.write(str(i[1]))
                if not options.wf and options.write:
                     print("\nfingerprint:\n\n " + str(i[0]) + "\n\n encrypted text written to: " + options.write)
                else:
                     print("\nencoded text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
            if options.wf:
                 ft = open(options.wf, 'w')
                 ft.write(str(i[0]))
                 if not options.wf and options.write:
                     print("\nencrypted text:\n\n " + str(i[1]) + "\n\n fingerprint written to: " + options.wf)
                 else:
                     print("\nencoded text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
            if not options.write and not options.wf:
                print("\nfingerprint:\n\n " + str(i[0]) + "\nencrypted text:\n\n " + str(i[1]))
    else:
        if options.text:
            i = cypher(options.text)
            if not options.wf and not options.write:
                    print("\nfingerprint:\n\n " + str(i[0]) + "\n\n encrypted text:\n\n" + str(i[1]))
            if options.write:
                fp = open(options.write, 'w')
                fp.write(str(i[1]))
                if not options.wf and options.write:
                     print("\nfingerprint:\n\n " + str(i[0]) + "\n\n encrypted text written to: " + options.write)
                else:
                     print("\nencoded text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
            if options.wf:
                 ft = open(options.wf, 'w')
                 ft.write(str(i[0]))
                 if not options.wf and options.write:
                     print("\nencrypted text:\n\n " + str(i[1]) + "\n\n fingerprint written to: " + options.wf)
                 else:
                     print("\nencoded text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
        else:
            print("you must select text (--t) or a file (--f).")
elif options.decypher:
    if options.fingerprint_file:
                rsafile = open(options.fingerprint_file, "r+")
                rsa = rsafile.read()
                rsafile.close()
    else:
        if options.fingerprint:
            rsa = options.fingerprint
        else:
            print("please specify a fingerprint either using --ftf (for file) or --ft (for text) arguments.")
            exit()
    if options.file: 
            file = open(options.file, "r+")
            msg = file.read()
            file.close()
            i = decypher(rsa,msg)
            if options.write:
                fp = open(options.write, 'w')
                fp.write(i)
                print("decrypted message written to file: " + options.write)
                fp.close()
            else:
                print("\ndecrypted message:\n\n " + i)
    else:
        if options.text:
            i = decypher(rsa,options.text)
            print("\ndecrypted message:\n\n " + i)
        else:
            print("you must select text (--t) or a file (--f).")
            exit()
else:
     print("you must choose an arg. either --d for decypher(decrypt) or --c for cypher(encrypt)")
     exit()