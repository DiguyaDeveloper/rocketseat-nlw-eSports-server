/**
 * Convert hours string (18:20) in minutes (1100)
 *
 * @param hourString: string
 * @returns minutesAmount: number
 */

export function convertHourStringToMinutes(hourString: string): number {
  if (!hourString) {
    return 0;
  }

  const [hours, minutes] = hourString.split(":").map(Number);

  const minutesAmount = hours * 60 + minutes;

  return minutesAmount;
}
