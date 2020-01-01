import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import scipy
%matplotlib inline

# Display more rows and columns in pandas
pd.options.display.max_rows = 4000
pd.options.display.max_columns = 4000

# Import dataset
teams = ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN', 'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIL', 'MIN', 'NOP', 'NYK', 'OKC', 'ORL', 'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']
playerbios2020 = pd.read_csv("2020 NBA Player Bios.csv")

# Let's add a new row entry for Zion Williamson
# We start by creating a list of dictionaries
ziondata = [{'Player' : 'Zion Williamson',
			  'Team' : 'NOP',
			  'Age' : 19.0,
			  'Height' : '6-6',
			  'Weight' : '284',
			  'College' : 'Duke',
			  'Country' : 'USA',
			  'Draft Year' : '2019',
			  'Draft Round' : '1',
			  'Draft Number' : '1',
			  'GP' : np.nan,
			  'PTS' : np.nan,
			  'REB' : np.nan,
			  'AST' : np.nan,
			  'NetRtg' : np.nan,
			  'OREB%' : np.nan,
			  'DREB%' : np.nan,
			  'USG%' : np.nan,
			  'TS%' : np.nan,
			  'AST%' : np.nan}]

ziondf = pd.DataFrame(ziondata)
playerbios2020 = playerbios2020.append(ziondf)
			 
# Sort values by weight
playerbios2020.sort_values('Weight', ascending = False, inplace = True)
playerbios2020.reset_index(drop = True, inplace = True)

# Some height and weight values are missing and have '-' as a placeholder, let's replace with NaN
playerbios2020.replace('-', np.nan)

# Let's count how many NaN entries there are in Height and Weight columns
# Running this line returns 50 values
playerbios2020.isna().sum()

# Let's create a new dataframe without the NaN height and weight entries instead of dropping them from our original dataframe
bmidata = playerbios2020.iloc[:len(playerbios2020) - 50]
bmidata['Weight'] = bmidata['Weight'].astype(float)

# Height is currently input as a string in this format: 'feet-inches'
# Let's convert this into a numerical value for height in inches
# We can do this by making a list out of the 'Height' column and performing some string manipulation
lis = bmidata['Height']

heightlist = []
for i in lis:
    feetinch = i.split('-')
    feet = feetinch[0]
    inch = feetinch[1]
    feet = float(feet)
    inch = float(inch)
    heightinch = (feet * 12) + inch
    heightlist.append(heightinch)

# heightlist is a list of all heights in inches in the same ordering as the bmidata dataframe
# Let's convert heightlist into a series which we can insert into bmidata as a column
heightseries = pd.DataFrame(heightlist)
heightseries.rename(columns = {0 : "Height in Inches"})

# Inserting the series
bmidata.insert(3, column = 'Height in Inches', value = heightseries)

# Calculating and inserting BMI column
bmi = ((bmidata['Weight'] * 703) / (bmidata['Height in Inches'] * bmidata['Height in Inches'])).round(1)
bmi = pd.DataFrame(bmi)
bmidata.insert(6, column = 'BMI', value = bmi)

# Let's group by teams
teamsbmi = bmidata.groupby('Team')
# There are thirty teams in the NBA, let's create a separate dataframe object for all of them
ATL = teamsbmi.get_group('ATL')
BKN = teamsbmi.get_group('BKN')
BOS = teamsbmi.get_group('BOS')
CHA = teamsbmi.get_group('CHA')
CHI = teamsbmi.get_group('CHI')
CLE = teamsbmi.get_group('CLE')
DAL = teamsbmi.get_group('DAL')
DEN = teamsbmi.get_group('DEN')
DET = teamsbmi.get_group('DET')
GSW = teamsbmi.get_group('GSW')
HOU = teamsbmi.get_group('HOU')
IND = teamsbmi.get_group('IND')
LAC = teamsbmi.get_group('LAC')
LAL = teamsbmi.get_group('LAL')
MEM = teamsbmi.get_group('MEM')
MIA = teamsbmi.get_group('MIA')
MIL = teamsbmi.get_group('MIL')
MIN = teamsbmi.get_group('MIN')
NOP = teamsbmi.get_group('NOP')
NYK = teamsbmi.get_group('NYK')
OKC = teamsbmi.get_group('OKC')
ORL = teamsbmi.get_group('ORL')
PHI = teamsbmi.get_group('PHI')
PHX = teamsbmi.get_group('PHX')
POR = teamsbmi.get_group('POR')
SAC = teamsbmi.get_group('SAC')
SAS = teamsbmi.get_group('SAS')
TOR = teamsbmi.get_group('TOR')
UTA = teamsbmi.get_group('UTA')
WAS = teamsbmi.get_group('WAS')

