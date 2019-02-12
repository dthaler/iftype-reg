---
title: Guidelines and Registration Procedures for Interface Types
abbrev: ifType Guidelines
docname: draft-thaler-iftype-reg-00
category: std

ipr: trust200902
area: Internet
keyword: Internet-Draft

stand_alone: yes
pi:
  rfcedstyle: yes
  toc: yes
  tocindent: yes
  sortrefs: yes
  symrefs: yes
  strict: yes
  comments: yes
  inline: yes
  text-list-symbols: -o*+
  docmapping: yes
author:
 -
       ins: D. Thaler
       name: David Thaler
       organization: Microsoft
       email: dthaler@microsoft.com
 -
       ins: D. Romascanu
       name: Dan Romascanu
       organization: Independent
       email: dromasca@gmail.com

informative:
  ifType:
    author:
      org: IANA
    title: "ifType definitions"
    date: 2019-02-08
    target: https://www.iana.org/assignments/smi-numbers/smi-numbers.xhtml#smi-numbers-5
  IANAifType-MIB:
    author:
      org: IANA
    title: "IANAifType-MIB"
    date: 2019-02-08
    target: http://www.iana.org/assignments/ianaiftype-mib
  iana-if-type:
    author:
      org: IANA
    title: "iana-if-type YANG Module"
    date: 2019-02-08
    target: http://www.iana.org/assignments/iana-if-type

--- abstract

The registration and use of Interface Types ("ifType" values) predated
the use of IANA Considerations sections and YANG modules, and so
confusion has arisen about the ifType allocation process.  This document provides
updated guidelines for the definition of new Interface Types, for consideration
by those who are defining, registering, or evaluating those definitions.

--- middle


# Introduction {#intro}

The IANA IfType-MIB was originally defined in {{?RFC1573}} as a separate MIB
module together with the Interfaces Group MIB (IF-MIB) module.  The IF-MIB has
been updated and is currently specified in {{!RFC2863}}, but this latest IF-MIB
RFC no longer contains the IANA IfType-MIB. Instead, the IANA IfType-MIB is
now maintained as a separate module.  Similarly, {{?RFC7224}} created an initial
INANA Interface Type YANG Module, but the current version is maintained by IANA.

The current IANA IfType registries are in {{iana-if-type}}, {{IANAifType-MIB}},
and {{ifType}}.

Although the ifType registry was originally defined in a MIB module,
the assignment and use of ifType values are not tied to MIB modules
or any other management mechanism.  Interface Type values can be used
as values of data model objects (MIB objects, YANG objects, etc.),
as parts of a unique identifier of a data model, if any, for a given
interface type (e.g., in an OID), or simply as values exposed by local
APIs or UI on a device.

# Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY",
and "OPTIONAL" in this document are to be interpreted as described
in BCP 14 {{!RFC2119}} {{!RFC8174}} when, and only when, they appear
in all capitals, as shown here.

# Problems

This document addresses the following issues:

1. As noted in {{intro}}, the former guidance was written with wording
   specific to MIB modules, and accordingly some confusion has resulted
   when using YANG modules.  This document clarifies that ifTypes are
   independent from the type of, or even existence of, a data model.

2. The use of, and requirements around, sub-layers and sub-types
   are not well understood even though good examples of both exist.
   This is discussed in {{sublayers}}.

3. Transmission values {{ifType}} have often been allocated as part
   of ifType allocation, but no guidance exists about whether a requester
   must ask for it or not, and the request form has no such required field.
   As a result, IANA has asked the Designated Expert to answer this, but
   no relevant guidance for the Designated Expert has been documented.
   This is discussed in {{transmission}}.

4. Various documents and registries say to submit requests via email,
   but a web form exists for submitting requests, which has caused
   some confusion around which is to be used.  This is discussed
   in {{iana}}.

# Interface Sub-Layers and Sub-Types {#sublayers}

