FROM swipl
COPY . /
CMD ["swipl", "/Prolog.pl"]
EXPOSE 80