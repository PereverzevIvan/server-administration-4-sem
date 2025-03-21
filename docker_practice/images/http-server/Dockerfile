# Образ для контейнера
FROM python:3

# Рабочая директория 
WORKDIR /usr/src/app

# Копирование файла внутрь контейнера
COPY requirements.txt ./

# Устанавливаем нужные библиотеки из файла
RUN pip install --no-cache-dir -r requirements.txt

COPY app .

CMD [ "python", "./script.py" ]

