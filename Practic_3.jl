#1 Написать функцию проверяющую простоту целого числа (сложность sqrt(n))

function is_prime_number(n::Int64)
    i = 2
    while i < ((sqrt(n)) + 1) # Это условие позволяет ограничить проверку делителей только до корня из n
        if n % i == 0
            return false
            break
        end
        i += 1
    end
    return true
end
println(is_prime_number(101))

#2 Алгоритм "Решето Эратосфена"
function sieve_of_eratosthenes(n::Int64)
    is_prime = ones(Bool, n+1) # булев массив
    is_prime[1] = false # не является простым, поэтому его значение в массиве устанавливается на false

    for p in 2:isqrt(n) 
        if is_prime[p] 
            for multiple in p^2:p:n 
                is_prime[multiple] = false #  Отмечаем все кратные числа p как составные
            end
        end
    end

    primes = filter(i -> is_prime[i], 2:n) # Фильтрация только простых чисел от 2 до n
    return primes
end

primes = sieve_of_eratosthenes(20)
println(primes)

#3 Написать функцию, осуществляющую разложение заданное целое число на степени его простых делителей
function factorize_number(n::Int64)
    primes = sieve_of_eratosthenes(n)
    factors = []
    for prime in primes
        while n % prime == 0
            push!(factors, prime)
            n = n / prime 
        end
    end
    if n > 1 
        push!(factors, n) 
    end
    return factors
end
println(factorize_number(12))