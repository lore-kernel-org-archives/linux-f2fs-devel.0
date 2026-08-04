Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F15C55172
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qyI4q2/JFlz2ETyxmfZDRLvR9m3hJdAPKO0eOHt/qEs=; b=jzip3RwlEf68AnViiiCaoWvXLn
	qlUxi7etofdCrfckvluNRdN8Fr09JX+l+KUEvbDM1eRScznCq3swMnHkfAKrNF1aPFWpblokWswtj
	QYB1Q8AylDG3kRrSEXXv14KMThGeD9KXQplj3QKamFzFfXSh0nBARjPoXjIMCq/OVuZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr9Pg-0002jA-GK;
	Tue, 04 Aug 2026 07:18:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=1676530e7e=krystian.garlinski@cgi.com>)
 id 1wr9Pe-0002j1-Ts for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 07:18:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9HiYElW8QndXGn8c75RQtuZuOOaX8Ib1ksjfyKkOG7g=; b=T9ZJGIbm2lND9J4lm00cbp4noe
 MVhdG4hPBoQhooauMGJvga/WeAxYZ0tLEB0pWpO3RIhZXg1x13F4Lker00faf5To7ubt3pyQ/pdZD
 0LsbltJypDrxF4UBpv2yfJvkwuZ8d2hKjkBbSDwchqyOlurDvIlIJKBvJlP6o4m3MIaM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9HiYElW8QndXGn8c75RQtuZuOOaX8Ib1ksjfyKkOG7g=; b=i
 qKZUdqBOppdbs03AHDJgVnu/J3uKN0MkGOUkKu3t1xuK2dcq+iv8Ii8nTq6lzVYlDcv37RSvOq2gk
 TW6nTVu7e1fiVCGOJG+Z/Iy5Ncqrlp7FnxqUsMpBrmpExw2+3XAyMunf6P1dyWSTCuK/cALLy1ynj
 SxviOwq8+mDvNYBo=;
