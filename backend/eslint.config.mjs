import globals from 'globals';
import stylisticTs from '@stylistic/eslint-plugin-ts'
import tseslint from 'typescript-eslint';


/** @type {import('eslint').Linter.Config[]} */
export default [
  {files: ['**/*.{js,mjs,cjs,ts}']},
  {ignores: ['src/sequelize/*.ts']},
  {languageOptions: { globals: globals.node }},
  {plugins: {
    '@stylistic/ts': stylisticTs
  }},
  {rules: {
    // Relaxed rules for development
    '@stylistic/ts/quotes': 'off',
    '@typescript-eslint/no-explicit-any': 'off',
    '@typescript-eslint/no-unused-vars': 'off',
    '@typescript-eslint/no-unused-expressions': 'off',
    '@typescript-eslint/ban-ts-comment': 'off',
    '@typescript-eslint/no-require-imports': 'off',
  }},
  ...tseslint.configs.recommended,
];