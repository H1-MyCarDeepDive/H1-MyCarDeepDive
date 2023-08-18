package com.h1.mycardeepdive.color.domain;

import java.util.List;
import javax.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
public class InteriorColor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "interior_color_id")
    private Long id;

    private String name;

    private long price;

    private String imgUrl;

    private String comment;

    private String interiorImgUrl;

    private double chooseRate;

    @OneToMany(mappedBy = "interiorColor", fetch = FetchType.LAZY)
    private List<ColorCombination> colorCombinationList;

    @Builder
    public InteriorColor(
            Long id,
            String name,
            long price,
            String imgUrl,
            String comment,
            String interiorImgUrl,
            double chooseRate,
            List<ColorCombination> colorCombinationList) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imgUrl = imgUrl;
        this.comment = comment;
        this.interiorImgUrl = interiorImgUrl;
        this.chooseRate = chooseRate;
        this.colorCombinationList = colorCombinationList;
    }
}
