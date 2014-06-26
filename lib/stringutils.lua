function stringf(tmpl,t)
    return (tmpl:gsub('%$([%a_][%w_]*)',t))
end