Received: from mx0c-00131701.pphosted.com ([67.231.158.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr9PZ-0004Qi-DM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 07:18:08 +0000
Received: from pps.filterd (m0088388.ppops.net [127.0.0.1])
 by mx0c-.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6744tWx82630839
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 4 Aug 2026 07:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cgi.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=cgi-hosted-201911; bh=9HiYElW8QndXGn
 8c75RQtuZuOOaX8Ib1ksjfyKkOG7g=; b=TqBhhU3w1tgtN3qFB5K0/6uEPQDgYK
 fVRz07aqWYgmnODF6fW+FmtHeO2IXBGekX5OCy+yWjU6rwxKLisYAEH5VlSehBCA
 b+HHo99YMLMrooCmpu8bHzNnuT4Mci/4stDN13s9H0DVOk3bPI1cv5Y9aNIKqOEO
 lQZXKR6+fXYxpLeBcNMG23hcenGMYC5Mr5Dw1UWVFGxA6xUnAHnRAQx1v3B8L1v7
 Po74etmN7VkWirycSOO4SOFk1Iabi4vDLW5zf6dGfwz/jh1Tzxof6MkaVgoN1kKz
 9lCcFStTx/+w9N296wlVwVk4+j8gcxLBDC1i32wKBG25c6aUS5mEEZOA==
Received: from yt6pr01cu002.outbound.protection.outlook.com
 (mail-canadacentralazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::3])
 by mx0c-.pphosted.com (PPS) with ESMTPS id 4fu9fy13ne-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Aug 2026 07:04:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqqJ9SO8PTIjCUtGeEFhdM2aBF4cjL/sBE65hHa0XoallzSiim2R7FvCQlLlfmNmN5mWIUg/qtasFEkjTxvR12PH/grg0RQ5MhcUkALcKsFRrTnRpCNUWhSSBsvr8fj0As7rawSX7NicoOXOx1RUrPQA48XGcN5A02yO/pThDFEWzDjgpcYyUXnAZQ8HTpzF/SEwCeJ3JQkbX5j6Hc+MR7agHQYSnZuVRxohKyP8wZqdUkc10sKzR2pc3O6YhVGk9FPC2ct+CYyfbA/vkh1QOEphF74qx77if8IsSpAVNjILa9JIRQnWywDinnhoR/d8/dwtymW0Jbw6SRbNzKoh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HiYElW8QndXGn8c75RQtuZuOOaX8Ib1ksjfyKkOG7g=;
 b=H2ovjzbZpuXcnXI47h6cZ5OH9v5avh1lao+IW2EfIClVUVH+AIQcqVBDYWFil4FDY7xK2CsiCI+LzIkHHxeDDy6c4M753+h49AqS85TxvjHqzBA9/vddL+rUCoofBKOsrQ+SzgUAEh1HUYshIRy3d2IZcnWDs4R+hYvRNWNXLO9hCCvOuOWSur9Gy4Acdcv6FLX6zKaLpmqawFg2Xs3eKsY/bXIlFmfZo3868zDif2jXSHd0Hs5cJSnJyXYuNc+sr8PFSht7rXartbEQ+176YmRnjIGHhpWRAXMbvpPJWGCDx6wZ+MpnxvY3pNjSx9WU514ALKAseAd2nvj9/wM0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cgi.com; dmarc=pass action=none header.from=cgi.com; dkim=pass
 header.d=cgi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GroupeCGI.onmicrosoft.com; s=selector1-GroupeCGI-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HiYElW8QndXGn8c75RQtuZuOOaX8Ib1ksjfyKkOG7g=;
 b=vwcU68A5392dMXK3583NzJglaI3NgwQ/N0CT5d1Dw9L3j1HxRP02Etu4Xna7/DUDI+u8vP+obTLWaGeMOKss6r1v9YW1iSstmrZkaQp+jMyDHJDYVJTjEj18NppJg2Pm71fOA3unLNJOgSD5T2kOfpWs3Y07gEIpqOx8Le3p/OQ=
Received: from YQBP288MB0098.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:70::6) by
 YQBP288MB0811.CANP288.PROD.OUTLOOK.COM (2603:10b6:c01:93::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.16; Tue, 4 Aug 2026 07:04:06 +0000
Received: from YQBP288MB0098.CANP288.PROD.OUTLOOK.COM
 ([fe80::26d4:9446:ef9c:596e]) by YQBP288MB0098.CANP288.PROD.OUTLOOK.COM
 ([fe80::26d4:9446:ef9c:596e%6]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 07:04:06 +0000
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH] mkfs.f2fs: fix parent dentry for lost+found
Thread-Index: AQHdI9786DbZOE+fQ0Wijaf9o/4tZg==
Date: Tue, 4 Aug 2026 07:04:06 +0000
Message-ID: <YQBP288MB009831270521BF40A51BF32C99D42@YQBP288MB0098.CANP288.PROD.OUTLOOK.COM>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_Enabled=True;
 MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_SiteId=b9fec68c-c92d-461e-9a97-3d03a0f18b82;
 MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_SetDate=2026-08-04T07:04:05.836Z;
 MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_Name=Public;
 MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_ContentBits=1;
 MSIP_Label_d9290083-bd2f-48a2-8ac5-09a524b17d15_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBP288MB0098:EE_|YQBP288MB0811:EE_
x-ms-office365-filtering-correlation-id: 76328456-9efa-4435-462f-08def1f692f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|38070700021|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: WPhZSlUrG9OS6n3pt//M+0gaELjyb0Mt2u78mXKWHNoK5jSFHNtM9I+ZqrlFE1nlCIn8PI/q6AfEbp+AVv9D5cUWt7+qOw75+64lZd28BolGhBIqkG59MkZERVF0XNPzz+L2g+WyVoEXnAeM0uPbBH2ZOosGd8C5O1i4ydkVk6tdxfDRlpt4AvW6KZKqgRiGKjztvjNDuV2RxTryvYOHnN0tSzmbZhGY0QSkoLN0I2L4XN61Hewj4f6Ak9wVOF5cLTCg4LgE17WG/CRvarBstmLGybyhZOkF7UmUEHJFNpSM0EAmuPJfjQ0qGxfJXWsebE4A8g++8738xiWWK8kWHs2Ir6F87Xo4hYTQC9PKZYyLOGbHioIbwE6P5PXHsX0a4oT3SuKir5Ts22ANkh4XrAFL8p5D4h8OieV2BPMIrhDtoCginvOTYzDeqDsFFVuf0NbVvSWp33VB/KOu76JsyhStVfGDbEAzfM/qzOfcNE3P8EKI4ELGBxNCDivjMetKrIrpWS5TuLWoFScwOCT/dotWye41Zh5TzvWutsjN6cmyW9SyTy4Dyj9OdDcszktbc6OEL0v6ZZnnlNjJvHvic/W4D8fDjQFMdQ3HFstbaGNHdZfexSYptY5vt1LwmQOm4msVlUiYhpNcKfN1XPvXe7s2s8cyTWgWFiEI/SveXS61BcUxN7sszV8Sg3OVaqKO8nd3jwxdeKkjZdeBnSW4nK0xWNC3u13cnvKOUdJ0sH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBP288MB0098.CANP288.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(38070700021)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?dTAnUlOBKRDjcbC/ehfS53cmVAgkdbtF33vX7uhBp1Txxn+rJP6N9MFSef?=
 =?iso-8859-2?Q?3KEuLLdh0npxrHnbdaZ1IxFKg6Opex7UtF7TZiJ9MPlPbXia9JlxzFBO5Q?=
 =?iso-8859-2?Q?Ir2BvY8yRcuH4xo0pFIVebesNeEmkadOnybGCbA8ZfhYg/aKFPAbyezdp9?=
 =?iso-8859-2?Q?t7gHw9rGYzaEtgafjsc5EeBszjArpjZn0iedPOcR+CI+deIr6BABdda7bS?=
 =?iso-8859-2?Q?7gn0wuI7uZ0HBuk2uOYtllo04qMb7/hUMwPVWOwdd/7WNNDQSGKA0zL3YE?=
 =?iso-8859-2?Q?2i2j7zy1nm/gu1WIcQ2uE+q14TItEvvP3Y1tmovA7Kb/ds2MV1Qr79SFCS?=
 =?iso-8859-2?Q?MDIvoWYTYpZswPwZXLUjyyw/IwjMm4H+QoV18m9sMtrabqjecqXlsYKfoT?=
 =?iso-8859-2?Q?Xxj1m6AR5NVqurX+r4031wyX+92OQUGpL917AyfMGIuNQF/Q8oKit5OfQy?=
 =?iso-8859-2?Q?uj8c+3KG/2IKB72LLoYulgJ1s4o1PcbTc4QRRR4JnlBXXJ2PRskN1c2xYM?=
 =?iso-8859-2?Q?KUaNcxC7uSZFwMYYmMF+VOOeJN2iW4frb8gyuue7l29jF3PJS+LXXiSASG?=
 =?iso-8859-2?Q?R6mDow79lSxxH16YWRXNY3Em05o+j2OSBk9vGgv/hpSNMs8E+CMYJGAiqf?=
 =?iso-8859-2?Q?bj1lJEoKxuk6DL5qg2fqcS+cYrT5ep32TOMDgnM4fpVJJKlmom1OgXsjbf?=
 =?iso-8859-2?Q?JWOX3vOYMN4YJlpxLQJwefNTZ3f8RLwS/l0Gs6UXTrexnUv80Nb/BExpJp?=
 =?iso-8859-2?Q?ebtaRbkVFIztn2+5fefA2oNdwFkUfOQ5BWjDeJQQEE6fpsiYBjw89tSBOx?=
 =?iso-8859-2?Q?V4pcPuKdrPJgnhfl0OjtdNzXjUYyfa02uitrUGX3ND7uKCON3HCxjgFAHg?=
 =?iso-8859-2?Q?0yzB3koWJ1S0K4RIZN+Qzm3zR92KtscBcWOqOIcpv1I0UX/EacL/wErosE?=
 =?iso-8859-2?Q?c+CdpDFaoxUxkLkGhIia5odC/AZzKOewjGdcFSwASj3PIm11Thiw6vjpYH?=
 =?iso-8859-2?Q?6B7mhg45RGrHpXMI6UZL4GuFOwJt9Ge4crYu6xW4H9S3bs9GA+anUxhERa?=
 =?iso-8859-2?Q?EHKhUli17W6DIaoPYqVh0Fyoq7iGyqH8uhBFZu1JrfO35j0KAbBNo3YjOq?=
 =?iso-8859-2?Q?XOimEhmyrfFQlL5rIY80lHznw6iVPO2JitfjtTym35opqAOmNtebWcLfoa?=
 =?iso-8859-2?Q?QFTdpudGfyMvtZRJprUU+4L61MeKTz3oJb0RnIwVnYmi2gXZGDSe68w9SW?=
 =?iso-8859-2?Q?AlA+N9yMQb8P0gbe+TWGl+Z1uN7DPdJZs1j9n1O6X+oHVntlM5STcOtTv0?=
 =?iso-8859-2?Q?NQh0vERgHk1aPim0/IzgWCoTEfPTXNh+bBnxkFO/RMa4Zmst6T2wtEW9I1?=
 =?iso-8859-2?Q?wL8J9c/m2BelPYPN9krukkcSQfRrHfDfcCV4t4J29DziGyzlZ3UB4+RO1C?=
 =?iso-8859-2?Q?YrApcWbCJr8RW79SOdbpCIF2FvsZYBYb9Lv/KGeBfnH7v1aOp0xQbuHzsq?=
 =?iso-8859-2?Q?7gFYuC+tIKyRtUD7UtdeVGn1NpO6McUtJlUBHLUlWc3tNNIEckblaTEk7Q?=
 =?iso-8859-2?Q?aCBvqshZPvCz8E6rBVhsQW+EX4MAzNB2w9rkq7Vf0a3OS6d5oOoQP6v52c?=
 =?iso-8859-2?Q?YiD0qlc19qhGQfEFvhV2ff3mVkGlMhmzTjl4I+HW3OnndHGsoqsIzggI43?=
 =?iso-8859-2?Q?0FICSlSNeQ9GvY4cV7D9jIGxvW1yEvmFmrBppzt9656SEIKcTQZ1KR3tWD?=
 =?iso-8859-2?Q?kxTXsZoTOMBRcHM9644ogPMdT6JgeB9QRwYWa3MNlfnqWGdMGs0OJQyQkY?=
 =?iso-8859-2?Q?UmNWOyciyw=3D=3D?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qPkb26zfYVleIhgclZdJFKm/wC2kxbvn03mW5cVLcBv1mToHN7NgkV6YWhnMI7qG+owc51PwElT7FlEAYYsIIDuRMQSANTQh0kbMFL/6APNdC5Do2QuMjc7frX9ZPVH2tXDCICBP+guvqh8Z73UO/yw4QfhzkkY7gdgPqX8kz/+YX9SE7KPBDaRNkhVuhO6g0es/xrMbIxlD2wEyiS1XIUxRKTYRav/imC01SkdjWgUrSeWr//3vazre5NdCUdQo1tob+KlVxXeRr1BNDJ1q+L1DDar1Y9oQ4n2yKRQDzuQpZnGBayLzquR04lQx8vGjNQUxufvAf78+2g+y/DZNWw==
X-OriginatorOrg: cgi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBP288MB0098.CANP288.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 76328456-9efa-4435-462f-08def1f692f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 07:04:06.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b9fec68c-c92d-461e-9a97-3d03a0f18b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knQz5KJ+nVU8cxsT4lEWam3O5JK7wdmSHuOaNJgX29/0Yb8wr9UVNf6RPyNAikAQmF3mjec6XjnPdPpcocPgDCXavcoZp5G1+Ng0RsdtjOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBP288MB0811
X-Proofpoint-GUID: ZN9QGz_1cQ9E8WXyjvQQAqZGvR-PVYrk
X-Proofpoint-ORIG-GUID: ZN9QGz_1cQ9E8WXyjvQQAqZGvR-PVYrk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX4gteIsqe1M8m
 79zE9iejdYfPSjhQHEyy1xnNAIbpSzQcS5w+l8buVVmXT6a2FolEUzJf9TIGd+uTkTYfBjSXW3K
 j1yS9MsNMJ41YrylbHzuB07CJXoqVp8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX+vO8tfnd0Ha7
 iX18REg3aCDqfSf/ZR5yY63j7f1peDuz19MvlmeJ5J5k0isj0vpuGiaaFXZ248IR84S2IXF9mSn
 gNPotZGm0jCU0BEIYwWKNWEcktD5KeKQyXughw6o7KYwhdNn8Xp//KZgyfP1zeOCvpD8qShDmt9
 d2zkw/4+ASdUb3wzq2QYyyJPqUBp1N7gxYT/tDfY7pa8kWZoRaf3D8RvLdbt5RrSZWNieOQDVtR
 V39Tc8UZJW89smP4YoyDQLvLroFhe6xJf3hd1qNToQEIYC+NuUOajhL5UwvhpvpbecbeSB6nilF
 MTLi+vRU9oYqRL8IO7KL4mII+VV9c56ftIH2FNoDBYiJ9RMPw1v05jnoJNsUlYfwITXHFGo/BmR
 T0rYVe99/M1WbmihnSTyWjTsDXjke8ylYtJM1e4I3C7s4JNtLIbrUa0uV2GjAi5O7cwSy/PG0/f
 wWeW6rqTlw+hjpsJkEA==
X-Authority-Analysis: v=2.4 cv=G8Us1dk5 c=1 sm=1 tr=0 ts=6a718eea cx=c_pps
 a=hWJSLeqL7j3Nbfgu6gzT6A==:617 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=-CRmgG0JhlAA:10
 a=Sv0fKeRqtYgA:10 a=nA2eNw2naV8A:10 a=HJ9SBs4bJl4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=vgj_5vB6CR2rqi3-rg6b:22 a=Bdk0XyhCiKw2F4UCwpBG:22
 a=z6RRvWPPAAAA:8 a=KVDsZ04NCjhm6WrGRfcA:9 a=jiObf9B0YAUA:10
 a=cOeUp16inrYBdoWZErXj:22 a=KpMOFuwLTL43WnxNTDNe:22
X-Headers-End: 1wr9PZ-0004Qi-DM
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: fix parent dentry for lost+found
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?iso-8859-2?Q?Garli=F1ski=2C_Krystian?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?iso-8859-2?Q?Garli=F1ski=2C_Krystian?= <krystian.garlinski@cgi.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The ".." entry of lost+found currently points to lost+found itself,
while the inode's i_pino field correctly points to the root inode.

As a result, a filesystem freshly created by mkfs.f2fs is immediately
reported as corrupted by fsck.f2fs, which validates the ".." entry
against i_pino.

Set the ".." entry to the root inode instead.

Signed-off-by: Krystian Garli=F1ski <krystian.garlinski@cgi.com>
---
 mkfs/f2fs_format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 66f2e4d..33d3da9 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1667,7 +1667,8 @@ static block_t f2fs_add_default_dentry_lpf(void)
 	}
 =

 	add_dentry(dent_blk, &didx, ".", c.lpf_ino, F2FS_FT_DIR);
-	add_dentry(dent_blk, &didx, "..", c.lpf_ino, F2FS_FT_DIR);
+	add_dentry(dent_blk, &didx, "..",
+		   le32_to_cpu(sb->root_ino), F2FS_FT_DIR);
 =

 	data_blkaddr =3D alloc_next_free_block(CURSEG_HOT_DATA);
 =

-- =

2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
