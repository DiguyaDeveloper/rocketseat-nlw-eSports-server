import express from "express";
import adsRoutes from "./routes/ads.routes";
import gamesRoutes from "./routes/games.routes";
import weekDaysRoutes from "./routes/weekDays.routes";
import cors from "cors";

const app = express();
app.use(express.json());
app.use(cors());

app.use(adsRoutes);
app.use(gamesRoutes);
app.use(weekDaysRoutes);

app.listen(3333);
