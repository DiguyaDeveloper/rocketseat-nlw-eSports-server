/**
 * Convert string hours (18:00) in minutes
 *
 * @param hourString
 * @returns minutesAmount: number
 */

export function convertHourStringToMinutes(hourString: string): number {
  if (!hourString) {
    return 0;
  }

  console.log("alo", hourString);

  const [hours, minutes] = hourString.split(":").map(Number);

  const minutesAmount = hours * 60 + minutes;

  return minutesAmount;
}
