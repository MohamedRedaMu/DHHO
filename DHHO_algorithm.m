function [goalReached, GlobalBest, countFE] = DHHO_algorithm()

    %% *********************** Function Description ********************
    %{
    This function implements the Differential Harris Hawks Optimization (DHHO) algorithm.
    Outputs:
        goalReached: Boolean indicating if the algorithm reached the tolerance before max iterations.
        GlobalBest: Struct containing the best solution and its cost.
            GlobalBest.Position: the best solution
            GlobalBest.Cost: the cost of the best found solution
        countFE: Total number of function evaluations.
    %}

    %% *********************************** Citation **********************
    %{
    Citation (Please cite the following paper paper):
        If you use this code in your research, please cite the following paper:
        %% Bibtex:
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



   %% Begin intialiazation
    %% CEC function paramters
    fNo = 3 ; % function number
    nd = 10; % dim size (must be 10 or 20)
    lb = -100 ; % Lower bounds
    ub = 100 ;  % Upper bounds

    %% Algorithm paramters
    AlgName = 'DHHO Algorithm' ;
    E_limit = 2; % the enrgy varies randomly between -2 to 2 
    nPop = 30; % Population Size
    F = 0.5 ; % static weighting factor
    pCR = 0.5; % Crossover Probability
  

    %% Stopping criteria
    tol = 10^-8;
    if nd == 10
        maxfe = 200000 ; 
    elseif nd == 20 
        maxfe = 500000;
    else
        fprintf('Dimensions must be 10 or 20 \n');
        return
    end

    %% Display iteration prompt
    print_flag = true;

    %%  Global variable to count number of function evaluations
    global countFE;
    countFE = 0 ;

    %% Initialize iteration counter 
    N_iter = 0;

    %% Goal reached flag
    goalReached = false; 


    %% Initialize Global best
    GlobalBest.Position = [];
    GlobalBest.Cost = Inf ; 



    %% Set the seed for random number generator
    rng('default');  % Resets to the default settings
    rng('shuffle'); % set it to shuffle
    
    %% Initialize population and update the global best
    %% create empty individual
    individual.Position = [];
    individual.Cost = Inf;

    % Initialize particles array
    population = repmat(individual, nPop, 1);

    for i = 1:nPop
        % Initialize Position
        population(i).Position = unifrnd(lb, ub, [ 1, nd] );  

        % Evaluation of the cost
        population(i).Cost = cost_cec2020(population(i).Position, fNo);
          
        % Update Global Best
        if population(i).Cost < GlobalBest.Cost
            GlobalBest = population(i);
        end
    end


   %% begin algorithm loop 
    while (GlobalBest.Cost > tol)  && (countFE <= maxfe)
        %% update the generation
        N_iter=N_iter+1; 

        %% Update energy
        E1= E_limit * (1-(countFE/maxfe)); % Eq.(1) in the paper, factor to show the decreaing energy of rabbit

       %% Update the positions of Harris' hawks
        for i=1:nPop
            E0= 2 * rand()-1; %-1<E0<1  % Eq.(1) in the paper
            Escaping_Energy = E1 * (E0);  % % Eq.(1) in the paper, escaping energy of rabbit
            X_curr = population(i) ; 

            % Calculate Population Mean
            X_mean = 0;
            for i = 1:nPop
                X_mean = X_mean + population(i).Position;
            end
            X_mean = X_mean/nPop;

            %% Phase 1 of DHHO algorithm: Exploration 
            if abs(Escaping_Energy)>=1

                %% propsoed DE
                %% Mutation operator DE/rand/1
                idxs=randperm(nPop);    
                idxs(idxs==i)=[];    
    
                a = population(idxs(1)).Position;
                b = population(idxs(2)).Position;
                c = population(idxs(3)).Position;
                  
                y = a + F.* (b - c);  % Eq.(5) in the paper
                y = max(y, lb);
		        y = min(y, ub);
		        
                %% Binary Crossover operator  Eq.(6) in the paper
                x=population(i).Position;
                z=zeros(size(x));
                j0=randi([1 numel(x)]);
                for j=1:numel(x)
                    if j==j0 || rand<=pCR
                        z(j)=y(j);
                    else
                        z(j)=x(j);
                    end
                end
    
                NewSol.Position = z;
    
                 %% Evaluate
                NewSol.Cost = cost_cec2020(NewSol.Position, fNo);

                %% selection operator, Eq.(7) in the paper
                if NewSol.Cost < population(i).Cost
                    population(i).Position = NewSol.Position;      
                    population(i).Cost = NewSol.Cost;
    
                    %% Update Global Best
                    if population(i).Cost < GlobalBest.Cost
                        GlobalBest = population(i);
                    end
                end

            end

            %% Phase 2 of the DHHO algorithm: Exploitation Eq.(3) in the paper
            if abs(Escaping_Energy)<1
                r=rand(); % probablity of each event
                
                %% Eq.(3) branch 3 in the paper
                if r<0.5 && abs(Escaping_Energy)>=0.5, % Soft besiege % rabbit try to escape by many zigzag deceptive motions
                    
                    Jump_strength=2*(1-rand());
                    X1.Position = GlobalBest.Position -Escaping_Energy * abs(Jump_strength*GlobalBest.Position - X_curr.Position);
                    X1.Cost = cost_cec2020(X1.Position, fNo);

                    if X1.Cost < X_curr.Cost % improved move?
                        population(i).Position = X1.Position; %only save position , the cost will be calcuated later
                    else % hawks perform levy-based short rapid dives around the rabbit
                        X2.Position = GlobalBest.Position - Escaping_Energy * abs(Jump_strength * GlobalBest.Position - X_curr.Position )+rand(1,nd).*Levy(nd);
                        X2.Cost = cost_cec2020(X2.Position, fNo);
                        if (X2.Cost <  X_curr.Cost) % improved move?
                            population(i).Position = X2.Position;
                        end
                    end
                end
                
                 %% Eq.(3) branch 4 in the paper               
                if r<0.5 && abs(Escaping_Energy)<0.5 % Hard besiege % rabbit try to escape by many zigzag deceptive motions
                    % hawks try to decrease their average location with the rabbit
                    Jump_strength=2*(1-rand());
                    X1.Position = GlobalBest.Position -Escaping_Energy*abs(Jump_strength* GlobalBest.Position - X_mean);
                    X1.Cost = cost_cec2020(X1.Position, fNo); 
                    if X1.Cost < X_curr.Cost  % improved move?
                         population(i).Position = X1.Position;
                    else % Perform levy-based short rapid dives around the rabbit
                        X2.Position = GlobalBest.Position -Escaping_Energy*abs(Jump_strength*GlobalBest.Position-X_mean)+rand(1,nd).*Levy(nd);
                        X2.Cost = cost_cec2020(X2.Position, fNo);
                        if (X2.Cost <  X_curr.Cost)  % improved move?
                            population(i).Position = X2.Position;
                        end
                    end
                end
                %%
            end
        end
         %% evaluate the population
        for i = 1:nPop            
            % Check if hawks go out of the search space and bring it back
            Flag4ub = population(i).Position > ub;
            Flag4lb = population(i).Position < lb;
            population(i).Position = (population(i).Position .* ~(Flag4ub + Flag4lb)) + ub .* Flag4ub + lb .* Flag4lb;  

            % Calculate the fitness 
            population(i).Cost = cost_cec2020(population(i).Position, fNo);
            
            % Update Global Best
            if population(i).Cost < GlobalBest.Cost
                GlobalBest = population(i);
            end
        end

        %% check if maxfes is exceeded 
        if countFE > maxfe 
            break;
        end

        %% print the iteration number
        if print_flag            
            fprintf('%s | CEC2021_F%d_D%d | Iteration %d |FEs %d | Error %d\n', AlgName,  fNo , nd, N_iter, countFE,GlobalBest.Cost);
        end

         %check tolerance /error
        if (GlobalBest.Cost <= tol)
            GlobalBest.Cost  = 0 ;
            disp('tol reached');
            goalReached = true ; 
            break ;  % not needed, becuase it will exit in the next while loop check
        end

    end

        
    

end



%% Levy flight function
function o=Levy(d)
    beta=1.5;
    sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
    u=randn(1,d)*sigma;v=randn(1,d);step=u./abs(v).^(1/beta);
    o=step;
end













