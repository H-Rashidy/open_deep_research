   FROM langchain/langgraph-api:3.11
   ADD . /deps
   ENV LANGGRAPH_DEPS=/deps
