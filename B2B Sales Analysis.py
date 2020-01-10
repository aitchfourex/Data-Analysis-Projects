# Machine Learning

# Import libraries
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline

from sklearn.model_selection import train_test_split
from sklearn.model_selection import learning_curve
from sklearn.model_selection import validation_curve
from sklearn.model_selection import cross_val_score

pd.options.display.max_rows = 4000
pd.options.display.max_columns = 4000

# Plot learning curve
def plot_learning_curve(estimator, title, X, y, ylim=None, cv=None,
                        n_jobs=1, train_sizes=np.linspace(.1, 1.0, 5)):
    plt.figure()
    plt.title(title)
    if ylim is not None:
        plt.ylim(*ylim)
    plt.xlabel("Training examples")
    plt.ylabel("Score")
    train_sizes, train_scores, test_scores = learning_curve(
        estimator, X, y, cv=cv, n_jobs=n_jobs, train_sizes=train_sizes)
    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std = np.std(train_scores, axis=1)
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
    plt.grid()

    plt.fill_between(train_sizes, train_scores_mean - train_scores_std,
                     train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.fill_between(train_sizes, test_scores_mean - test_scores_std,
                     test_scores_mean + test_scores_std, alpha=0.1, color="g")
    plt.plot(train_sizes, train_scores_mean, 'o-', color="r",
             label="Training score")
    plt.plot(train_sizes, test_scores_mean, 'o-', color="g",
             label="Validation score")

    plt.legend(loc="best")
    return plt

def draw_missing_data_table(df):
    total = df.isnull().sum().sort_values(ascending=False)
    percent = (df.isnull().sum()/df.isnull().count()).sort_values(ascending=False)
    missing_data = pd.concat([total, percent], axis=1, keys=['Total', 'Percent'])
    return missing_data


# Plot validation curve
def plot_validation_curve(estimator, title, X, y, param_name, param_range, ylim=None, cv=None,
                        n_jobs=1, train_sizes=np.linspace(.1, 1.0, 5)):
    train_scores, test_scores = validation_curve(estimator, X, y, param_name, param_range, cv)
    train_mean = np.mean(train_scores, axis=1)
    train_std = np.std(train_scores, axis=1)
    test_mean = np.mean(test_scores, axis=1)
    test_std = np.std(test_scores, axis=1)
    plt.plot(param_range, train_mean, color='r', marker='o', markersize=5, label='Training score')
    plt.fill_between(param_range, train_mean + train_std, train_mean - train_std, alpha=0.15, color='r')
    plt.plot(param_range, test_mean, color='g', linestyle='--', marker='s', markersize=5, label='Validation score')
    plt.fill_between(param_range, test_mean + test_std, test_mean - test_std, alpha=0.15, color='g')
    plt.grid() 
    plt.xscale('log')
    plt.legend(loc='best') 
    plt.xlabel('Parameter') 
    plt.ylabel('Score') 
    plt.ylim(ylim)

##############################################################################################################################################################################################
##############################################################################################################################################################################################

# Import raw data
df = pd.read_csv('G:/Temp Storage/Salvirt_B2B_ML_dataset.csv')

# Cleaning raw data
# Turning raw DataFrame into Array
arr = df.to_numpy()

# Appending array entries into a list
li = []
for i in arr:
    li.append(list(i))
    
# Creatinga n empty list to store the split
li2 = []

# Loop to split the rows
for i in range(len(li)):
    li[i][0] = li[i][0].replace('"', "")
    li2.append(li[i][0].split(sep = ';'))

# Cleaning column values
columnlist = list(df.columns)
columnlist[0] = columnlist[0].replace('"', "")
columnlist[0] = columnlist[0].split(sep = ';')

# Creating new dataframe containg the 
df2 = pd.DataFrame(data = li2, columns = columnlist[0])

X = df2.iloc[:, 0:-1]
y = df2.iloc[:, -1]

X.drop('Seller', axis = 1, inplace = True)

authority_mapper = {'Low' : 1, 'Mid' : 5, 'High' : 10}
X['Authority'] = df2['Authority'].replace(authority_mapper)

companysize_mapper = {'Small' : 1, 'Mid' : 5, 'Big' : 10}
X['Comp_size'] = df2['Comp_size'].replace(companysize_mapper)

competitors_mapper = {'No' : 1, 'Yes' : 10, 'Unknown' : 5}
X['Competitors'] = df2['Competitors'].replace(competitors_mapper)

purchasingdept_mapper = {'No' : 1, 'Yes' : 10, 'Unknown' : 5}
X['Purch_dept'] = df2['Purch_dept'].replace(purchasingdept_mapper)

partnership_mapper = {'No' : 1, 'Yes' : 10}
X['Partnership'] = df2['Partnership'].replace(partnership_mapper)

budget_mapper = {'No' : 1, 'Yes' : 10, 'Unknown' : 5}
X['Budgt_alloc'] = df2['Budgt_alloc'].replace(budget_mapper)

formal_mapper = {'No' : 1, 'Yes' : 10}
X['Forml_tend'] = df2['Forml_tend'].replace(formal_mapper)

rfi_mapper = {'No' : 1, 'Yes' : 10}
X['RFI'] = df2['RFI'].replace(rfi_mapper)

rfp_mapper = {'No' : 1, 'Yes' : 10}
X['RFP'] = df2['RFP'].replace(rfp_mapper)

growth_mapper = {'Growth' : 10, 'Stable' : 5, 'Unknown' : 3, 'Slow down' : 1}
X['Growth'] = df2['Growth'].replace(growth_mapper)

positive_mapper = {'No' : 1, 'Yes' : 10, 'Neutral' : 5}
X['Posit_statm'] = df2['Posit_statm'].replace(positive_mapper)

client_mapper = {'New' : 1, 'Current' : 5, 'Past' : 10}
X['Client'] = df2['Client'].replace(client_mapper)

scope_mapper = {'Clear' : 10, 'Few questions' : 5, 'Low' : 1}
X['Scope'] = df2['Scope'].replace(scope_mapper)

strat_mapper = {'Very important' : 10, 'Unimportant' : 1, 'Average important' : 5}
X['Strat_deal'] = df2['Strat_deal'].replace(strat_mapper)

crosssale_mapper = {'No' : 1, 'Yes' : 10}
X['Cross_sale'] = df2['Cross_sale'].replace(crosssale_mapper)

upsale_mapper = {'No' : 1, 'Yes' : 10}
X['Up_sale'] = df2['Up_sale'].replace(upsale_mapper)

needs_mapper = {'Yes' : 10, 'No' : 3, 'Info gathering' : 5, 'Poor' : 1}
X['Needs_def'] = df2['Needs_def'].replace(needs_mapper)

attention_mapper = {'Strategic account' : 10, 'Normal' : 5, 'First deal' : 7, 'Bad client' : 1}
X['Att_t_client'] = df2['Att_t_client'].replace(attention_mapper)

X = pd.get_dummies(data = X, columns = ['Product', 'Source', 'Deal_type'], drop_first = True)

status_mapper = {'Won' : 1, 'Lost' : 0}
y = y.replace(status_mapper)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.2, random_state=1)

