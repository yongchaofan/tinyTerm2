HEADERS = src/table.h src/Fl_Term.h src/ssh_Host.h src/ietf.h
OBJS =	obj/flTable.o obj/table.o obj/Fl_Term.o obj/ssh_Host.o obj/ietf.o obj/finity.o obj/sqlite3.o obj/tinyxml2.o
LIBS =  /usr/local/lib/libssh2.a -L/usr/local/lib
INCLUDE = -I.

CFLAGS= -Os ${shell fltk-config --cxxflags}
LDFLAGS = ${shell fltk-config --ldstaticflags} -lc++ -lz -lssl -lcrypto

all: flTable flTerm

flTable: ${OBJS} 
	cc -o "$@" ${OBJS} ${LIBS} ${LDFLAGS}
flTerm: obj/flTerm.o obj/Fl_Term.o obj/ssh_Host.o  
	cc -o "$@" obj/flTerm.o obj/Fl_Term.o obj/ssh_Host.o ${LIBS} ${LDFLAGS}

obj/tinyxml2.o: tinyxml2.cpp
	${CC} ${CFLAGS} ${INCLUDE} -c $< -o $@

obj/sqlite3.o: sqlite3.c
	${CC} ${CFLAGS} ${INCLUDE} -DSQLITE_OMIT_DECLTYPE -DSQLITE_OMIT_DEPRECATED -DSQLITE_OMIT_PROGRESS_CALLBACK -DSQLITE_OMIT_SHARED_CACHE -c $< -o $@

obj/%.o: src/%.cxx ${HEADERS}
	${CC} ${CFLAGS} ${INCLUDE} -c $< -o $@

clean:
	rm obj/*.o "flTable" "flTerm"
