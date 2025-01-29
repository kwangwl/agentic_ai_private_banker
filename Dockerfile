FROM python:3.9-slim

ARG BWB_FLOW_ID
ARG BWB_FLOW_ALIAS_ID
ARG BWB_BEDROCK_REGION_NAME

ENV BWB_FLOW_ID=$BWB_FLOW_ID
ENV BWB_FLOW_ALIAS_ID=$BWB_FLOW_ALIAS_ID
ENV BWB_BEDROCK_REGION_NAME=$BWB_BEDROCK_REGION_NAME

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY *.py .
COPY static ./static

EXPOSE 80

HEALTHCHECK CMD curl --fail http://localhost/_stcore/health || exit 1

ENTRYPOINT [ "streamlit", "run", "ai_pb_app.py", \
             "--logger.level", "info", \
             "--browser.gatherUsageStats", "false", \
             "--browser.serverAddress", "0.0.0.0", \
             "--server.enableCORS", "false", \
             "--server.enableXsrfProtection", "false", \
             "--server.baseUrlPath", "/agentic-ai-pb", \
             "--server.port", "80"]
