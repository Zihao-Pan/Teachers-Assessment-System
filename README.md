## Teachers-Assessment-System
### 1. Introduction

&emsp;&emsp; As we known, plenty of schools build a questionnaire research within teachers, which will waste a mass of time and resource at the end of term. In the research, every teacher needs to write down appropriate scores to assess other teachers' normal performance. Besides, the management section has to spend their energy in collection these grades and summarize into a report for the principal. Therefore, in my opinion, there are lots of shortages in an original way.

&emsp;&emsp; With this purpose, I build "Teacher Assessment System". In the project, I create three files, one named "data.csv" contains the information of payroll teachers, and the remaining two are R executable files.

### 2. "data.csv" file

&emsp;&emsp; The first column is teachers' grades, if you teach in grade one, then your grade is 1 and so on. The second column is teachers' names, which is the most improtant factor that I can't forget. In addition to these two columns, you can delete all data appearing in the csv file.  The third column means I imitate a teacher ,called B2, who teaches in grade 2, so I can only assess teachers who are also teach in grade 2.

### 3. "testPaper.R" file

&emsp;&emsp; This file replace the real questionnaire paper, you should write down your name and grade in which you teach. Only if your name and grade are both correct, the scoring function will be activated. And what you write will save in the "data.csv" file.

### 4. "analyse.R" file

&emsp;&emsp; This file plays a role of analysing grades automatically. Until now , I just have designed three tabs, one is the summary chart which reports the average scores between grades, and the other two charts, which can be changed in the left panel, are more detail within one grade. I wish you can design more representative and diverse charts in this file to enrich your conclusion.
