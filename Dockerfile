FROM langchain/langgraph-api:3.11
ADD . /deps/
RUN pip install --no-cache-dir /deps/
ENV LANGGRAPH_DEPS=/deps
