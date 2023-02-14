import optparse, random
def cypher(msg):
    text = ''.join(random.sample(msg,len(msg)))
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
    help="use plain text", default=False)
parser.add_option('-f', '--f',
    action="store", dest="file",
    help="get text (or encrypted text when using decypher) from a file", default=False)
parser.add_option('-c', '--c',
    action="store", dest="cypher",
    help="cypher (encrypt)", default=False)
parser.add_option('-d', '--d',
    action="store", dest="decypher",
    help="decypher (decrypt)", default=False)
parser.add_option('--wt', '--wt',
    action="store", dest="write",
    help="specify a file name to create that stores encode/decrypted (depending on operation) text.", default=False)
parser.add_option('--ft', '--ft',
    action="store", dest="fingerprint",
    help="specify a fingerprint needed to decode the text (if --d parameter is being used).", default=False)
parser.add_option('--ftf', '--ftf',
    action="store", dest="fingerprint_file",
    help="specify a fingerprint needed to decode the text (if --d parameter is being used). Must accept a file which contains fingerprint in the current directory.", default=False)
parser.add_option('--wf', '--wf',
    action="store", dest="wf",
    help="specify a file name to create that stores the fingerprint", default=False)
options, args = parser.parse_args()
if options.decypher and options.cypher:
     print("you cant specify both --t and --f (text, file) you must choose only one")
     exit()
#options.write is specified by the parameter --wt, options.fingerprint_file: --ftf, options.fingerprint: --ft
if options.write != False:
    if options.write == options.wf:
        print("\nincorrect usage: \n\n--wf and --wt cannot have the same value\n")
        print("--wf tells the program to store the fingerprint in a file\n--wt tells the program to store encrypted text in a file\n\nif both arguments have the same value the program will first write the text to the specified file, then override the file text with the fingerprint since both have the same name.\n")
        exit()
if options.file and options.text:
     print("incorrect usage: \n\n--f and --t cannot be used together.\n")
     print("\n--f tells the program to get text from a file\n--t tells the program the text will be user specified.\n")
     exit()
if options.fingerprint_file and options.fingerprint and options.decypher:
      print("incorrect usage: \n\n--ftf and --ft cannot be used together.\n")
      print("\n--ftf tells the program to get fingerprint from a file\n--ft tells the program the fingerprint will be user specified.\n")
      exit()
if options.cypher: 
    if options.file: 
            file = open(options.file, "r+")
            msg = file.read()
            file.close()
            i = cypher(msg)
            if options.write:
                fp = open(options.write, 'w')
                fp.write(str(i[1]))
            if options.wf:
                 ft = open(options.wf, 'w')
                 ft.write(str(i[0]))
            if options.write and options.wf:
                print("\nencrypted text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
            else: 
                if not options.write and not options.wf:
                    print("\nfingerprint:\n\n " + str(i[0]) + "\nencrypted text:\n\n " + str(i[1]))
                else:
                    if options.write and not options.wf:
                            print("\nfingerprint:\n\n " + str(i[0]) + "\n\necrypted text written to: " + options.write)
                    else:
                            print("\nencrypted text:\n\n " + str(i[1]) + "\n\nfingerprint written to: " + options.wf)
    else:
        if options.text:
            i = cypher(options.text)
            if options.write:
                fp = open(options.write, 'w')
                fp.write(str(i[1]))
            if options.wf:
                 ft = open(options.wf, 'w')
                 ft.write(str(i[0]))
            if not options.write and not options.wf:
                print("\nfingerprint:\n\n " + str(i[0]) + "\nencrypted text:\n\n " + str(i[1]))
            else:
                if options.write and options.wf:
                        print("\nencrypted text written to file: " + options.write + "\n\nfingerprint written to: " + options.wf)
                else:
                        if options.wf:
                            print("\nencrypted text:\n\n " + str(i[1]) + "\n\nfingerprint written to: " + options.wf)
                        else:
                            print("\nfingerprint:\n\n " + str(i[0]) + "\n\nencypted text written to: " + options.write)
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
                print("decrypted text written to file: " + options.write)
                fp.close()
            else:
                print("decrypted text:\n " + i)
    else:
        if options.text:
            i = decypher(rsa,options.text)
            if options.write:
                fp = open(options.write, 'w')
                fp.write(i)
                print("decrypted text written to file: " + options.write)
                fp.close()
            else:
                print("decrypted text:\n " + i)
        else:
            print("you must select text (--t) or a file (--f).")
            exit()
else:
     print("you must choose an arg. either --d for decypher(decrypt) or --c for cypher(encrypt)")
     exit()
