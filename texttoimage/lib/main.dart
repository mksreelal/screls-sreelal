import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenHome(),
    );
  }
}

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  fetch()
{
final url ="https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image";

}
}


import fs from "fs";

export const textToImage = async () => {
  const path =
    "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image";

  const headers = {
    Accept: "application/json",
    Authorization: "Bearer YOUR_API_KEY"
  };

  const body = {
    steps: 40,
	width: 1024,
	height: 1024,
	seed: 0,
	cfg_scale: 5,
	samples: 1,
	text_prompts: [
	  {
	    "text": "A painting of a cat",
	    "weight": 1
	  },
	  {
	    "text": "blurry, bad",
	    "weight": -1
	  }
	],
  };

  const response = fetch(
    path,
    {
      headers,
      method: "POST",
      body: JSON.stringify(body),
    }
  );
  
  if (!response.ok) {
    throw new Error(`Non-200 response: ${await response.text()}`)
  }
  
  const responseJSON = await response.json();
  
  responseJSON.artifacts.forEach((image, index) => {
    fs.writeFileSync(
      `./out/txt2img_${image.seed}.png`,
      Buffer.from(image.base64, 'base64')
    )
  })
};