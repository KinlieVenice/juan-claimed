-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('SUPERADMIN', 'AGENT', 'USER');

-- CreateEnum
CREATE TYPE "FieldClassification" AS ENUM ('GLOBAL', 'FOLLOW_UP');

-- CreateTable
CREATE TABLE "dim_user" (
    "id" TEXT NOT NULL,
    "username" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "firstName" VARCHAR(255) NOT NULL,
    "middleName" VARCHAR(255),
    "lastName" VARCHAR(255) NOT NULL,
    "passHash" VARCHAR(255) NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'USER',
    "scopeId" TEXT NOT NULL,
    "googleId" VARCHAR(255),
    "avatarUrl" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_scope" (
    "id" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_scope_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_department" (
    "id" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_department_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field" (
    "id" TEXT NOT NULL,
    "key" VARCHAR(255) NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "inputTypeId" TEXT NOT NULL,
    "fieldHierarchyId" TEXT NOT NULL,
    "required" BOOLEAN NOT NULL DEFAULT true,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "configJson" JSONB,
    "classfication" "FieldClassification" NOT NULL DEFAULT 'FOLLOW_UP',
    "default" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_input_type" (
    "id" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_input_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field_option" (
    "id" TEXT NOT NULL,
    "fieldId" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field_hierarchy" (
    "id" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_hierarchy_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field_hierarchy_level" (
    "id" TEXT NOT NULL,
    "fieldHierarchyId" TEXT NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 1,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_hierarchy_level_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field_hierarchy_node" (
    "id" TEXT NOT NULL,
    "fieldHierarchyId" TEXT NOT NULL,
    "parentNodeId" TEXT,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_hierarchy_node_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dim_field_condition_operator" (
    "id" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "value" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dim_field_condition_operator_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_benefit" (
    "id" TEXT NOT NULL,
    "departmentId" TEXT NOT NULL,
    "scopeId" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "psgcCode" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_benefit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "benefit_field_condition" (
    "id" TEXT NOT NULL,
    "benefitId" TEXT NOT NULL,
    "benefitFieldConditionId" TEXT NOT NULL,
    "fieldConditionOperatorId" TEXT NOT NULL,
    "conditionFieldValue" JSON NOT NULL,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "benefit_field_condition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_benefit_requirement" (
    "id" TEXT NOT NULL,
    "benefitId" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_benefit_requirement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_benefit_utilization" (
    "id" TEXT NOT NULL,
    "benefitId" TEXT NOT NULL,
    "englishName" VARCHAR(255) NOT NULL,
    "tagalogName" VARCHAR(255) NOT NULL,
    "englishDescription" TEXT NOT NULL,
    "tagalogDescription" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_benefit_utilization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_benefit_attachment" (
    "id" TEXT NOT NULL,
    "fileLabel" VARCHAR(255) NOT NULL,
    "fileName" VARCHAR(255) NOT NULL,
    "fileType" VARCHAR(255) NOT NULL,
    "filePath" VARCHAR(255) NOT NULL,
    "fileSize" BIGINT NOT NULL,
    "entityId" VARCHAR(255) NOT NULL,
    "entityType" VARCHAR(255) NOT NULL,
    "metaData" JSON NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_benefit_attachment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_user_field_answer" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "fieldId" TEXT NOT NULL,
    "field_value" VARCHAR(255),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_user_field_answer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fct_dynamic_field_condition" (
    "id" TEXT NOT NULL,
    "fieldId" TEXT NOT NULL,
    "fieldConditionOperatorId" TEXT NOT NULL,
    "fieldConditionId" TEXT,
    "conditionFieldValue" JSON NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "fct_dynamic_field_condition_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "dim_user_username_key" ON "dim_user"("username");

-- CreateIndex
CREATE UNIQUE INDEX "dim_user_email_key" ON "dim_user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "dim_scope_value_key" ON "dim_scope"("value");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_key_key" ON "dim_field"("key");

-- CreateIndex
CREATE UNIQUE INDEX "dim_input_type_value_key" ON "dim_input_type"("value");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_option_value_key" ON "dim_field_option"("value");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_hierarchy_node_value_key" ON "dim_field_hierarchy_node"("value");

-- CreateIndex
CREATE UNIQUE INDEX "dim_field_condition_operator_value_key" ON "dim_field_condition_operator"("value");

-- AddForeignKey
ALTER TABLE "dim_user" ADD CONSTRAINT "dim_user_scopeId_fkey" FOREIGN KEY ("scopeId") REFERENCES "dim_scope"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_inputTypeId_fkey" FOREIGN KEY ("inputTypeId") REFERENCES "dim_input_type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field" ADD CONSTRAINT "dim_field_fieldHierarchyId_fkey" FOREIGN KEY ("fieldHierarchyId") REFERENCES "dim_field_hierarchy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_option" ADD CONSTRAINT "dim_field_option_fieldId_fkey" FOREIGN KEY ("fieldId") REFERENCES "dim_field"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_level" ADD CONSTRAINT "dim_field_hierarchy_level_fieldHierarchyId_fkey" FOREIGN KEY ("fieldHierarchyId") REFERENCES "dim_field_hierarchy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_node" ADD CONSTRAINT "dim_field_hierarchy_node_fieldHierarchyId_fkey" FOREIGN KEY ("fieldHierarchyId") REFERENCES "dim_field_hierarchy"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dim_field_hierarchy_node" ADD CONSTRAINT "dim_field_hierarchy_node_parentNodeId_fkey" FOREIGN KEY ("parentNodeId") REFERENCES "dim_field_hierarchy_node"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit" ADD CONSTRAINT "fct_benefit_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "dim_department"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit" ADD CONSTRAINT "fct_benefit_scopeId_fkey" FOREIGN KEY ("scopeId") REFERENCES "dim_scope"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_field_condition" ADD CONSTRAINT "benefit_field_condition_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "fct_benefit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_field_condition" ADD CONSTRAINT "benefit_field_condition_benefitFieldConditionId_fkey" FOREIGN KEY ("benefitFieldConditionId") REFERENCES "fct_dynamic_field_condition"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_field_condition" ADD CONSTRAINT "benefit_field_condition_fieldConditionOperatorId_fkey" FOREIGN KEY ("fieldConditionOperatorId") REFERENCES "dim_field_condition_operator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_requirement" ADD CONSTRAINT "fct_benefit_requirement_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "fct_benefit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_benefit_utilization" ADD CONSTRAINT "fct_benefit_utilization_benefitId_fkey" FOREIGN KEY ("benefitId") REFERENCES "fct_benefit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_user_field_answer" ADD CONSTRAINT "fct_user_field_answer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "dim_user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_user_field_answer" ADD CONSTRAINT "fct_user_field_answer_fieldId_fkey" FOREIGN KEY ("fieldId") REFERENCES "dim_field"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_dynamic_field_condition" ADD CONSTRAINT "fct_dynamic_field_condition_fieldId_fkey" FOREIGN KEY ("fieldId") REFERENCES "dim_field"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_dynamic_field_condition" ADD CONSTRAINT "fct_dynamic_field_condition_fieldConditionOperatorId_fkey" FOREIGN KEY ("fieldConditionOperatorId") REFERENCES "dim_field_condition_operator"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "fct_dynamic_field_condition" ADD CONSTRAINT "fct_dynamic_field_condition_fieldConditionId_fkey" FOREIGN KEY ("fieldConditionId") REFERENCES "benefit_field_condition"("id") ON DELETE SET NULL ON UPDATE CASCADE;
