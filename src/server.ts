import express from "express";
import adsRoutes from "./routes/ads.routes";
import gamesRoutes from "./routes/games.routes";
import weekDaysRoutes from "./routes/weekDays.routes";

const app = express();
app.use(express.json());
// HTTO methods / API RESTful

// GET / POST / PUT / PATCH / DELETE

app.use(adsRoutes);
app.use(gamesRoutes);
app.use(weekDaysRoutes);

app.listen(3333);
