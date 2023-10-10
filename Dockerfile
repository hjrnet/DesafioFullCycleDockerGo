# Imagem oficial do Go para compilar o código
FROM golang:1.17-alpine AS builder

# Dretório de trabalho
WORKDIR /app

# Copie os arquivos de código para o contêiner
COPY src/ .

# Baixe as dependências (se houver)
RUN go mod download

# Compile o código Go
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Imagem scratch para criar uma imagem mínima
FROM scratch

# Copie o binário compilado do estágio de construção
COPY --from=builder /app/main /main

# Execute o binário
CMD ["/main"]