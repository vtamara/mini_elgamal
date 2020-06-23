#!/usr/bin/env ruby
# Pruebas a funciones comunes
# vtamara@pasosdeJesus.org. 2020. Dominio público

require 'minitest/autorun'
require_relative 'comunes'
require 'byebug'

class PruebaComunes < Minitest::Test
  def setup
  end

  def test_inversosmult
    assert_equal(3, inversomult_mod(2, 5))
    assert_equal(2, inversomult_mod(3, 5))
    assert_equal(4, inversomult_mod(4, 5))
  end
 
  def test_exp_mod
    assert_equal(1, exp_mod(1, 5, 5))
    assert_equal(2, exp_mod(2, 1, 5))
    assert_equal(4, exp_mod(2, 2, 5))
    assert_equal(3, exp_mod(2, 3, 5))
    assert_equal(1, exp_mod(2, 4, 5))
    assert_equal(1, exp_mod(2, 20, 5))
    assert_equal(4, exp_mod(2, -2, 5))
  end

  def test_codifica
    assert_equal(97, codifica_cadena_como_numero('a'))
    assert_equal(24929, codifica_cadena_como_numero('aa'))
    assert_equal(6381921, codifica_cadena_como_numero('aaa'))
    assert_equal(1633771873, codifica_cadena_como_numero('aaaa'))
  end

  def test_decodifica
    assert_equal('a', decodifica_cadena_de_numero(97))
    assert_equal('aa', decodifica_cadena_de_numero(24929))
    assert_equal('aaa', decodifica_cadena_de_numero(6381921))
    assert_equal('aaaa', decodifica_cadena_de_numero(1633771873))
  end

end


