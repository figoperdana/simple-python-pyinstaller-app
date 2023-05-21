FROM python:2-alpine
COPY add2vals /sources/add2vals
CMD ["python", "/sources/add2vals"]
