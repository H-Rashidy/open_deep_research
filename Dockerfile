FROM langchain/langgraph-api:3.11
ADD . /deps/
ENV LANGGRAPH_DEPS=/deps
ENV LANGSERVE_GRAPHS='{"agent":"/deps/app/src/deep_agent.py:graph","open_deep_research":"/deps/app/src/open_deep_research/deep_researcher.py:graph"}'