When multiple sub-layers exist below the network layer,
each sub-layer can be represented by its own
row in the ifTable with its own ifType, with the ifStackTable being used to identify the
upward and downward multiplexing relationships between rows.
Section 3.1.1 of {{RFC2863}} provides more discussion, and Section
3.1.2 of that RFC provides guidance for defining interface
sub-layers. More recent experience shows that these guidelines are
phrased in a way that is now too restrictive, since at the time
{{RFC2863}} was written, MIB modules were the dominant data model.

This document clarifies that such guidance also applies to YANG modules.

Some ifTypes define sub-types.  For example, the tunnel(131) ifType
defines sub-types, where each IANAtunnelType can have its own MIB and/or YANG
module with protocol-specific information, but there is enough in common
that some information is exposed in a generic IP Tunnel MIB corresponding
to the tunnel(131) ifType.

For requests that involve multiple sub-layers below the network layer,
requests MUST include (or reference) a discussion of the multiplexing relationships
between sub-layers, ideally with a diagram. Various well-written examples exist of
such definitions, including {{?RFC3637}} section 3.4.1, {{?RFC4087}} section 3.1.1,
and {{?RFC5066}} section 3.1.1.

Definers of sub-layers and sub-types should consider which model is more
appropriate for their needs.  A sub-layer is generally used whenever
either a dynamic relationship (i.e., which instances layer over which other instances
can change over time) or a multiplexing relationship exists with another sub-layer.
A sub-type can be used when neither of these are true, but where one interface
type data is conceptually a subclass of another interface type, as far
as a management data model is concerned.

PROPOSED CLARIFICATION/ELABORATION:
The intent of an interface type or sub-type is that its definition should
be sufficient to identify an interoperable protocol.   In some cases,
a protocol might be defined in a way that is not sufficient to provide
interoperability with other compliant implementations of that protocol.
In such a case, an ifType definition should discuss whether specific
instantiations (or profiles) of behavior should use a sub-layer model
(e.g., each vendor might layer the protocol over its own sub-layer
that provides the missing details), or a sub-type model (i.e., each
vendor might subclass the protocol without any layering relationship).
If a sub-type model is more appropriate, then the data model for the
protocol might include a sub-type identifier so that management software
can discover objects specific to the subtype.  In either case, such
discussion is important to guide definers of a data model for the more 
specific information (i.e., a lower sub-layer or a subtype), as well
as the Designated Expert that must review requests for any such
ifTypes or sub-types.

# Registration

The IANA policy (using terms defined in {{!RFC5226}}) for registration is
Expert Review.  The role of the Designated Expert in the procedure is to
raise possible concerns about wider implications of proposals for use and
deployment of interface types.  While it is recommended for the responsible
Area Director and the IESG to take into consideratoin the Designated
Expert opinions, nothing in the procedure empowers the
Designated Expert to override properly arrived-at IETF or working group
consensus.

## Procedures {#procedures}

Someone wishing to register a new ifType value MUST:

1. Check the IANA registry to see whether there is already an entry that could
   easily satisfy the modeling and functional requirements for the requested entry.
   If there is already such an entry, use it or update the existing specification.
   Text in an Internet-Draft, or part of some other some other permanently
   available, stable specification may be written to clarify the usage of an
   existing entry or entries for the desired purpose.

2. Check the IANA registry to see whether there is already some other entry with
   the desired name.  if there is already an unrelated entry under the name, choose
   a different name.

3. Prepare a registration request using the template specified in {{template}}.
   The registration request can be contained in an Internet-Draft, submitted
   alone, or as part of some other permanently available, stable,
   specification.  The registration request can also be submitted in some
   other form (as part of another document or as a stand-alone document),
   but the registration request will be treated as an "IETF Contribution"
   under the guidelines of {{!RFC5378}}.

4. Submit the registration request (or pointer to document containing it)
   to IANA at iana@iana.org or via the web form at <https://www.iana.org/form/iftype>.

Upon receipt of a registration request, the following steps MUST be followed:

1. IANA checks the submission for completeness; if required information is
   missing or any citations are not correct, IANA will reject the registration
   request.  A registrant can resubmit a corrected request if desired.

2. IANA requests Expert Review of the registration request against the
   corresponding guidelines from this document.

3. The Designated Expert will evaluate the request against the criteria.

