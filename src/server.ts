import express from "express";
import adsRoutes from "./routes/ads.routes";
import gamesRoutes from "./routes/games.routes";

const app = express();

// HTTO methods / API RESTful

// GET / POST / PUT / PATCH / DELETE

app.use(adsRoutes);
app.use(gamesRoutes);

app.listen(3333);
