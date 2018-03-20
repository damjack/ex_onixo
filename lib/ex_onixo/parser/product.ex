defmodule ExOnixo.Parser.Product do
  import SweetXml

  def parse(doc) do
    doc |> xpath(
      ~x"//Product",
      record_reference: ~x"./RecordReference/text()"s,
      notification_type: ~x"./NotificationType/text()"s,
      product_identifiers: [
        ~x"./ProductIdentifier"l,
        product_id_type: ~x"./ProductIDType/text()"s,
        id_value: ~x"./IDValue/text()"s
      ],
      descriptive_details: [
        ~x"./DescriptiveDetail"l,
        product_composition: ~x"./ProductComposition/text()"s,
        product_form: ~x"./ProductForm/text()"s,
        product_form_detail: ~x"./ProductFormDetail/text()"s,
        primary_content_type: ~x"./PrimaryContentType/text()"s,
        product_content_type: ~x"./ProductContentType/text()"s,
        epub_technical_protection: ~x"./EpubTechnicalProtection/text()"s,
        epub_usage_constraints: [
          ~x"./EpubUsageConstraint"l,
          epub_usage_type: ~x"./EpubUsageType/text()"s,
          epubUsageStatus: ~x"./EpubUsageStatus/text()"s,
          epub_usage_limit_quantity: ~x"./EpubUsageLimit/Quantity/text()"s,
          epub_usage_limit_epub_usage_unit: ~x"./EpubUsageLimit/EpubUsageUnit/text()"s
        ],
        collections: [
          ~x"./Collection"l,
          collection_type: ~x"./CollectionType/text()"s,
          title_element_level: ~x"./TitleDetail/TitleElement/TitleElementLevel/text()"s,
          part_number: ~x"./TitleDetail/TitleElement/PartNumber/text()"s,
          title_text: ~x"./TitleDetail/TitleElement/TitleText/text()"s
        ],
        title_details: [
          ~x"./TitleDetail"l,
          title_text: ~x"./TitleElement/TitleText/text()"s,
          title_prefix: ~x"./TitleElement/TitlePrefix/text()"s,
          title_without_prefix: ~x"./TitleElement/TitleWithoutPrefix/text()"s
        ],
        contributors: [
          ~x"./Contributor"l,
          sequence_number: ~x"./SequenceNumber/text()"s,
          contributor_role: ~x"./ContributorRole/text()"s,
          person_name: ~x"./PersonName/text()"s,
          person_name_inverted: ~x"./PersonNameInverted/text()"s,
        ],
        edition_number: ~x"./EditionNumber/text()"s,
        language_role: ~x"./Language/LanguageRole/text()"s,
        language_code: ~x"./Language/LanguageCode/text()"s,
        extent_type: ~x"./Extent/ExtentType/text()"s,
        extent_value: ~x"./Extent/ExtentValue/text()"s,
        extent_unit: ~x"./Extent/ExtentUnit/text()"s,
        subjects: [
          ~x"./Subject"l,
          subject_scheme_identifier: ~x"./SubjectSchemeIdentifier/text()"s,
          subject_scheme_name: ~x"./SubjectSchemeName/text()"s,
          subjec_codet: ~x"./SubjectCode/text()"s,
          subject_heading_text: ~x"./SubjectHeadingText/text()"s,
        ]
      ],
      collateral_details: [
        ~x"./CollateralDetail"l,
        text_contents: [
          ~x"./TextContent"l,
          text_type: ~x"./TextType/text()"s,
          content_audience: ~x"./ContentAudience/text()"s,
          text: ~x"./Text/text()"s,
        ],
        supporting_resources: [
          ~x"./SupportingResource"l,
          resource_content_type: ~x"./ResourceContentType/text()"s,
          resource_content_type: ~x"./ContentAudience/text()"s,
          resource_content_type: ~x"./ResourceMode/text()"s,
          resource_versions: [
            ~x"./ResourceVersion"l,
            resource_form: ~x"./ResourceForm/text()"s,
            feature_type: ~x"./ResourceVersionFeature/ResourceVersionFeatureType/text()"s,
            feature_value: ~x"./ResourceVersionFeature/FeatureValue/text()"s,
            resource_link: ~x"./ResourceLink/text()"s,
            content_date_role: ~x"./ContentDate/ContentDateRoleCode/text()"s,
            date: ~x"./ContentDate/Date/text()"s
          ]
        ]
      ],
      publishing_details: [
        ~x"./PublishingDetail"l,
        publishing_role: ~x"./Publisher/PublishingRole/text()"s,
        publisher_name: ~x"./Publisher/PublisherName/text()"s,
        publishing_status: ~x"./PublishingStatus/text()"s
      ],
      related_materials: [
        ~x"./RelatedMaterial"l,
        work_relation_code: ~x"./RelatedWork/WorkRelationCode/text()"s,
        work_identifiers: [
          ~x"./RelatedWork/WorkIdentifier"l,
          work_id_type: ~x"./WorkIDType/text()"s,
          id_value: ~x"./IDValue/text()"s
        ],
        product_relation_code: ~x"./RelatedProduct/ProductRelationCode/text()"s,
        product_identifiers: [
          ~x"./RelatedProduct/ProductIdentifier"l,
          product_id_type: ~x"./ProductIDType/text()"s,
          id_value: ~x"./IDValue/text()"s
        ],
      ],
      product_supplies: [
        ~x"./ProductSupply"l,
        supplier_role: ~x"./SupplyDetail/Supplier/SupplierRole/text()"s,
        supplier_identifiers: [
          ~x"./SupplyDetail/Supplier/SupplierIdentifier"l,
          supplier_id_type: ~x"./SupplierIDType/text()"s,
          id_type_name: ~x"./IDTypeName/text()"s,
          id_value: ~x"./IDValue/text()"s
        ]
      ]
    )
  end
end