4. Once the Designated Expert approves registration, IANA updates {{ifType}},
   {{IANAifType-MIB}}, and {{iana-if-type}} to show the registration.
   When adding values to the ianaiftype-mib, IANA should verify that the updated
   MIB module is syntactically correct before publishing the update.  There are
   various existing tools or web sites that can be used to do this verification.

5. If instead the Designated Expert
   does not approve registration (e.g., for any of the reasons in
   {{RFC5226}} section 3), a registrant can resubmit a corrected request
   if desired, or the IESG can override the Designated Expert and approve
   it per the process in Section 5.3 of {{RFC5226}}.

## Media-specific OID-subtree assignments {#transmission}

The current ianaiftype-mib notes:

>   The relationship between the assignment of ifType
>   values and of OIDs to particular media-specific MIBs
>   is solely the purview of IANA and is subject to change
>   without notice.  Quite often, a media-specific MIB's
>   OID-subtree assignment within MIB-II's 'transmission'
>   subtree will be the same as its ifType value.
>   However, in some circumstances this will not be the
>   case, and implementors must not pre-assume any
>   specific relationship between ifType values and
>   transmission subtree OIDs.

CURRENT: For every ifType registration, the corresponding transmission 
number value should be registered or marked "Reserved."

PROPOSED:
For future ifType assignments, an OID-subtree assignment MIB-II's
'transmission' subtree will be made with the same value.

RATIONALE: (1) This saves effort in the future since if a transmission number
is later needed, no IANA request is needed that would then require another
Expert Review. (2) The transmision numbering space is not scarce, so there seems
little need to reserve the number for a different purpose than what the ifType
is for.

## Registration Template {#template}

This template describes the fields that MUST be supplied in a registration request
suitable for adding to the registry:

Label for IANA ifType requested:
: As explained in Section 7.1.1 of {{!RFC2578}}, a label for a named-number enumeration
  must consist of one or more letters or digits, up to a maximum of 64 characters, and 
  the initial character must be a lower-case letter. (However, labels longer than 32 
  characters are not recommended.) Note that hyphens are not allowed.

Name of IANA ifType requested:
: A short description (e.g., a protocol name), suitable to appear in a comment in the registry.

Description of the proposed use of the IANA ifType:
: Requesters MUST include answers, either directly or via a link to some document
  with the answers, to the following questions in the explanation
  of the proposed use of the IANA IfType: 

  * How would IP run over your ifType? 

  * Would there be another interface sublayer between your ifType and IP? 

  * Would your ifType be vendor-specific or proprietary? (If so, the label
    MUST start with a string that shows that. For example, if your company's
    name or acronym is xxx, then the ifType label would be something like
    xxxSomeIfTypeLabel.) 

  * (ADDED) Would your ifType require or allow vendor-specific extensions?  If so,
    would the vendor use their own ifType in sub-layer below the requested ifType,
    or a sub-type of the ifType, or some other mechanism?

Reference, Internet-Draft, or Specification:
: A link to some document is required.

Additional information or comments:
: Optionally any additional comments for IANA or the Designated Expert.

# IANA Considerations {#iana}

This entire document is about IANA considerations.  

CURRENT:
The registries say to use email, but a web form exists (https://www.iana.org/form/iftype),
which is an apparent contradiction.  Should IANA require using the form?  
Or require using email?  Or accept submisions either way?

PROPOSED:
In addition, IANA is requested to make the following changes:

1. {{IANAifType-MIB}} currently says:
   "Requests for new values should be made to IANA via email (iana&iana.org)."
   This should be updated to instead say:
   "Requests for new values should be made at <https://www.iana.org/form/iftype>
   or by email (iana&iana.org)."

2. {{iana-if-type}} currently says:
   "Requests for new values should be made to IANA via email (iana&iana.org)."
   This should be updated to instead say:
   "Requests for new values should be made at <https://www.iana.org/form/iftype>
   or by email (iana&iana.org)."

# Security Considerations

Since this document does not introduce any technology or protocol,
there are no security issues to be considered for this document
itself.

--- back
