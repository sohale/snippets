import traceback


def debug(param=""):
    """ Usage: call deb() anywhere in the code and it will report when that line it reached. """
    FULL_STACK_REPORT = False

    r=traceback.extract_stack()

    if FULL_STACK_REPORT:
        for i in range(len(r)):
            (filename, line_number, function_name, text) = r[i]
            print(str(i)+": "+repr(r[i]))

    #r[-1]   ('./bucketfs', 44, 'deb', 'r=traceback.extract_stack()')
    #r[-2]  ('./bucketfs', 419, '_full_path', 'deb()')
    #r[-3]  ('./bucketfs', 468, 'getattr', 'full_path = self._full_path(path)')

    text=r[-3][3]
    funcname=r[-2][2]
    line_number=r[-2][1]
    print("%r: %r         %s (%r)"%(line_number,text,funcname, param))
