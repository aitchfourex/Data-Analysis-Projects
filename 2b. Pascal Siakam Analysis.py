import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline

pd.options.display.max_rows = 4000
pd.options.display.max_columns = 4000

###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################

# DATA INTAKE AND CLEANING
player = 'Pascal Siakam'

# 2020 Season
statsbygame2020 = pd.read_html("https://www.espn.com/nba/player/gamelog/_/id/3149673/pascal-siakam")

data2020 = pd.DataFrame(columns = statsbygame2020[0].columns)

for i in range(len(statsbygame2020) - 3):
    df1 = statsbygame2020[i]
    df1 = df1.iloc[:-1]
    data2020 = data2020.append(df1)

data2020.reset_index(drop = True, inplace = True)

###############################################################################################################################################################################################

# 2019 Season
# Importing game log data from 2018-2019 season for Paskal Siakam
statsbygame2019 = pd.read_html("https://www.espn.com/nba/player/gamelog/_/id/3149673/type/nba/year/2019")
statsbygame2019 = statsbygame2019[5:12]

data2019 = pd.DataFrame(columns = statsbygame2019[0].columns)

# Appending our empty dataframe with relevent rows (last row contains monthly averages)
for i in range(len(statsbygame2019)):
    df2 = statsbygame2019[i]
    df2 = df2.iloc[:-1]
    data2019 = data2019.append(df2)

# Reversing out dataframe so that games are in ascending order (October to April)
data2019 = data2019[::-1]

# Resetting our index
data2019.reset_index(drop = True, inplace = True)

###############################################################################################################################################################################################

# 2018 Season
statsbygame2018 = pd.read_html("https://www.espn.com/nba/player/gamelog/_/id/3149673/type/nba/year/2018")
statsbygame2018 = statsbygame2018[3:10]

data2018 = pd.DataFrame(columns = statsbygame2018[5].columns)

# Appending our empty dataframe with relevent rows (last row contains monthly averages)
for i in range(len(statsbygame2018)):
    df3 = statsbygame2018[i]
    df3 = df3.iloc[:-1]
    data2018 = data2018.append(df3)

# Reversing out dataframe so that games are in ascending order (October to April)
data2018 = data2018[::-1]

# Resetting our index
data2018.reset_index(drop = True, inplace = True)

###############################################################################################################################################################################################

# 2017 Season
statsbygame2017 = pd.read_html("https://www.espn.com/nba/player/gamelog/_/id/3149673/type/nba/year/2017")
statsbygame2017 = statsbygame2017[2:9]

data2017 = pd.DataFrame(columns = statsbygame2017[5].columns)

# Appending our empty dataframe with relevent rows (last row contains monthly averages)
for i in range(len(statsbygame2017)):
    df4 = statsbygame2017[i]
    df4 = df4.iloc[:-1]
    data2017 = data2017.append(df4)

# Reversing out dataframe so that games are in ascending order (October to April)
data2017 = data2017[::-1]

# Resetting our index
data2017.reset_index(drop = True, inplace = True)

# Viewing our dataframes
data2020.head()
data2019.head()
data2018.head()
data2017.head()

###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################

seasons = ['2017', '2018', '2019', '2020']

