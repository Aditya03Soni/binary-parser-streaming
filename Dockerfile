FROM public.ecr.aws/d3j8x8q7/olympus-base:latest
WORKDIR /app
COPY . .
RUN npm ci --include=dev --ignore-scripts
CMD ["/bin/bash"]
