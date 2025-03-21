# Образ для контейнера
FROM python:3

# Рабочая директория 
WORKDIR /usr/src

# Копирование файла внутрь контейнера
COPY requirements.txt ./

# Устанавливаем нужные библиотеки из файла
RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python" ]

