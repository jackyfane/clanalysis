/*
 **
 * jqGrid extension for cellediting Grid Data
 * Tony Tomov tony@trirand.com
 * http://trirand.com/blog/ 
 */
;
(function (a) {
    a.fn.extend({
        editCell: function (g, n, u, v) {
            return this.each(function () {
                var c = this, p, j, o;
                if (!c.grid || c.p.cellEdit !== true) {
                    return
                }
                var s = null;
                if (a.browser.msie && a.browser.version <= 7 && u === true && v === true) {
                    n = h(c.rows[g], n)
                }
                n = parseInt(n, 10);
                c.p.selrow = c.rows[g].id;
                if (!c.p.knv) {
                    a(c).GridNav()
                }
                if (c.p.savedRow.length > 0) {
                    if (u === true) {
                        if (g == c.p.iRow && n == c.p.iCol) {
                            return
                        }
                    }
                    var t = a("td:eq(" + c.p.savedRow[0].ic + ")>#" + c.p.savedRow[0].id + "_" + c.p.savedRow[0].name.replace('.', "\\."), c.rows[c.p.savedRow[0].id]).val();
                    if (c.p.savedRow[0].v != t) {
                        a(c).saveCell(c.p.savedRow[0].id, c.p.savedRow[0].ic)
                    } else {
                        a(c).restoreCell(c.p.savedRow[0].id, c.p.savedRow[0].ic)
                    }
                } else {
                    window.setTimeout(function () {
                        a("#" + c.p.knv).attr("tabindex", "-1").focus()
                    }, 0)
                }
                p = c.p.colModel[n].name;
                if (p == 'subgrid') {
                    return
                }
                if (c.p.colModel[n].editable === true && u === true) {
                    o = a("td:eq(" + n + ")", c.rows[g]);
                    if (parseInt(c.p.iCol) >= 0 && parseInt(c.p.iRow) >= 0) {
                        a("td:eq(" + c.p.iCol + ")", c.rows[c.p.iRow]).removeClass("edit-cell");
                        a(c.rows[c.p.iRow]).removeClass("selected-row")
                    }
                    a(o).addClass("edit-cell");
                    a(c.rows[g]).addClass("selected-row");
                    try {
                        j = a.unformat(o, {colModel: c.p.colModel[n]}, n)
                    } catch (_) {
                        j = a.htmlDecode(a(o).html())
                    }
                    var d = a.extend(c.p.colModel[n].editoptions || {}, {
                        id: g + "_" + p,
                        name: p
                    });
                    if (!c.p.colModel[n].edittype) {
                        c.p.colModel[n].edittype = "text"
                    }
                    c.p.savedRow[0] = {id: g, ic: n, name: p, v: j};
                    if (a.isFunction(c.p.formatCell)) {
                        var r = c.p.formatCell(c.rows[g].id, p, j, g, n);
                        if (r) {
                            j = r
                        }
                    }
                    var q = createEl(c.p.colModel[n].edittype, d, j, o);
                    if (a.isFunction(c.p.beforeEditCell)) {
                        c.p.beforeEditCell(c.rows[g].id, p, j, g, n)
                    }
                    a(o).html("").append(q);
                    window.setTimeout(function () {
                        a(q).focus()
                    }, 0);
                    a("input, select, textarea", o).bind("keydown", function (f) {
                        if (f.keyCode === 27) {
                            a(c).restoreCell(g, n)
                        }
                        if (f.keyCode === 13) {
                            a(c).saveCell(g, n)
                        }
                        if (f.keyCode == 9) {
                            if (f.shiftKey) {
                                a(c).prevCell(g, n)
                            } else {
                                a(c).nextCell(g, n)
                            }
                        }
                        f.stopPropagation()
                    });
                    if (a.isFunction(c.p.afterEditCell)) {
                        c.p.afterEditCell(c.rows[g].id, p, j, g, n)
                    }
                } else {
                    if (parseInt(c.p.iCol) >= 0 && parseInt(c.p.iRow) >= 0) {
                        a("td:eq(" + c.p.iCol + ")", c.rows[c.p.iRow]).removeClass("edit-cell");
                        a(c.rows[c.p.iRow]).removeClass("selected-row")
                    }
                    a("td:eq(" + n + ")", c.rows[g]).addClass("edit-cell");
                    a(c.rows[g]).addClass("selected-row");
                    if (a.isFunction(c.p.onSelectCell)) {
                        j = a("td:eq(" + n + ")", c.rows[g]).html().replace(/\&nbsp\;/ig, '');
                        c.p.onSelectCell(c.rows[g].id, p, j, g, n)
                    }
                }
                c.p.iCol = n;
                c.p.iRow = g;
                function h(f, k) {
                    var m = 0;
                    var b = 0;
                    for (i = 0; i < f.cells.length; i++) {
                        var l = f.cells(i);
                        if (l.style.display == 'none')m++; else b++;
                        if (b > k)return i
                    }
                    return i
                }
            })
        }, saveCell: function (h, g) {
            return this.each(function () {
                var b = this, l, c;
                if (!b.grid || b.p.cellEdit !== true) {
                    return
                }
                if (b.p.savedRow.length == 1) {
                    c = 0
                } else {
                    c = null
                }
                if (c != null) {
                    var p = a("td:eq(" + g + ")", b.rows[h]), j, o;
                    l = b.p.colModel[g].name;
                    switch (b.p.colModel[g].edittype) {
                        case"select":
                            j = a("#" + h + "_" + l.replace('.', "\\.") + ">option:selected", b.rows[h]).val();
                            o = a("#" + h + "_" + l.replace('.', "\\.") + ">option:selected", b.rows[h]).text();
                            break;
                        case"checkbox":
                            var s = ["Yes", "No"];
                            if (b.p.colModel[g].editoptions) {
                                s = b.p.colModel[g].editoptions.value.split(":")
                            }
                            j = a("#" + h + "_" + l.replace('.', "\\."), b.rows[h]).attr("checked") ? s[0] : s[1];
                            o = j;
                            break;
                        case"password":
                        case"text":
                        case"textarea":
                            j = htmlEncode(a("#" + h + "_" + l.replace('.', "\\."), b.rows[h]).val());
                            o = j;
                            break
                    }
                    if (o != b.p.savedRow[c].v) {
                        if (a.isFunction(b.p.beforeSaveCell)) {
                            var t = b.p.beforeSaveCell(b.rows[h].id, l, j, h, g);
                            if (t) {
                                j = t
                            }
                        }
                        var d = checkValues(j, g, b);
                        if (d[0] === true) {
                            var r = {};
                            if (a.isFunction(b.p.beforeSubmitCell)) {
                                r = b.p.beforeSubmitCell(b.rows[h].id, l, j, h, g);
                                if (!r) {
                                    r = {}
                                }
                            }
                            if (b.p.cellsubmit == 'remote') {
                                if (b.p.cellurl) {
                                    var q = {};
                                    j = htmlEncode(j);
                                    o = htmlEncode(o);
                                    q[l] = j;
                                    q["id"] = b.rows[h].id;
                                    q = a.extend(r, q);
                                    a.ajax({
                                        url: b.p.cellurl,
                                        data: q,
                                        type: "POST",
                                        complete: function (f, k) {
                                            if (k == 'success') {
                                                if (a.isFunction(b.p.afterSubmitCell)) {
                                                    var m = b.p.afterSubmitCell(f, q.id, l, j, h, g);
                                                    if (m[0] === true) {
                                                        a(p).empty();
                                                        a(b).setCell(b.rows[h].id, g, o);
                                                        a(p).addClass("dirty-cell");
                                                        a(b.rows[h]).addClass("edited");
                                                        if (a.isFunction(b.p.afterSaveCell)) {
                                                            b.p.afterSaveCell(b.rows[h].id, l, j, h, g)
                                                        }
                                                        b.p.savedRow = []
                                                    } else {
                                                        info_dialog(a.jgrid.errors.errcap, m[1], a.jgrid.edit.bClose, b.p.imgpath);
                                                        a(b).restoreCell(h, g)
                                                    }
                                                } else {
                                                    a(p).empty();
                                                    a(b).setCell(b.rows[h].id, g, o);
                                                    a(p).addClass("dirty-cell");
                                                    a(b.rows[h]).addClass("edited");
                                                    if (a.isFunction(b.p.afterSaveCell)) {
                                                        b.p.afterSaveCell(b.rows[h].id, l, j, h, g)
                                                    }
                                                    b.p.savedRow = []
                                                }
                                            }
                                        },
                                        error: function (f, k) {
                                            if (a.isFunction(b.p.errorCell)) {
                                                b.p.errorCell(f, k);
                                                a(b).restoreCell(h, g)
                                            } else {
                                                info_dialog(a.jgrid.errors.errcap, f.status + " : " + f.statusText + "<br/>" + k, a.jgrid.edit.bClose, b.p.imgpath);
                                                a(b).restoreCell(h, g)
                                            }
                                        }
                                    })
                                } else {
                                    try {
                                        info_dialog(a.jgrid.errors.errcap, a.jgrid.errors.nourl, a.jgrid.edit.bClose, b.p.imgpath);
                                        a(b).restoreCell(h, g)
                                    } catch (e) {
                                    }
                                }
                            }
                            if (b.p.cellsubmit == 'clientArray') {
                                j = htmlEncode(j);
                                o = htmlEncode(o);
                                a(p).empty();
                                a(b).setCell(b.rows[h].id, g, o);
                                a(p).addClass("dirty-cell");
                                a(b.rows[h]).addClass("edited");
                                if (a.isFunction(b.p.afterSaveCell)) {
                                    b.p.afterSaveCell(b.rows[h].id, l, j, h, g)
                                }
                                b.p.savedRow = []
                            }
                        } else {
                            try {
                                window.setTimeout(function () {
                                    info_dialog(a.jgrid.errors.errcap, j + " " + d[1], a.jgrid.edit.bClose, b.p.imgpath)
                                }, 100);
                                a(b).restoreCell(h, g)
                            } catch (e) {
                            }
                        }
                    } else {
                        a(b).restoreCell(h, g)
                    }
                }
                if (a.browser.opera) {
                    a("#" + b.p.knv).attr("tabindex", "-1").focus()
                } else {
                    window.setTimeout(function () {
                        a("#" + b.p.knv).attr("tabindex", "-1").focus()
                    }, 0)
                }
            })
        }, restoreCell: function (l, c) {
            return this.each(function () {
                var f = this, k, m;
                if (!f.grid || f.p.cellEdit !== true) {
                    return
                }
                if (f.p.savedRow.length == 1) {
                    m = 0
                } else {
                    m = null
                }
                if (m != null) {
                    var b = a("td:eq(" + c + ")", f.rows[l]);
                    if (a.isFunction(a.fn['datepicker'])) {
                        try {
                            a.datepicker('hide')
                        } catch (e) {
                            try {
                                a.datepicker.hideDatepicker()
                            } catch (e) {
                            }
                        }
                    }
                    a(b).empty();
                    a(f).setCell(f.rows[l].id, c, f.p.savedRow[m].v);
                    f.p.savedRow = []
                }
                window.setTimeout(function () {
                    a("#" + f.p.knv).attr("tabindex", "-1").focus()
                }, 0)
            })
        }, nextCell: function (l, c) {
            return this.each(function () {
                var f = this, k = false, m;
                if (!f.grid || f.p.cellEdit !== true) {
                    return
                }
                for (var b = c + 1; b < f.p.colModel.length; b++) {
                    if (f.p.colModel[b].editable === true) {
                        k = b;
                        break
                    }
                }
                if (k !== false) {
                    a(f).saveCell(l, c);
                    a(f).editCell(l, k, true)
                } else {
                    if (f.p.savedRow.length > 0) {
                        a(f).saveCell(l, c)
                    }
                }
            })
        }, prevCell: function (l, c) {
            return this.each(function () {
                var f = this, k = false, m;
                if (!f.grid || f.p.cellEdit !== true) {
                    return
                }
                for (var b = c - 1; b >= 0; b--) {
                    if (f.p.colModel[b].editable === true) {
                        k = b;
                        break
                    }
                }
                if (k !== false) {
                    a(f).saveCell(l, c);
                    a(f).editCell(l, k, true)
                } else {
                    if (f.p.savedRow.length > 0) {
                        a(f).saveCell(l, c)
                    }
                }
            })
        }, GridNav: function () {
            return this.each(function () {
                var d = this;
                if (!d.grid || d.p.cellEdit !== true) {
                    return
                }
                d.p.knv = a("table:first", d.grid.bDiv).attr("id") + "_kn";
                var r = a("<span style='width:0px;height:0px;background-color:black;' tabindex='0'><span tabindex='-1' style='width:0px;height:0px;background-color:grey' id='" + d.p.knv + "'></span></span>");
                a(r).insertBefore(d.grid.cDiv);
                a("#" + d.p.knv).focus();
                a("#" + d.p.knv).keydown(function (f) {
                    switch (f.keyCode) {
                        case 38:
                            if (d.p.iRow - 1 >= 1) {
                                q(d.p.iRow - 1, d.p.iCol, 'vu');
                                a(d).editCell(d.p.iRow - 1, d.p.iCol, false)
                            }
                            break;
                        case 40:
                            if (d.p.iRow + 1 <= d.rows.length - 1) {
                                q(d.p.iRow + 1, d.p.iCol, 'vd');
                                a(d).editCell(d.p.iRow + 1, d.p.iCol, false)
                            }
                            break;
                        case 37:
                            if (d.p.iCol - 1 >= 0) {
                                var k = h(d.p.iCol - 1, 'lft');
                                q(d.p.iRow, k, 'h');
                                a(d).editCell(d.p.iRow, k, false)
                            }
                            break;
                        case 39:
                            if (d.p.iCol + 1 <= d.p.colModel.length - 1) {
                                var k = h(d.p.iCol + 1, 'rgt');
                                q(d.p.iRow, k, 'h');
                                a(d).editCell(d.p.iRow, k, false)
                            }
                            break;
                        case 13:
                            if (parseInt(d.p.iCol, 10) >= 0 && parseInt(d.p.iRow, 10) >= 0) {
                                a(d).editCell(d.p.iRow, d.p.iCol, true)
                            }
                            break
                    }
                    return false
                });
                function q(f, k, m) {
                    if (m.substr(0, 1) == 'v') {
                        var b = a(d.grid.bDiv)[0].clientHeight, l = a(d.grid.bDiv)[0].scrollTop, c = d.rows[f].offsetTop + d.rows[f].clientHeight, p = d.rows[f].offsetTop;
                        if (m == 'vd') {
                            if (c >= b) {
                                a(d.grid.bDiv)[0].scrollTop = a(d.grid.bDiv)[0].scrollTop + d.rows[f].clientHeight
                            }
                        }
                        if (m == 'vu') {
                            if (p < l) {
                                a(d.grid.bDiv)[0].scrollTop = a(d.grid.bDiv)[0].scrollTop - d.rows[f].clientHeight
                            }
                        }
                    }
                    if (m == 'h') {
                        var j = a(d.grid.bDiv)[0].clientWidth, o = a(d.grid.bDiv)[0].scrollLeft, s = d.rows[f].cells[k].offsetLeft + d.rows[f].cells[k].clientWidth, t = d.rows[f].cells[k].offsetLeft;
                        if (s >= j + parseInt(o)) {
                            a(d.grid.bDiv)[0].scrollLeft = a(d.grid.bDiv)[0].scrollLeft + d.rows[f].cells[k].clientWidth
                        } else if (t < o) {
                            a(d.grid.bDiv)[0].scrollLeft = a(d.grid.bDiv)[0].scrollLeft - d.rows[f].cells[k].clientWidth
                        }
                    }
                };
                function h(f, k) {
                    var m, b;
                    if (k == 'lft') {
                        m = f + 1;
                        for (b = f; b >= 0; b--) {
                            if (d.p.colModel[b].hidden !== true) {
                                m = b;
                                break
                            }
                        }
                    }
                    if (k == 'rgt') {
                        m = f - 1;
                        for (b = f; b < d.p.colModel.length; b++) {
                            if (d.p.colModel[b].hidden !== true) {
                                m = b;
                                break
                            }
                        }
                    }
                    return m
                }
            })
        }, getChangedCells: function (l) {
            var c = [];
            if (!l) {
                l = 'all'
            }
            this.each(function () {
                var b = this;
                if (!b.grid || b.p.cellEdit !== true) {
                    return
                }
                a(b.rows).slice(1).each(function (k) {
                    var m = {};
                    if (a(this).hasClass("edited")) {
                        a('td', this).each(function (f) {
                            nm = b.p.colModel[f].name;
                            if (nm !== 'cb' && nm !== 'subgrid') {
                                if (l == 'dirty') {
                                    if (a(this).hasClass('dirty-cell')) {
                                        m[nm] = a.htmlDecode(a(this).html())
                                    }
                                } else {
                                    m[nm] = a.htmlDecode(a(this).html())
                                }
                            }
                        });
                        m["id"] = this.id;
                        c.push(m)
                    }
                })
            });
            return c
        }
    })
})(jQuery);