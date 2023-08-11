package com.h1.mycardeepdive.options.domain;

import java.util.Objects;
import javax.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Getter
public class OptionPackage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "option_package_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "option_id")
    private Options option;

    @ManyToOne
    @JoinColumn(name = "package_id")
    private Package _package;

    @Builder
    public OptionPackage(Long id, Options option, Package _package) {
        this.id = id;
        this.option = option;
        this._package = _package;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OptionPackage optionPackage = (OptionPackage) o;
        return Objects.equals(id, optionPackage.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
