classdef app2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        EditField2                      matlab.ui.control.NumericEditField
        EditField2Label                 matlab.ui.control.Label
        mouseclickedEditField           matlab.ui.control.NumericEditField
        mouseclickedEditFieldLabel      matlab.ui.control.Label
        ArmConfigurationEditField       matlab.ui.control.EditField
        ArmConfigurationEditFieldLabel  matlab.ui.control.Label
        WORKSPACEButton                 matlab.ui.control.Button
        Switch                          matlab.ui.control.ToggleSwitch
        SwitchLabel                     matlab.ui.control.Label
        L2EditField                     matlab.ui.control.NumericEditField
        L2EditFieldLabel                matlab.ui.control.Label
        L1EditField                     matlab.ui.control.NumericEditField
        L1EditFieldLabel                matlab.ui.control.Label
        th_1EditField                   matlab.ui.control.NumericEditField
        th_1EditFieldLabel              matlab.ui.control.Label
        th_2EditField                   matlab.ui.control.NumericEditField
        th_2EditFieldLabel              matlab.ui.control.Label
        y2Slider                        matlab.ui.control.Slider
        y2SliderLabel                   matlab.ui.control.Label
        x2Slider                        matlab.ui.control.Slider
        x2SliderLabel                   matlab.ui.control.Label
        yEditField                      matlab.ui.control.NumericEditField
        yEditFieldLabel                 matlab.ui.control.Label
        xEditField                      matlab.ui.control.NumericEditField
        xEditFieldLabel                 matlab.ui.control.Label
        th2Slider                       matlab.ui.control.Slider
        th2SliderLabel                  matlab.ui.control.Label
        th1Slider                       matlab.ui.control.Slider
        th1SliderLabel                  matlab.ui.control.Label
        UIAxes                          matlab.ui.control.UIAxes
    end

    
    properties (Access = public)
       x1  ; %  the x-axis cordinate of the first link end.
       y1  ; %  the y- axis cordinate of the first link end.
       x2 ;  % the x-axis cordinate of the second link end
       y2 ;  %  the y- axis cordinate of the first link end
       x0 = 0 ; %  origin cordinates.
       y0 = 0  ; %  origin cordinates.
    end
    


    

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: th1Slider
        function th1SliderValueChanged(app, event)
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ;%  the lenght of the second link.
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)]; 
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            value  = app.th1Slider.Value;
            app.x1 = L1 * cosd(value);
            app.y1 = L1 * sind(value);
            app.x2 =app.x1+ L2 *cosd(value+app.th2Slider.Value);
            app.y2 = app.y1+ L2  *sind(value+app.th2Slider.Value);

               if app.y2 <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.x2 > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif app.x2 < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                     app.th_1EditField.Value = value ;
                     app.th_2EditField.Value = app.th2Slider.Value;
                     app.xEditField.Value =app.x2;
                     app.yEditField.Value =app.y2;
                     app.x2Slider.Value = app.x2;
                     app.y2Slider.Value = app.y2; 
                     plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 app.x2],[app.y1 app.y2],'linewidth',1.25);    
               end


        end

        % Value changed function: th2Slider
        function th2SliderValueChanged(app, event)
              L1 =app.L1EditField.Value  ; %  the lenght of the first link.
              L2 =app.L2EditField.Value  ; %  the lenght of the second link.
              value  = app.th2Slider.Value;
              app.x1 = L1 * cosd(app.th1Slider.Value);
              app.y1 = L1 * sind(app.th1Slider.Value);
              app.x2 =app.x1+L2 *cosd(value+app.th1Slider.Value);
              app.y2 = app.y1+ L2  *sind(value+app.th1Slider.Value);
              app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
              app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
              app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
              app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
               if app.y2 <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.x2 > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif app.x2 < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                    app.th_1EditField.Value =app.th1Slider.Value ;
                    app.th_2EditField.Value = value;
                    app.xEditField.Value =app.x2;
                    app.yEditField.Value =app.y2;
                    app.x2Slider.Value = app.x2;
                    app.y2Slider.Value = app.y2;
                    plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 app.x2],[app.y1 app.y2],'linewidth',1.25);    
               end
             

            
            
        end

        % Value changed function: x2Slider
        function x2SliderValueChanged(app, event)
            x = app.x2Slider.Value; 
            y = app.y2Slider.Value;
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ; %  the lenght of the second link.
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            r=sqrt(x^2+y^2);
            th2 =180-acosd((L1^2+L2^2-r^2)/(2*L1*L2));
           value = app.Switch.Value ;
            app.ArmConfigurationEditField.Value = value;
            if strcmp(value,'elbow down')
                th1 = atand(y/x)-acosd((r^2+L1^2-L2^2)/(2*r*L1));
                app.x1 = L1 * cosd(th1);
                app.y1 = L1 * sind(th1);
            else  
                th1 = atand(y/x)+acosd((r^2+L1^2-L2^2)/(2*r*L1));
                 app.x1 = L1 * cosd(th1);
                 app.y1 = L1 * sind(th1);
            end

               if y <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif x > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif   x < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                    app.th1Slider.Value =th1 ;
                    app.th2Slider.Value = th2 ; 
                    app.th_1EditField.Value = th1;
                    app.th_2EditField.Value = th2;
                    app.xEditField.Value = x;
                    app.yEditField.Value = y;
                    plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 x],[app.y1 y],'linewidth',1.25);    
               end
                  
               
                    
                   
            
            
        end

        % Value changed function: y2Slider
        function y2SliderValueChanged(app, event)
            y= app.y2Slider.Value;
            x = app.x2Slider.Value;
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ; %  the lenght of the second link.
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            r=sqrt(x^2+y^2);
            th2 =180-acosd((L1^2+L2^2-r^2)/(2*L1*L2));
           value = app.Switch.Value ;
            app.ArmConfigurationEditField.Value = value;
            if strcmp(value,'elbow down')
                th1 = atand(y/x)-acosd((r^2+L1^2-L2^2)/(2*r*L1));
                app.x1 = L1 * cosd(th1);
                app.y1 = L1 * sind(th1);
            else  
                th1 = atand(y/x)+acosd((r^2+L1^2-L2^2)/(2*r*L1));
                 app.x1 = L1 * cosd(th1);
                 app.y1 = L1 * sind(th1);
            end

               if y <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif x > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif   x < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                   app.th_1EditField.Value =th1;
                   app.th_2EditField.Value = th2;
                   app.th1Slider.Value =th1;
                   app.th2Slider.Value = th2; 
                   app.xEditField.Value = x;
                   app.yEditField.Value = y;
                   plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 x],[app.y1 y],'linewidth',1.25);    
               end
            
        end

        % Value changed function: th_1EditField
        function th_1EditFieldValueChanged(app, event)
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ;%  the lenght of the second link.
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)]; 
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            value  = app.th_1EditField.Value;
            app.x1 = L1 * cosd(value);
            app.y1 = L1 * sind(value);
            app.x2 =app.x1+ L2 *cosd(value+app.th2Slider.Value);
            app.y2 = app.y1+ L2  *sind(value+app.th2Slider.Value);

               if app.y2 <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.x2 > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif app.x2 < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                     app.th1Slider.Value = value ;
                     app.th_2EditField.Value = app.th2Slider.Value;
                     app.xEditField.Value =app.x2;
                     app.yEditField.Value =app.y2;
                     app.x2Slider.Value = app.x2;
                     app.y2Slider.Value = app.y2; 
                     plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 app.x2],[app.y1 app.y2],'linewidth',1.25);    
               end

            
        end

        % Value changed function: th_2EditField
        function th_2EditFieldValueChanged(app, event)
             L1 =app.L1EditField.Value  ; %  the lenght of the first link.
              L2 =app.L2EditField.Value  ; %  the lenght of the second link.
              value  = app.th_2EditField.Value;
              app.x1 = L1 * cosd(app.th1Slider.Value);
              app.y1 = L1 * sind(app.th1Slider.Value);
              app.x2 =app.x1+L2 *cosd(value+app.th1Slider.Value);
              app.y2 = app.y1+ L2  *sind(value+app.th1Slider.Value);
              app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
              app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
              app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
              app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
               if app.y2 <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.x2 > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif app.x2 < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                    app.th_1EditField.Value =app.th1Slider.Value ;
                    app.th2Slider.Value = value;
                    app.xEditField.Value =app.x2;
                    app.yEditField.Value =app.y2;
                    app.x2Slider.Value = app.x2;
                    app.y2Slider.Value = app.y2;
                    plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 app.x2],[app.y1 app.y2],'linewidth',1.25);    
               end
            
        end

        % Value changed function: xEditField
        function xEditFieldValueChanged(app, event)
            x = app.xEditField.Value; 
            y = app.y2Slider.Value;
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ; %  the lenght of the second link.
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            r=sqrt(x^2+y^2);
            th2 =180-acosd((L1^2+L2^2-r^2)/(2*L1*L2));
            value = app.Switch.Value ;
            app.ArmConfigurationEditField.Value = value;
            if strcmp(value,'elbow down')
                th1 = atand(y/x)-acosd((r^2+L1^2-L2^2)/(2*r*L1));
                app.x1 = L1 * cosd(th1);
                app.y1 = L1 * sind(th1);
            else  
                th1 = atand(y/x)+acosd((r^2+L1^2-L2^2)/(2*r*L1));
                 app.x1 = L1 * cosd(th1);
                 app.y1 = L1 * sind(th1);
            end

               if y <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif x > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif   x < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                    app.th1Slider.Value =th1 ;
                    app.th2Slider.Value = th2 ; 
                    app.th_1EditField.Value = th1;
                    app.th_2EditField.Value = th2;
                    app.x2Slider.Value = x;
                    app.yEditField.Value = y;
                    plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 x],[app.y1 y],'linewidth',1.25);    
               end
            
        end

        % Value changed function: yEditField
        function yEditFieldValueChanged(app, event)
             y= app.yEditField.Value;
            x = app.x2Slider.Value;
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ; %  the lenght of the second link.
            app.y2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.x2Slider.Limits = [-(L1+L2) (L1+L2)];
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            r=sqrt(x^2+y^2);
            th2 =180-acosd((L1^2+L2^2-r^2)/(2*L1*L2));
            value = app.Switch.Value ;
            app.ArmConfigurationEditField.Value = value;
            if  strcmp(value,'elbow down')
                th1 = atand(y/x)-acosd((r^2+L1^2-L2^2)/(2*r*L1));
                app.x1 = L1 * cosd(th1);
                app.y1 = L1 * sind(th1);
            else  
                th1 = atand(y/x)+acosd((r^2+L1^2-L2^2)/(2*r*L1));
                 app.x1 = L1 * cosd(th1);
                 app.y1 = L1 * sind(th1);
            end  

               if y <= 0 
                   uialert(app.UIFigure,"Y2 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif app.y1 <= 0
                   uialert(app.UIFigure,"Y1 value is negative/.please enter a positive value",'invalid y input');
                    return
               elseif x > L1+L2
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               elseif   x < -(L1+L2)
                    uialert(app.UIFigure,"X value out of reach/.please enter a valid value",'invalid x input');
                     return
               else
                   app.th_1EditField.Value =th1;
                   app.th_2EditField.Value = th2;
                   app.th1Slider.Value =th1;
                   app.th2Slider.Value = th2; 
                   app.xEditField.Value = x;
                   app.y2Slider.Value = y;
                   plot(app.UIAxes,[app.x0 app.x1],[app.y0 app.y1],[app.x1 x],[app.y1 y],'linewidth',1.25);    
               end
            
        end

        % Button pushed function: WORKSPACEButton
        function WORKSPACEButtonPushed(app, event)
            % Start with a fresh plot
            cla(app.UIAxes);
            hold(app.UIAxes,'on');
            L1 =app.L1EditField.Value  ; %  the lenght of the first link.
            L2 =app.L2EditField.Value  ; %  the lenght of the second link.
            app.UIAxes.XLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
            app.UIAxes.YLim = [-1.3*(L1+L2) 1.3*(L1+L2)];
for nth1 = 0:2:180  
     for nth2 = 0:2:180 
         x1 = L1 * cosd(nth1);
         
         y1 = L1 * sind(nth1);
             
         x2 = x1 + (L2*cosd(nth1+nth2));
           
         y2 = y1 + (L2*sind(nth1+nth2));

                if y2 >=0
                     plot(app.UIAxes,x2,y2,"*");
                   
                end
            
     end
end
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
            xlist =app.UIAxes.CurrentPoint;
            app.mouseclickedEditField.Value =xlist
          

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 824 572];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.PlotBoxAspectRatio = [1.5702479338843 1 1];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.XMinorGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.YMinorGrid = 'on';
            app.UIAxes.ZMinorGrid = 'on';
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [351 249 448 312];

            % Create th1SliderLabel
            app.th1SliderLabel = uilabel(app.UIFigure);
            app.th1SliderLabel.HorizontalAlignment = 'right';
            app.th1SliderLabel.VerticalAlignment = 'bottom';
            app.th1SliderLabel.Position = [228 387 25 22];
            app.th1SliderLabel.Text = 'th1';

            % Create th1Slider
            app.th1Slider = uislider(app.UIFigure);
            app.th1Slider.Limits = [0 180];
            app.th1Slider.Orientation = 'vertical';
            app.th1Slider.ValueChangedFcn = createCallbackFcn(app, @th1SliderValueChanged, true);
            app.th1Slider.Position = [274 396 3 150];

            % Create th2SliderLabel
            app.th2SliderLabel = uilabel(app.UIFigure);
            app.th2SliderLabel.HorizontalAlignment = 'right';
            app.th2SliderLabel.VerticalAlignment = 'bottom';
            app.th2SliderLabel.Position = [110 387 25 22];
            app.th2SliderLabel.Text = 'th2';

            % Create th2Slider
            app.th2Slider = uislider(app.UIFigure);
            app.th2Slider.Limits = [0 180];
            app.th2Slider.Orientation = 'vertical';
            app.th2Slider.ValueChangedFcn = createCallbackFcn(app, @th2SliderValueChanged, true);
            app.th2Slider.Position = [156 396 3 150];

            % Create xEditFieldLabel
            app.xEditFieldLabel = uilabel(app.UIFigure);
            app.xEditFieldLabel.HorizontalAlignment = 'right';
            app.xEditFieldLabel.Position = [207 269 25 22];
            app.xEditFieldLabel.Text = 'x';

            % Create xEditField
            app.xEditField = uieditfield(app.UIFigure, 'numeric');
            app.xEditField.ValueChangedFcn = createCallbackFcn(app, @xEditFieldValueChanged, true);
            app.xEditField.Position = [244 269 55 22];

            % Create yEditFieldLabel
            app.yEditFieldLabel = uilabel(app.UIFigure);
            app.yEditFieldLabel.HorizontalAlignment = 'right';
            app.yEditFieldLabel.Position = [198 178 25 22];
            app.yEditFieldLabel.Text = 'y';

            % Create yEditField
            app.yEditField = uieditfield(app.UIFigure, 'numeric');
            app.yEditField.ValueChangedFcn = createCallbackFcn(app, @yEditFieldValueChanged, true);
            app.yEditField.Position = [240 180 56 22];

            % Create x2SliderLabel
            app.x2SliderLabel = uilabel(app.UIFigure);
            app.x2SliderLabel.HorizontalAlignment = 'right';
            app.x2SliderLabel.Position = [9 270 25 22];
            app.x2SliderLabel.Text = 'x2';

            % Create x2Slider
            app.x2Slider = uislider(app.UIFigure);
            app.x2Slider.ValueChangedFcn = createCallbackFcn(app, @x2SliderValueChanged, true);
            app.x2Slider.Position = [55 279 150 3];

            % Create y2SliderLabel
            app.y2SliderLabel = uilabel(app.UIFigure);
            app.y2SliderLabel.HorizontalAlignment = 'right';
            app.y2SliderLabel.Position = [1 182 25 22];
            app.y2SliderLabel.Text = 'y2';

            % Create y2Slider
            app.y2Slider = uislider(app.UIFigure);
            app.y2Slider.ValueChangedFcn = createCallbackFcn(app, @y2SliderValueChanged, true);
            app.y2Slider.Position = [47 191 150 3];

            % Create th_2EditFieldLabel
            app.th_2EditFieldLabel = uilabel(app.UIFigure);
            app.th_2EditFieldLabel.HorizontalAlignment = 'right';
            app.th_2EditFieldLabel.Position = [104 324 29 22];
            app.th_2EditFieldLabel.Text = 'th_2';

            % Create th_2EditField
            app.th_2EditField = uieditfield(app.UIFigure, 'numeric');
            app.th_2EditField.ValueChangedFcn = createCallbackFcn(app, @th_2EditFieldValueChanged, true);
            app.th_2EditField.Position = [148 324 55 22];

            % Create th_1EditFieldLabel
            app.th_1EditFieldLabel = uilabel(app.UIFigure);
            app.th_1EditFieldLabel.HorizontalAlignment = 'right';
            app.th_1EditFieldLabel.Position = [233 324 29 22];
            app.th_1EditFieldLabel.Text = 'th_1';

            % Create th_1EditField
            app.th_1EditField = uieditfield(app.UIFigure, 'numeric');
            app.th_1EditField.ValueChangedFcn = createCallbackFcn(app, @th_1EditFieldValueChanged, true);
            app.th_1EditField.Position = [277 324 44 22];

            % Create L1EditFieldLabel
            app.L1EditFieldLabel = uilabel(app.UIFigure);
            app.L1EditFieldLabel.HorizontalAlignment = 'right';
            app.L1EditFieldLabel.Position = [9 533 25 22];
            app.L1EditFieldLabel.Text = 'L1';

            % Create L1EditField
            app.L1EditField = uieditfield(app.UIFigure, 'numeric');
            app.L1EditField.Limits = [-50 50];
            app.L1EditField.Position = [49 533 50 22];
            app.L1EditField.Value = 1;

            % Create L2EditFieldLabel
            app.L2EditFieldLabel = uilabel(app.UIFigure);
            app.L2EditFieldLabel.HorizontalAlignment = 'right';
            app.L2EditFieldLabel.Position = [9 490 25 22];
            app.L2EditFieldLabel.Text = 'L2';

            % Create L2EditField
            app.L2EditField = uieditfield(app.UIFigure, 'numeric');
            app.L2EditField.Limits = [-50 50];
            app.L2EditField.Position = [49 490 50 22];
            app.L2EditField.Value = 1;

            % Create SwitchLabel
            app.SwitchLabel = uilabel(app.UIFigure);
            app.SwitchLabel.HorizontalAlignment = 'center';
            app.SwitchLabel.Position = [21 25 41 22];
            app.SwitchLabel.Text = 'Switch';

            % Create Switch
            app.Switch = uiswitch(app.UIFigure, 'toggle');
            app.Switch.Items = {'elbow down', 'elbow up'};
            app.Switch.Position = [31 83 20 45];
            app.Switch.Value = 'elbow down';

            % Create WORKSPACEButton
            app.WORKSPACEButton = uibutton(app.UIFigure, 'push');
            app.WORKSPACEButton.ButtonPushedFcn = createCallbackFcn(app, @WORKSPACEButtonPushed, true);
            app.WORKSPACEButton.Position = [116 76 100 22];
            app.WORKSPACEButton.Text = 'WORKSPACE';

            % Create ArmConfigurationEditFieldLabel
            app.ArmConfigurationEditFieldLabel = uilabel(app.UIFigure);
            app.ArmConfigurationEditFieldLabel.HorizontalAlignment = 'right';
            app.ArmConfigurationEditFieldLabel.Position = [79 119 102 22];
            app.ArmConfigurationEditFieldLabel.Text = 'Arm Configuration';

            % Create ArmConfigurationEditField
            app.ArmConfigurationEditField = uieditfield(app.UIFigure, 'text');
            app.ArmConfigurationEditField.Position = [196 119 100 22];

            % Create mouseclickedEditFieldLabel
            app.mouseclickedEditFieldLabel = uilabel(app.UIFigure);
            app.mouseclickedEditFieldLabel.HorizontalAlignment = 'right';
            app.mouseclickedEditFieldLabel.Position = [367 178 82 22];
            app.mouseclickedEditFieldLabel.Text = {'mouse clicked'; ''};

            % Create mouseclickedEditField
            app.mouseclickedEditField = uieditfield(app.UIFigure, 'numeric');
            app.mouseclickedEditField.Position = [464 178 100 22];

            % Create EditField2Label
            app.EditField2Label = uilabel(app.UIFigure);
            app.EditField2Label.HorizontalAlignment = 'right';
            app.EditField2Label.Position = [390 127 62 22];
            app.EditField2Label.Text = 'Edit Field2';

            % Create EditField2
            app.EditField2 = uieditfield(app.UIFigure, 'numeric');
            app.EditField2.Position = [467 127 100 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = app2_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end