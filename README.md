- THIS SCRIPT IS CURRENTLY A WORK-IN-PROGRESS
- CERTAIN FUNCTIONALITY & FEATURES MAY BE LACKING
- AT THIS POINT OF DEVELOPMENT, WINDA UTILIZES ROBOCOPY TO MIGRATE DESKTOP, DOWNLOADS, DOCUMENTS, PICTURES, AND  DEFAULT  PROFILE BOOKMARKS (MIGRATING EXTRA PROFILE BOOKMARKS IS A FEATURE CURRENTLY BEING IMPLEMENTED)
- ALWAYS RUN THIS SCRIPT ON THE OLD WORKSTATION!!!

  1. Run the script as a NETWORK Administrator (REQUIRED TO CONNECT TO COMPUTERS OVER THE NETWORK IF USING REMOTE TRANSFER SCRIPT, **LOCAL ADMIN WILL NOT WORK FOR REMOTE TRANSFER SCRIPT**)
  2. The first prompt will require the user's RACFID, please double check the RACFID with the user to avoid the script creating another target directory in the C:/Users directory!
  3. The second prompt will require the IP address of the ***NEW*** asset, please double check the IP address or ROBOCOPY WILL fail!!!
  4. IF using the external drive version of the script, please identify the CORRECT driver letter, type in ONLY the letter WITHOUT colons or backslashes!

- ROBOCOPY WILL RUN AT THIS POINT USING THE values **PROVIDED BY THE SCRIPT USER IN USER PROMPTS**
- A popup will appear for a brief moment explicitly stating that data migration has been completed!
