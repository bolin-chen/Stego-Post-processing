% Input:  x ... cover image
%         y ... stego image
% Output: z ... enhanced stego image
function z = stego_post_process(x, y)
  f = [
    -1, +2, -2, +2, -1;
    +2, -6, +8, -6, +2;
    -2, +8, -12, +8, -2;
    +2, -6, +8, -6, +2;
    -1, +2, -2, +2, -1
  ]; % KV filter
  m = 4; % Post-processing amplitude
  z = y;

  r_x = conv2(x, f, 'full');
  r_z = conv2(z, f, 'full');

  [f_n1, f_n2] = size(f);

  p_r_x = zeros(f_n1, f_n2);
  p_r_z = zeros(f_n1, f_n2);
  p_r_t = zeros(f_n1, f_n2);

  padded_x = padarray(x, [f_n1 - 1, f_n2 - 1]);
  padded_z = padarray(z, [f_n1 - 1, f_n2 - 1]);

  p_padded_x = zeros(f_n1 * 2 - 1, f_n2 * 2 - 1);
  p_padded_z = zeros(f_n1 * 2 - 1, f_n2 * 2 - 1);

  [n1, n2] = size(x);

  for i = 1 : n1
    for j = 1 : n2
      p_padded_x = padded_x(i : i + f_n1 * 2 - 2, j : j + f_n2 * 2 - 2);
      p_padded_z = padded_z(i : i + f_n1 * 2 - 2, j : j + f_n2 * 2 - 2);

      % Skip the pixel that cannot be post-processed
      if isequal(p_padded_x, p_padded_z)
        continue;
      end

      for delta_sign = [1, -1]
        delta = delta_sign * m;

        while (padded_z(i + f_n1 - 1, j + f_n2 - 1) + delta >= 0) && ...
          (padded_z(i + f_n1 - 1, j + f_n2 - 1) + delta <= 255)

          p_r_x = r_x(i : i + f_n1 - 1, j : j + f_n2 - 1);
          p_r_z = r_z(i : i + f_n1 - 1, j : j + f_n2 - 1);
          p_r_t = p_r_z + f * delta; % Try to post-process a pixel

          d_zx = abs(p_r_z - p_r_x);
          d_tx = abs(p_r_t - p_r_x);

          % Update the pixel and its corresponding residuals if the criterion is satisfied
          if all(all(d_tx <= d_zx)) && (~isequal(d_tx, d_zx))
            padded_z(i + f_n1 - 1, j + f_n2 - 1) = padded_z(i + f_n1 - 1, j + f_n2 - 1) + delta;
            r_z(i : i + f_n1 - 1, j : j + f_n2 - 1) = p_r_t;
          else
            break;
          end

        end

      end
    end
  end

  z = padded_z(f_n1 : f_n1 + n1 - 1, f_n2 : f_n2 + n2 - 1);
end
