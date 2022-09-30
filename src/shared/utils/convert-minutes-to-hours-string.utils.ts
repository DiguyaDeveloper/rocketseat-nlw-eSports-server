/**
 * Convert minutes (1100) in hours string (18:20)
 *
 * @param minutesAmount: number
 * @returns 18:00: string
 */

export function convertMinutesToHourString(minutesAmount: number): string {
  const hours = getHours(minutesAmount);
  const minutes = getMinutes(hours);

  return `${padZeroStart(hours)}:${padZeroStart(minutes)}`;
}

function getHours(minutesAmount: number): number {
  return Math.floor(minutesAmount / 60);
}
function getMinutes(minutesAmount: number): number {
  return minutesAmount % 60;
}
function padZeroStart(value: number): string {
  return String(value).padStart(2, "0");
}
