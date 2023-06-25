Base.oneunit(::Type{Matrix{T}}) where T = [oneunit(T) zero(T) ; zero(T) oneunit(T)] 

#1 Написать обобщенную функцию, реализующую алгоритм быстрого возведения в степень

function pow(a, n :: Int)   # t*a^n = const
    t = one(a)
    while n>0
        if mod(n, 2) == 0
            n/=2
            a *= a 
        else
            n -= 1
            t *= a
        end
    end  
    return t
end

struct Matrix{T}
    a11 :: T
    a12 :: T
    a21 :: T
    a22 :: T
end

#2 На база этой функции написать другую функцию, возвращающую n-ый член последовательности Фибоначчи (сложность - O(log n)) 

Matrix{T}() where T = Matrix{T}(zero(T), zero(T), zero(T), zero(T))

Base. one(::Type{Matrix{T}}) where T = Matrix{T}(one(T), zero(T), zero(T), one(T))

Base. one(M :: Matrix{T}) where T = Matrix{T}(one(T), zero(T), zero(T), one(T))

Base. zero(::Type{Matrix{T}}) where T = Matrix{T}()

function Base. *(M1 :: Matrix{T}, M2 :: Matrix{T}) where T
    a11 = M1.a11 * M2.a11 + M1.a12 * M2.a21
    a12 = M1.a11 * M2.a12 + M1.a12 * M2.a22
    a21 = M1.a21 * M2.a11 + M1.a22 * M2.a21
    a22 = M1.a21 * M2.a12 + M1.a22 * M2.a22
    Res = Matrix{T}(a11, a12, a21, a22)
    return Res
end

function fibonachi(n :: Int)
    Tmp = Matrix{Int}(1, 1, 1, 0) 
    Tmp = pow(Tmp, n)
    return Tmp.a11    
end

#3 Написать функцию, вычисляющую с заданной точностью log_a x 
function logarifm(x::Int64, a::Int64, eps::Int64) # eps - точность вычислений
    y = 0 # хранит приближенное значение логарифма 
    z = x 
    t = 1 
    while (abs(t) >= eps) || (z <= 1/a) || (z >= a)
        if z >= a
            z = z / a
            y = y + t
        elseif z <= 1/a
            z = z*a 
            y = y - t
        else
            z = z*z
            t = t / 2 
        end
    end
    return y # возвращаем приближенное значение логарифма logx по основанию a 
end
println(logarifm(4,2,1))


#4 Написать функцию, реализующую приближенное решение уравнения вида f(x)=0 методом деления отрезка пополам
f(x) = 0
a = 1  # Левая граница интервала
b = 5  # Правая граница интервала
eps = 0.0001  # Точность

function bisection(f::Function, a, b, eps)
    while (b - a) > eps # гарантирует, что мы продолжаем делить интервал пополам до достижения требуемой точности
        c = (a + b) / 2
        if f(c) == 0 # нашли точное значение корня уравнения
            println("Найден точный корень уравнения: ", c)
            return c
        elseif f(a) * f(c) < 0 
            println("Корень находится между ", a, " и ", c)
            b = c
        else
            println("Корень находится между ", c, " и ", b)
            a = c 
        end
    end
    println("Приближенное значение корня: ", (a + b) / 2)
    return (a + b) / 2 
end
println("Ищем корень уравнения f(x) = 0 на интервале [$a, $b] с точностью $eps")
root = bisection(f, a, b, eps)
println("Приближенное значение корня: ", root)