# Average Points in Same NUmber of Games in 2019 Season
data2019.iloc[:len(data2020)]['PTS'].mean()
# Average Points in 2020 Season
data2020['PTS'].mean()
# Creating a list to plot the average points
pointscompare = [data2017.iloc[:len(data2020)]['PTS'].mean(), data2018.iloc[:len(data2020)]['PTS'].mean(), data2019.iloc[:len(data2020)]['PTS'].mean(), data2020['PTS'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = pointscompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Points\n All Seasons' % (player, len(data2020)))
plt.xlabel('Year', labelpad = 10)
plt.ylabel('Average Points', labelpad = 10)

###############################################################################################################################################################################################

# Using the same logic, we can compare the minutes played
minutescompare = [data2017.iloc[:len(data2020)]['MIN'].mean(), data2018.iloc[:len(data2020)]['MIN'].mean(), data2019.iloc[:len(data2020)]['MIN'].mean(), data2020['MIN'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = minutescompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Minutes Played\n All Seasons' % (player, len(data2020)))
plt.xlabel('Year', labelpad = 10)
plt.ylabel('Average Minutes Played', labelpad = 10)

###############################################################################################################################################################################################

# Rebounds
reboundscompare = [data2017.iloc[:len(data2020)]['REB'].mean(), data2018.iloc[:len(data2020)]['REB'].mean(), data2019.iloc[:len(data2020)]['REB'].mean(), data2020['REB'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = reboundscompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Rebounds\n All Seasons' % (player, len(data2020)))
plt.xlabel('Season', labelpad = 10)
plt.ylabel('Average Rebounds', labelpad = 10)

###############################################################################################################################################################################################

# Assists
assistscompare = [data2017.iloc[:len(data2020)]['AST'].mean(), data2018.iloc[:len(data2020)]['AST'].mean(), data2019.iloc[:len(data2020)]['AST'].mean(), data2020['AST'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = assistscompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Assists\n All Seasons' % (player, len(data2020)))
plt.xlabel('Season', labelpad = 10)
plt.ylabel('Average Assists', labelpad = 10)

###############################################################################################################################################################################################

# Blocks
blockscompare = [data2017.iloc[:len(data2020)]['BLK'].mean(), data2018.iloc[:len(data2020)]['BLK'].mean(), data2019.iloc[:len(data2020)]['BLK'].mean(), data2020['BLK'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = blockscompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Blocks\n All Seasons' % (player, len(data2020)))
plt.xlabel('Season', labelpad = 10)
plt.ylabel('Average Blocks', labelpad = 10)

###############################################################################################################################################################################################

# Steals
stealscompare = [data2017.iloc[:len(data2020)]['STL'].mean(), data2018.iloc[:len(data2020)]['STL'].mean(), data2019.iloc[:len(data2020)]['STL'].mean(), data2020['STL'].mean()]

plt.figure(figsize = (5, 10))
plt.style.use("fivethirtyeight")
plt.bar(x = seasons, height = stealscompare, width = 0.9, color = 'indianred')
plt.title('%s\n First %d Games\n Average Steals\n 2019 vs. 2020' % (player, len(data2020)))
plt.xlabel('Season', labelpad = 10)
plt.ylabel('Average Steals', labelpad = 10)

###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################

stats2020 = pd.read_csv("G:/Dropbox/Software Development/FILES/SATB/NBA/2020 Season Stats Per Game 12 23 2019.csv")
stats = ['MP', 'FG', 'FGA', 'FG%', '3P', '3PA', '3P%', '2P', '2PA', '2P%', 'eFG%', 'FT', 'FTA', 'FT%', 'ORB', 'DRB', 'TRB', 'AST', 'STL', 'BLK', 'TOV', 'PF', 'PTS']

statsresult = pd.DataFrame(columns = stats2020.columns)
for stat in stats:
	stats2020.sort_values(stat, ascending = False, inplace = True)
	stats2020.reset_index(drop = True, inplace = True)
	index = stats2020[stats2020['Player'] == 'Pascal Siakam'].index[0]
	statsresult = statsresult.append(stats2020.iloc[index-5:index+6])

groups2020 = statsresult.groupby('Player')
similarstats = groups2020.size().sort_values()

plt.figure(figsize = (10, 10))
similarstats[-11:-1].plot.bar(color = 'indianred')
plt.title('Players Similar to Pascal Siakam')
plt.xlabel('Players')
plt.xlabel('Number of Similar Stats')
plt.xticks(rotation = 45)

###############################################################################################################################################################################################

advancedstats2020 = pd.read_csv("G:/Dropbox/Software Development/FILES/SATB/NBA/2020 Advanced Stats Per Game.csv")
advancedstats = ['G', 'MP', 'PER', 'TS%', '3PAr', 'FTr', 'ORB%', 'DRB%', 'TRB%', 'AST%', 'STL%', 'BLK%', 'TOV%', 'USG%', 'OWS', 'DWS', 'WS', 'WS/48', 'OBPM', 'DBPM', 'BPM', 'VORP']
advancedstats2020.dropna(axis = 1, how = 'all', inplace = True)

advancedstatsresult = pd.DataFrame(columns = advancedstats2020.columns)
for stat in advancedstats:
	advancedstats2020.sort_values(stat, ascending = False, inplace = True)
	advancedstats2020.reset_index(drop = True, inplace = True)
	index = advancedstats2020[advancedstats2020['Player'] == 'Pascal Siakam'].index[0]
	advancedstatsresult = advancedstatsresult.append(advancedstats2020.iloc[index-5:index+6])

advancedgroups2020 = advancedstatsresult.groupby('Player')

###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
###############################################################################################################################################################################################
