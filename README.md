# Prolog Intelligent Tutoring Systems
Web application in SWI Prolog for back-end and Semantic-UI CSS framework for front-end.

![screenshot 2](https://cloud.githubusercontent.com/assets/7612837/26174273/71599934-3b57-11e7-8ad0-2b08a0f1b38e.png)
You can visit the application at [prolog.kantas.net](http://prolog.kantas.net)

Look at `checkUserPwd` predicate at `Prolog.pl` file for some valid username-password combinations

## Run
Download and install [SWI prolog](http://www.swi-prolog.org/download/stable)

- Run the `Prolog.pl` file witch is the entry point of the web application

- Query `server(80).` on SWI Prolog Terminal

- Open a browser and type `localhost`

## Info

Front end is build with [Semantic UI](https://semantic-ui.com/)

The application uses the template engine [Simple-template by Raivo Laanemets](https://github.com/rla/simple-template)

The predicates have strange names (and different from handlers ) to keep reference from an older version on application witch used that names

## Authors

Developed by **Alexandros Kantas** and **Afroditi Stathaki**

Everything in front-end: HTML files, CSS classes, Javascript functions and some back-end operations: use of Simple-template and Sessions are developed by Alexandros Kantas

Flowchart of application, texts and all core back-end predicates are developed by Afroditi Stathaki
