// The 5 people who actually built JuanClaimed. Their real Google accounts double as the
// demo persona test accounts seeded by demoPersonaFactory.ts (e.g. aquinojhorizrodel@gmail.com
// is both "demo_student_jhoriz" and a real teammate) — this list exists purely for admin-side
// attribution (a "Creator" badge in the Users table), not a role, permission, or scope grant.
const CREATOR_EMAILS = new Set([
  "aquinojhorizrodel@gmail.com",
  "jeanne.guzon@gmail.com",
  "alexieleanne@gmail.com",
  "kinlievenicedeguzman@gmail.com",
  "janvincentvallente@gmail.com",
]);

export function isTeamCreator(email: string): boolean {
  return CREATOR_EMAILS.has(email.toLowerCase());
}
