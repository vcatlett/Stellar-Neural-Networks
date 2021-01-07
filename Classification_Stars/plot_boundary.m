function plot_boundary(alpha,c,n)
    % These functions implicitly plot the boundary
    % up to a fourth-degree boundary
    if n == 1
        fimplicit(@(x,y) alpha(1).*x +alpha(2).*y+alpha(3),'Color', c, 'LineWidth', 2);
    elseif n == 2
        fimplicit(@(x,y) alpha(1).*x + alpha(2).*y + alpha(3).*(x.^2) + alpha(4).*x.*y +alpha(5).*(y.^2)+alpha(6),'Color', c, 'LineWidth', 2);
    elseif n == 3
        fimplicit(@(x,y) alpha(1).*x + alpha(2).*y + alpha(3).*(x.^2) + alpha(4).*x.*y + alpha(5).*y.^2 + alpha(6).*x.^3 + alpha(7).*(x.^2).*y + alpha(8).*x.*(y.^2) + alpha(9).*y.^3 + alpha(10),'Color', c, 'LineWidth', 2);
    elseif n == 4
        fimplicit(@(x,y) alpha(1).*x + alpha(2).*y + alpha(3).*(x.^2) + alpha(4).*x.*y + alpha(5).*y.^2 + alpha(6).*x.^3 + alpha(7).*(x.^2).*y + alpha(8).*x.*(y.^2) + alpha(9).*y.^3 + alpha(10).*(x.^4) + alpha(11).*(x.^3).*y + alpha(12).*(x.^2).*(y.^2) + alpha(13).*x.*(y.^3) + alpha(14).*(y.^4) + alpha(15),'Color', c, 'LineWidth', 2);
    else
        disp('Cannot plot the boundaries (degree too high) \n');
    end
end