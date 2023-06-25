#1 Написать функцию, вычисляющую n-ю частичную сумму ряда Телора
(Маклорена) функции exp(x) для произвольно заданного значения аргумента x.

function taylor_exp(x, n)
    result = 1.0  
    term = 1.0  

    for i in 1:n  # Цикл от 1 до n
        term *= x / i  # Вычисляем следующий член ряда
        result += term  # Добавляем текущий член ряда к сумме
    end
    return result  # Возвращаем сумму ряда
end


#2 Написать функцию, вычиляющую значение exp(x) с машинной точностью

function exp_machine(x::T)::T where T 
  value = oneunit(T)
  fact = oneunit(T)
  epsilon = 1e-8 
while abs(x/fact) > epsilon
  value += x / fact # значение текущего члена ряда Тейлора добавляется к общей сумме value
  x *= x 
  fact *= fact + oneunit(T) 
end

return value
end

function exp_ideal(x::T)::T where T
return fast_power(Float64(ℯ),Int(trunc(x))) * exp_machine(x - trunc(x))
end
println("exp(1) = ",exp_ideal(1.0))

#4 алгорим, реализующий обратный ход алгоритма Жордана-Гаусса

function reverse_gauss_first!(matrix::AbstractMatrix{T}, b::AbstractVector{T})::AbstractVector{T} where T
  x = similar(b)
  N = size(matrix, 2)

  for k in 0:N-1
      x[N-k] = (b[N-k] - sum(matrix[N-k,N-k+1:end] .* x[N-k+1:end])) / matrix[N-k,N-k]
  end

  return x
end

#5 алгоритм, осуществляющий приведение матрицы матрицы к ступенчатому виду

function transform_to_steps!(A::AbstractMatrix; epsilon = 1e-7,degenerate_exeption = true)
  @inbounds for k in 1:size(A,1)
      absval, dk = findmax(abs,@view(A[k:end,k]))#max element -> index
      (degenerate_exeption && absval <= epsilon) && throw("вырожденная матрица")
      dk > 1 && swap!(@view(A[k,k:end]),@view(A[k+dk-1,k:end]))
      for i in k+1:size(A,1)
          t = A[i,k]/A[k,k]
          @. @views A[i,k:end] = A[i,k:end] - t * A[k,k:end]#без точек будет копия при всех операциях
          #@. - расставляет точки во всех местах
      end
  end
  return A
end