# Let's create a list of mean BMIs for all teams
# Let's create a list of mean BMIs for all teams
meanbmis = [ATL.agg({'BMI' : 'mean'})[0],
			BKN.agg({'BMI' : 'mean'})[0],
			BOS.agg({'BMI' : 'mean'})[0],
			CHA.agg({'BMI' : 'mean'})[0],
			CHI.agg({'BMI' : 'mean'})[0],
			CLE.agg({'BMI' : 'mean'})[0],
			DAL.agg({'BMI' : 'mean'})[0],
			DEN.agg({'BMI' : 'mean'})[0],
			DET.agg({'BMI' : 'mean'})[0],
			GSW.agg({'BMI' : 'mean'})[0],
			HOU.agg({'BMI' : 'mean'})[0],
			IND.agg({'BMI' : 'mean'})[0],
			LAC.agg({'BMI' : 'mean'})[0],
			LAL.agg({'BMI' : 'mean'})[0],
			MEM.agg({'BMI' : 'mean'})[0],
			MIA.agg({'BMI' : 'mean'})[0],
			MIL.agg({'BMI' : 'mean'})[0],
			MIN.agg({'BMI' : 'mean'})[0],
			NOP.agg({'BMI' : 'mean'})[0],
			NYK.agg({'BMI' : 'mean'})[0],
			OKC.agg({'BMI' : 'mean'})[0],
			ORL.agg({'BMI' : 'mean'})[0],
			PHI.agg({'BMI' : 'mean'})[0],
			PHX.agg({'BMI' : 'mean'})[0],
			POR.agg({'BMI' : 'mean'})[0],
			SAC.agg({'BMI' : 'mean'})[0],
			SAS.agg({'BMI' : 'mean'})[0],
			TOR.agg({'BMI' : 'mean'})[0],
			UTA.agg({'BMI' : 'mean'})[0],
			WAS.agg({'BMI' : 'mean'})[0]]

meanbmibarplotdf = pd.DataFrame(index = teams, columns = ['MeanBmis'])
meanbmibarplotdf['MeanBmis'] = meanbmis

plt.style.use('fivethirtyeight')
meanbmiplot = meanbmibarplotdf.plot.bar(figsize = (10, 10), color = 'red', legend = False)
plt.title('The Gumbo Effect')
plt.ylabel('Gumbo Score')
plt.xlabel('Team', labelpad = 10)

# Seaborn plots
sns.pairplot(bmidata[["BMI", "PTS", "REB", "AST", "GP"]])
plt.show()

plt.figure(figsize = (20,20))
ax = sns.heatmap(bmidata.corr(), annot=True)

sns.distplot(bmidata['BMI'])

# Creating array with all BMI values from NOP
a = np.array(NOP['BMI'])

# Creating array with all other BMI values
teamsexceptnop = [ATL, BKN, BOS, CHA, CHI, CLE, DAL, DEN, DET, GSW, HOU, IND, LAC, LAL, MEM, MIA, MIL, MIN, NYK, OKC, ORL, PHI, PHX, POR, SAC, SAS, TOR, UTA, WAS]

otherbmi = np.empty([0, 1])

for i in teamsexceptnop:
   otherbmi = np.append(otherbmi, i['BMI'])

# Creating array with random sample of size N = 13
b = np.random.choice(otherbmi, 13)

# Running the t-test using scipy
t, p = scipy.stats.ttest_ind(a,b)

t
p

# Running the t-test 500 times
index = 0
results = np.empty((0, 0))
while index < 500:
    b = np.random.choice(otherbmi, 13)
    t, p = scipy.stats.ttest_ind(a,b)
    results = np.append(results, p)
    index = index + 1

# More fun with BMI
# PCA Analysis
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

# Need to convert all percentages to floats for data preprocessing
bmiclean = bmidata.dropna()

def p2f(x):
    return float(x.strip('%'))/100

bmiclean['OREB%'] = bmiclean['DREB%'].apply(p2f)
bmiclean['DREB%'] = bmiclean['DREB%'].apply(p2f)
bmiclean['USG%'] = bmiclean['USG%'].apply(p2f)
bmiclean['TS%'] = bmiclean['TS%'].apply(p2f)
bmiclean['AST%'] = bmiclean['AST%'].apply(p2f)

# Creating X and y
X = bmiclean.iloc[:, np.r_[2:4, 5, 12:22]]
y = bmiclean.iloc[:, 6]

# Scaling
X = StandardScaler().fit_transform(X)

# Creating first 2 PCA Components and DataFrame
pca = PCA(n_components=2)
principalComponents = pca.fit_transform(X)
principalDf = pd.DataFrame(data = principalComponents ,columns = ['PC1', 'PC2'])
principalDf['BMI'] = y

# Plotting PCA1 and PCA2 to identify clusters
# BMI is represented by the size of the dot
plt.figure(figsize = (10, 10))
plt.style.use("fivethirtyeight")
plt.scatter(x = principalDf['PC1'], y = principalDf['PC2'], s = ((principalDf['BMI']/principalDf['BMI'].mean())+0.15) ** 15, c = 'black')
plt.title('Principal Component Analysis of BMI')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.axvline(x = 1, ymax = 0.72)
plt.axhline(y = 3.3, xmin = 0.49)
plt.figtext(x = 0, y = 0.9, s = "Higher BMI is \nRepresented \nby Larger Dot")


# K Means Clustering on PCA1 and PCA2
from sklearn.cluster import KMeans
X = principalDf.iloc[:,0:2]

# Applying kmeans to the data
kmeans = KMeans(n_clusters = 2, init = 'k-means++', max_iter = 300, n_init = 10, random_state = 0)
y_kmeans = kmeans.fit_predict(X)

# PCA1 and PC2 scatter plot with K Means Clustering
plt.figure(figsize = (10, 10))
plt.style.use("seaborn")
plt.scatter(x = principalDf['PC1'], y = principalDf['PC2'], s = ((principalDf['BMI']/principalDf['BMI'].mean())+0.15) ** 20, c=y_kmeans, cmap='cool', linewidths = 1, edgecolor = 'black' )
plt.scatter(kmeans.cluster_centers_[:, 0], kmeans.cluster_centers_[:, 1], s = 100, c = 'black', label = 'Centroids')
plt.title('Principal Component Analysis of BMI \nWith K Means Clustering')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.figtext(x = 0, y = 0.9, s = "Higher BMI is \nRepresented \nby Larger Dot")
plt.legend()