##############################################################################################################################################################################################
##############################################################################################################################################################################################

# Fit logistic regression
from sklearn.linear_model import LogisticRegression
classifier = LogisticRegression()
classifier.fit(X_train, y_train)

# Kernel SVM
from sklearn.svm import SVC
classifier = SVC(kernel = 'rbf', random_state = 0)
classifier.fit(X_train, y_train)

# Trees
from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier(criterion = 'entropy', random_state = 0)
classifier.fit(X_train, y_train)

from sklearn.ensemble import RandomForestClassifier
classifier = RandomForestClassifier(n_estimators = 100, criterion = 'entropy', random_state = 0)
classifier.fit(X_train, y_train)

# KNN
from sklearn.neighbors import KNeighborsClassifier
classifier = KNeighborsClassifier(n_neighbors = 10, metric = 'minkowski', p = 2)
classifier.fit(X_train, y_train)

# Naive Bayes
from sklearn.naive_bayes import GaussianNB
classifier = GaussianNB()
classifier.fit(X_train, y_train)

from xgboost import XGBClassifier
classifier = XGBClassifier()
classifier.fit(X_train, y_train)

##############################################################################################################################################################################################
##############################################################################################################################################################################################

# Model performance
scores = cross_val_score(classifier, X_train, y_train, cv=10)
print('CV accuracy: %.3f +/- %.3f' % (np.mean(scores), np.std(scores)))

# Confusion matrix
from sklearn.metrics import classification_report, confusion_matrix
# Evaluating the model
# This line uses our classifier to make predictions based on test set of independent variables which is a subset of our original data
y_pred = classifier.predict(X_test)

# Confusion matrix
cm = confusion_matrix(y_test, y_pred)

# Visualizing confusion matrix
sns.heatmap(cm, annot = True)




# Plot learning curves
title = "Learning Curves (Logistic Regression)"
cv = 10
plot_learning_curve(classifier, title, X_train, y_train, ylim=(0.7, 1.01), cv=cv, n_jobs=1);






# Plot validation curve
# FOR LOGISTIC REGRESSION, SVM AND XGBOOST
title = 'Validation Curve (Logistic Regression)'
param_name = 'C'
param_range = [0.001, 0.01, 0.1, 1.0, 10.0, 100.0] 
cv = 10
plot_validation_curve(estimator=classifier, title=title, X=X_train, y=y_train, param_name=param_name,
                      ylim=(0.5, 1.01), param_range=param_range);

# FOR TREES
title = 'Validation Curve (Decision Tree/Random Forest)'
param_name = 'max_depth'
param_range = [0.001, 0.01, 0.1, 1.0, 10.0, 100.0] 
cv = 10
plot_validation_curve(estimator=classifier, title=title, X=X_train, y=y_train, param_name=param_name,
                      ylim=(0.5, 1.01), param_range=param_range);

# FOR KNN
title = 'Validation Curve (KNN)'
param_name = 'n_neighbors'
param_range = [1, 5, 10, 20, 30, 100] 
cv = 10
plot_validation_curve(estimator=classifier, title=title, X=X_train, y=y_train, param_name=param_name,
                      ylim=(0.5, 1.01), param_range=param_range);





