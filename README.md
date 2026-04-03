# DHHO-Algorithm

Differential Harris Hawks Optimization (DHHO) Algorithm for Engineering Optimization

Official MATLAB implementation of the DHHO algorithm.

---

## 📄 Paper

Mohamed Reda, Ahmed Onsy, Amira Y. Haikal, and Ali Ghanbari
**Optimizing the Steering of Driverless Personal Mobility Pods with a Novel Differential Harris Hawks Optimization Algorithm (DHHO) and Encoder Modeling**
Sensors, 2024
DOI: https://doi.org/10.3390/s24144650

---

## 📘 Overview

DHHO is an enhanced version of the Harris Hawks Optimization (HHO) algorithm, designed to improve:

* Exploration–exploitation balance
* Convergence speed
* Solution accuracy in engineering optimization

### Key Features

* Differential mutation mechanism
* Adaptive exploration strategy
* Hybrid optimization behavior
* Improved convergence stability

---

## 📂 Repository Structure

```text
DHHO/
│
├── DHHO_algorithm.m
├── cost_cec2020.m
│
├── cec20_func.cpp
├── cec20_func.mexw64
│
├── input_data/
│   └── (CEC data files)
│
├── DHHO_paper.pdf
├── cec2020_definitions.pdf
│
├── README.md
├── LICENSE
├── CITATION.cff
├── .gitignore
└── .gitattributes
```

---

## ⚙️ Requirements

* MATLAB (R2021a or later recommended)
* Statistics Toolbox (if random sampling is used)

---

## ▶️ How to Run

Open MATLAB, set the current folder to the repository root, then run:

```matlab
[goalReached, GlobalBest, countFE] = DHHO_algorithm();
```

### Current default settings inside the file

```matlab
fNo = 3;
nd  = 10;
lb  = -100;
ub  = 100;
```

The current implementation uses the CEC2020 benchmark wrapper `cost_cec2020.m`.

---

## 📚 Citation

If you use this code, please cite:

```bibtex
@article{reda2024Optimizing,
  title = {Optimizing the Steering of Driverless Personal Mobility Pods with a Novel Differential Harris Hawks Optimization Algorithm (DHHO) and Encoder Modeling},
  author = {Reda, Mohamed and Onsy, Ahmed and Haikal, Amira Y and Ghanbari, Ali},
  journal = {Sensors},
  volume = {24},
  number = {14},
  pages = {4650},
  year = {2024},
  doi = {10.3390/s24144650}
}
```

---

## 📜 License

This project is released under the MIT License.

---

## 📧 Contact

**Dr. Mohamed Reda**
University of Central Lancashire, UK
Mansoura University, Egypt

* 📩 Personal: [mohamed.reda.mu@gmail.com](mailto:mohamed.reda.mu@gmail.com)
* 📩 Academic: [mohamed.reda@mans.edu.eg](mailto:mohamed.reda@mans.edu.eg)


---

## 🌐 Academic Profiles

* ORCID: https://orcid.org/0000-0002-6865-1315
* Google Scholar: https://scholar.google.com/citations?user=JmuB2qwAAAAJ
* Scopus: https://www.scopus.com/authid/detail.uri?authorId=57220204540

---

## 🔗 Professional Links

* LinkedIn: https://www.linkedin.com/in/mraf
* ResearchGate: https://www.researchgate.net/profile/Mohamed-Reda-8
* Academia: https://mansoura.academia.edu/MohamedRedaAboelfotohMohamed
* MATLAB Central: https://uk.mathworks.com/matlabcentral/profile/authors/36082525

---

## 🙏 Acknowledgement

This repository accompanies the DHHO paper published in Sensors.
