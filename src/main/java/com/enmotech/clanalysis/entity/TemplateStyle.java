package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@DynamicInsert(true)
@Table(name = "template_style")
public class TemplateStyle extends Item {

}
