/*
  Warnings:

  - Added the required column `fieldInputTypeId` to the `dim_field_condition_operator` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "dim_field_condition_operator" ADD COLUMN     "fieldInputTypeId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "dim_field_condition_operator" ADD CONSTRAINT "dim_field_condition_operator_fieldInputTypeId_fkey" FOREIGN KEY ("fieldInputTypeId") REFERENCES "dim_input_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
