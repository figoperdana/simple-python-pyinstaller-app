FROM python:2-alpine
COPY sources/dist/add2vals /app/add2vals
CMD ["python", "/app/add2vals"]