/*
  Warnings:

  - You are about to drop the column `inputTypeId` on the `dim_field` table. All the data in the column will be lost.
  - You are about to drop the column `departmentId` on the `fct_benefit` table. All the data in the column will be lost.
  - You are about to drop the column `psgcCode` on the `fct_benefit` table. All the data in the column will be lost.
  - You are about to drop the `dim_department` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[fieldHierarchyId,value]` on the table `dim_field_hierarchy_node` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[fieldId,value]` on the table `dim_field_option` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `fieldInputTypeId` to the `dim_field` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "dim_field" DROP CONSTRAINT "dim_field_inputTypeId_fkey";

-- DropForeignKey
ALTER TABLE "dim_user" DROP CONSTRAINT "dim_user_scopeId_fkey";

-- DropForeignKey
ALTER TABLE "fct_benefit" DROP CONSTRAINT "fct_benefit_departmentId_fkey";

-- DropIndex
DROP INDEX "dim_field_hierarchy_node_value_key";

-- DropIndex
DROP INDEX "dim_field_option_value_key";

-- AlterTable
ALTER TABLE "benefit_field_condition" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field" DROP COLUMN "inputTypeId",
ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "fieldInputTypeId" TEXT NOT NULL,
ADD COLUMN     "parentFieldId" TEXT,
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field_condition_operator" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field_hierarchy" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field_hierarchy_level" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field_hierarchy_node" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_field_option" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_input_type" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_scope" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "dim_user" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "groupId" VARCHAR(255),
ADD COLUMN     "psgcCode" VARCHAR(255),
ADD COLUMN     "updatedById" VARCHAR(255),
ALTER COLUMN "passHash" DROP NOT NULL,
ALTER COLUMN "scopeId" DROP NOT NULL;

-- AlterTable
ALTER TABLE "fct_benefit" DROP COLUMN "departmentId",
DROP COLUMN "psgcCode",
ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255),
ADD COLUMN     "version" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "fct_benefit_attachment" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "fct_benefit_requirement" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "fct_benefit_utilization" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "fct_dynamic_field_condition" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- AlterTable
ALTER TABLE "fct_user_field_answer" ADD COLUMN     "createdById" VARCHAR(255),
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" VARCHAR(255);

-- DropTable
DROP TABLE "dim_department";

-- CreateTable
CREATE TABLE "dim_group" (
    "id" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdById" VARCHAR(255),
    "updatedById" VARCHAR(255),
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "dim_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_benefit_group" (
    "id" TEXT NOT NULL,
    "benefitId" TEXT NOT NULL,
    "groupId" TEXT NOT NULL,
    "creator" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdById" VARCHAR(255),
    "updatedById" VARCHAR(255),
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "dim_benefit_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_benefit_psgc_code" (
    "id" TEXT NOT NULL,
    "benefitId" TEXT NOT NULL,
    "scopeId" TEXT NOT NULL,
    "psgcCode" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdById" VARCHAR(255),
    "updatedById" VARCHAR(255),
    "deletedAt" TIMESTAMP(3),

    CONSTRAINT "dim_benefit_psgc_code_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "dim_benefit_group_benefitId_groupId_key" ON "dim_benefit_group"("benefitId", "groupId");

-- CreateIndex
CREATE UNIQUE INDEX "dim_benefit_psgc_code_benefitId_psgcCode_key" ON "dim_benefit_psgc_code"("benefitId", "psgcCode");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_hierarchy_node_fieldHierarchyId_value_key" ON "dim_field_hierarchy_node"("fieldHierarchyId", "value");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_option_fieldId_value_key" ON "dim_field_option"("fieldId", "value");

-- CreateIndex
CREATE INDEX "fct_benefit_deletedAt_idx" ON "fct_benefit"("deletedAt");

-- CreateIndex
CREATE INDEX "fct_benefit_attachment_entityType_entityId_idx" ON "fct_benefit_attachment"("entityType", "entityId");

-- CreateIndex
CREATE INDEX "fct_benefit_requirement_deletedAt_idx" ON "fct_benefit_requirement"("deletedAt");

-- CreateIndex
CREATE INDEX "fct_benefit_utilization_deletedAt_idx" ON "fct_benefit_utilization"("deletedAt");

-- AddForeignKey
ALTER TABLE "dim_user" ADD CONSTRAINT "dim_user_scopeId_fkey" FOREIGN KEY ("scopeId") REFERENCES "dim_scope"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_user" ADD CONSTRAINT "dim_user_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "dim_group"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_user" ADD CONSTRAINT "dim_user_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_user" ADD CONSTRAINT "dim_user_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_scope" ADD CONSTRAINT "dim_scope_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_scope" ADD CONSTRAINT "dim_scope_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_group" ADD CONSTRAINT "dim_group_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_group" ADD CONSTRAINT "dim_group_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit" ADD CONSTRAINT "fct_benefit_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit" ADD CONSTRAINT "fct_benefit_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_group" ADD CONSTRAINT "dim_benefit_group_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "fct_benefit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_group" ADD CONSTRAINT "dim_benefit_group_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "dim_group"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_group" ADD CONSTRAINT "dim_benefit_group_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_group" ADD CONSTRAINT "dim_benefit_group_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_psgc_code" ADD CONSTRAINT "dim_benefit_psgc_code_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "fct_benefit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_psgc_code" ADD CONSTRAINT "dim_benefit_psgc_code_scopeId_fkey" FOREIGN KEY ("scopeId") REFERENCES "dim_scope"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_psgc_code" ADD CONSTRAINT "dim_benefit_psgc_code_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_benefit_psgc_code" ADD CONSTRAINT "dim_benefit_psgc_code_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_requirement" ADD CONSTRAINT "fct_benefit_requirement_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_requirement" ADD CONSTRAINT "fct_benefit_requirement_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_utilization" ADD CONSTRAINT "fct_benefit_utilization_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_utilization" ADD CONSTRAINT "fct_benefit_utilization_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_attachment" ADD CONSTRAINT "fct_benefit_attachment_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_attachment" ADD CONSTRAINT "fct_benefit_attachment_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_field_condition" ADD CONSTRAINT "benefit_field_condition_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_field_condition" ADD CONSTRAINT "benefit_field_condition_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_parentFieldId_fkey" FOREIGN KEY ("parentFieldId") REFERENCES "dim_field"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_fieldInputTypeId_fkey" FOREIGN KEY ("fieldInputTypeId") REFERENCES "dim_input_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_input_type" ADD CONSTRAINT "dim_input_type_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_input_type" ADD CONSTRAINT "dim_input_type_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_option" ADD CONSTRAINT "dim_field_option_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_option" ADD CONSTRAINT "dim_field_option_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy" ADD CONSTRAINT "dim_field_hierarchy_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy" ADD CONSTRAINT "dim_field_hierarchy_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_level" ADD CONSTRAINT "dim_field_hierarchy_level_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_level" ADD CONSTRAINT "dim_field_hierarchy_level_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_node" ADD CONSTRAINT "dim_field_hierarchy_node_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_node" ADD CONSTRAINT "dim_field_hierarchy_node_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_condition_operator" ADD CONSTRAINT "dim_field_condition_operator_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_condition_operator" ADD CONSTRAINT "dim_field_condition_operator_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_user_field_answer" ADD CONSTRAINT "fct_user_field_answer_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_user_field_answer" ADD CONSTRAINT "fct_user_field_answer_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_dynamic_field_condition" ADD CONSTRAINT "fct_dynamic_field_condition_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_dynamic_field_condition" ADD CONSTRAINT "fct_dynamic_field_condition_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "dim_user"("id") ON DELETE SET NULL ON UPDATE CASCADE;
