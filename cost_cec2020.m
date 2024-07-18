function [e] = cost_cec2020(x, fNo)

    %% *********************** Function Description *********************
    %{
    
    COST_CEC2020 Evaluates the cost of a solution vector for a specified CEC 2020 benchmark function.

    Inputs:
      x   - A vector representing a candidate solution. It is expected to be of size nPop * dim_size and will be
            transposed within the function to suit the CEC evaluation function requirements.
      fNo - An integer representing the function number to be evaluated. The valid range for fNo is from 1 to 10.

    Outputs:
      e   - The computed error for the given solution vector. This is calculated as the difference between the
            evaluated function value and the known global minimum for the specified function number.

    Global Variables:
      countFE - A global variable that tracks the number of function evaluations. It is incremented by 1 each time
                the function is called.
    %}

    %% *********************************** Citation **********************
    %{
    Citation (Please cite the following paper paper):
        If you use this code in your research, please cite the following paper:
        
        %% Bibtex format:
        @article{reda2024Optimizing,
          title = {Optimizing the Steering of Driverless Personal Mobility Pods with a Novel Differential Harris Hawks Optimization Algorithm (DHHO) and Encoder Modeling},
          author = {Reda, Mohamed and Onsy, Ahmed and Haikal, Amira Y and Ghanbari, Ali},
          journal = {Sensors},
          volume = {24},
          number = {14},
          pages = {4650},
          year = {2024},
          publisher = {MDPI},
          doi = {https://doi.org/10.3390/s24144650},
          url = {https://www.mdpi.com/1424-8220/24/14/4650}
        }

        %% AMA Style
        Reda M, Onsy A, Haikal AY, Ghanbari A. Optimizing the Steering of Driverless Personal Mobility Pods with a Novel Differential Harris Hawks Optimization 
        Algorithm (DHHO) and Encoder Modeling. Sensors. 2024; 24(14):4650. https://doi.org/10.3390/s24144650

    
        %% Chicago/Turabian Style
        Reda, Mohamed, Ahmed Onsy, Amira Y. Haikal, and Ali Ghanbari. 2024. "Optimizing the Steering of Driverless Personal Mobility Pods with a Novel Differential
        Harris Hawks Optimization Algorithm (DHHO) and Encoder Modeling" Sensors 24, no. 14: 4650. https://doi.org/10.3390/s24144650
        
    Code citation:
        If you use this code in your research, please cite the following code as follows:

        Mohamed Reda. (2024). MATLAB implementation of the Differential Harris Hawks Optimization (DHHO) Algorithm. Available at: [https://github.com/MohamedRedaMu/DHHO]

    Contact Information:
        For questions or further information, please contact:
        Author Name:
            Mohamed Reda

        Affiliation:
            1- School of Engineering, University of Central Lancashire, Preston, PR1 2HE, UK
            2- Computers and Control Systems Engineering Department, Faculty of Engineering, Mansoura University, Mansoura, 35516, Egypt

        Emails:
            mohamed.reda.mu@gmail.com;
            mohamed.reda@mans.edu.eg;
            mramohamed@uclan.ac.uk

    %}

    % Increment the number of function evaluations
    global countFE;
    countFE = countFE + 1 ; % inc function evaluations

    % Define the global minimum values for each function number
    globalMins = [100, 1100, 700, 1900, 1700, 1600, 2100, 2200, 2400, 2500];
    
    % Check if the function number is within the valid range
    if fNo < 1 || fNo > length(globalMins)
        e = Inf;
        fprintf('Function number must be between 1 and %d', length(globalMins));
        return
    end
    

 

    % Get the global minimum for the given function number
    globalMin = globalMins(fNo);
    
    % Call the CEC2020/2021 function 
    % The solution vector x is transposed to suit the CEC evaluation function requirements
    f = cec20_func(x', fNo); 

    % Calculate the error as the difference between the evaluated function value and the global minimum
    e = f - globalMin;
    
end
