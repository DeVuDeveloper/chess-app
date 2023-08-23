# OpenAI Chess Chat and Image Generation App - README

## Screenshots

<div style="display: flex; justify-content: space-between;">
  <img src="app/assets/images/chess1.png" alt="chess 1" width="50%">
  <img src="app/assets/images/screen2.png" alt="chess 3" width="50%">
</div>

## Introduction

Welcome to the OpenAI Chess Chat and Image Generation App. This open-source application, a condensed version of the original, is designed to facilitate chat interactions with the OpenAI GPT-3.5 Turbo model and create images based on textual descriptions. The full application was initially developed for a US-based client, offering additional functionalities like game analysis and AI-powered camera input. However, this abbreviated version focuses on the chat and image generation capabilities.

Please note that the complete codebase, including features such as game analysis and camera input, is not publicly available in this repository. The purpose of this release is to provide insight into the OpenAI integration and image creation components.

## Features

- **Chat with OpenAI**: Engage in conversations with the OpenAI GPT-3.5 Turbo model regarding chess-related topics, strategies, and inquiries.

- **Image Generation**: Create visual representations of chess positions using text-based commands and the OpenAI model's assistance.

## Getting Started

1. Clone or download this repository.

2. Install frontend dependencies using `yarn install`.

3. Install backend dependencies using `bundle install`.

4. Run the Sidekiq background job processor using `bundle exec sidekiq`.

5. Set up your OpenAI API keys in the appropriate configuration file. You can obtain API keys for **ChatGPT 3.5 Turbo** or, if you have access, for **ChatGPT 4** by visiting [OpenAI API Keys](https://platform.openai.com/account/api-keys).

6. Start the Rails server using `rails server`.

7. Access the application through your web browser at `http://localhost:3000`.


## Contact

If you have questions or need further information about this project, please contact us at contact@example.com.

---

Thank you for exploring the OpenAI Chess Chat and Image Generation App! We hope that this simplified version provides you with insights into utilizing OpenAI's capabilities for chat interactions and image creation.

