const express = require('express');
const bodyParser = require('body-parser');
const { createCanvas, loadImage } = require('canvas');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(cors());

// Array of tattoo image URLs
const tattooImages = [
  'https://example.com/tattoo1.png',
  'https://example.com/tattoo2.png',
  // Add more tattoo image URLs here
];

app.post('/generate-image', async (req, res) => {
  const { prompt, isTattooOnBody } = req.body;

  const imageUrls = [];

  // Generate tattoo images based on the prompt
  for (let i = 0; i < 4; i++) {
    // Randomly select a tattoo image URL from the array
    const randomIndex = Math.floor(Math.random() * tattooImages.length);
    const tattooImageUrl = tattooImages[randomIndex];

    // Load the tattoo image
    const tattooImage = await loadImage(tattooImageUrl);

    const canvas = createCanvas(400, 200);
    const ctx = canvas.getContext('2d');

    // Fill canvas with white background
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Draw tattoo image onto the canvas
    ctx.drawImage(tattooImage, 0, 0, canvas.width, canvas.height);

    // Convert canvas to base64 data URL
    const imageData = canvas.toDataURL();
    imageUrls.push(imageData);
  }

  res.status(200).json({ imageUrls });
});

app.get('/generate-image', (req, res) => {
  res.status(405).json({ error: 'Method Not Allowed', message: 'Use POST method to generate images' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
});
