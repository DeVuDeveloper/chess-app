import { Controller } from "@hotwired/stimulus";
import { Wave } from "@foobar404/wave";

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);

    // Get all the audio elements and wave canvas elements
    const waveAudios = document.querySelectorAll("[data-controller='wave']");
    const waveCanvases = document.querySelectorAll("[id^='wave_canvas_']");


    waveAudios.forEach((waveAudio, index) => {
      const waveCanvas = waveCanvases[index];
      const wave = new Wave(waveAudio, waveCanvas);
      const preset = 3;

      if (preset == 0) {
        wave?.addAnimation(
          new wave.animations.Wave({
            lineColor: "white",
            lineWidth: 10,
            fillColor: { gradient: ["#FF9A8B", "#FF6A88", "#FF99AC"] },
            mirroredX: true,
            count: 5,
            rounded: true,
            frequencyBand: "base",
          })
        );
        wave?.addAnimation(
          new wave.animations.Wave({
            lineColor: "white",
            lineWidth: 10,
            fillColor: { gradient: ["#FA8BFF", "#2BD2FF", "#2BFF88"] },
            mirroredX: true,
            count: 60,
            rounded: true,
          })
        );
        wave?.addAnimation(
          new wave.animations.Wave({
            lineColor: "white",
            lineWidth: 10,
            fillColor: { gradient: ["#FBDA61", "#FF5ACD"] },
            mirroredX: true,
            count: 25,
            rounded: true,
            frequencyBand: "highs",
          })
        );
      }
      if (preset == 1) {
        wave?.addAnimation(
          new wave.animations.Cubes({
            bottom: true,
            count: 60,
            cubeHeight: 5,
            fillColor: { gradient: ["#FAD961", "#F76B1C"] },
            lineColor: "rgba(0,0,0,0)",
            radius: 10,
          })
        );
        wave?.addAnimation(
          new wave.animations.Cubes({
            top: true,
            count: 60,
            cubeHeight: 5,
            fillColor: { gradient: ["#FAD961", "#F76B1C"] },
            lineColor: "rgba(0,0,0,0)",
            radius: 10,
          })
        );
        wave?.addAnimation(
          new wave.animations.Circles({
            lineColor: {
              gradient: ["#FAD961", "#FAD961", "#F76B1C"],
              rotate: 90,
            },
            lineWidth: 4,
            diameter: 20,
            count: 10,
            frequencyBand: "base",
          })
        );
      }
      if (preset == 2) {
        wave?.addAnimation(
          new wave.animations.Glob({
            fillColor: {
              gradient: ["#FAD961", "#FAD961", "#F76B1C"],
              rotate: 45,
            },
            lineColor: "white",
            glow: { strength: 15, color: "#FAD961" },
            lineWidth: 10,
            count: 45,
          })
        );
        wave?.addAnimation(
          new wave.animations.Shine({
            lineColor: "#FAD961",
            glow: { strength: 15, color: "#FAD961" },
            diameter: 300,
            lineWidth: 10,
          })
        );
      }
      if (preset == 3) {
        wave?.addAnimation(
          new wave.animations.Square({
            lineColor: { gradient: ["#21D4FD", "#B721FF"] },
          })
        );
        wave?.addAnimation(
          new wave.animations.Arcs({
            lineWidth: 4,
            lineColor: { gradient: ["#21D4FD", "#B721FF"] },
            diameter: 500,
            fillColor: {
              gradient: ["#21D4FD", "#21D4FD", "#B721FF"],
              rotate: 45,
            },
          })
        );
      }
    });
  }
}
