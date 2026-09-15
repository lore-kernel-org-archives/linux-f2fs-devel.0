Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAC9C88E53
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERMIZ2h4OaUMTm0/um5cxPsT2bS4YMwtR8Zx0eTgjjs=; b=FbXZVQfA1KFEIkoLz52105yy7l
	wG3TZygkDs8S9z0ktguOepPf7wL3NJJdvz6elmiIqPrD+9KSWFTtDqLyjsa3RLh4eWzT7s+7LF18E
	k+iBdzU/T3VSlv/IQJfOkyQVXNbx1vXQIjW9oaiao7Q7ZlveKhfBffmu6oqPxRDB+CfA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6MeK-0003cE-S1;
	Tue, 15 Sep 2026 06:28:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x6MeK-0003c7-4F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqXK5qL8y864xazacTllVHJQq4s3Me8VIpNlYkxROBU=; b=JcUa0CGCj+5sNEgEtWCxuWvReV
 xR8+ZcICMVgFqdGnJ7+dSCNHS+7zWIkhug3bQagyrdaTV+xPesgTwc0cORWR/u7HKG/tzH7X0TkrH
 TBeMrNssQSbXA9ut6ElIHFYgVTlB7Bzo7q0GPCnM5xPvNUiyb8X94WAPWH4V4ghn6tl4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sqXK5qL8y864xazacTllVHJQq4s3Me8VIpNlYkxROBU=; b=MschOcWWVPcoC27JahpkPUrJca
 FDUSXQb1Rwdq5f6RLbtHp7ZoqRCJQ8L6C1Uhc8W+DfPDLgcYTrhy24Q9sgy0KqZRhrGBFKnTXsLmz
 8VRlcbclTaYaDXTet9O4s5IHM+KVPl4b54EY3HXk3bmHmngfx72JHPyZ9XKR7DmkntWM=;
Received: from mail-japaneastazon11022106.outbound.protection.outlook.com
 ([52.101.126.106] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6MeK-0004Af-7z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA3kWmOk5ffBxQXhDJC0PINGWl/nnA1AD/Sf2B2KZnZu7GdEd21ZWiZWhB5gBplyi+3Myv66P0RbltyAmWipsgzk83931spgudI9wemRO8gmgO4pIwKthUb3xTkIDj22NMa13bKZK5cmqZyfbnMZvLZYTW2EIer4DcN7zsfZd+ifQkyWF/aa6lsWU7yL3DEDHv7wEjynkRs+yUVwYzAVCXi+9GBHOoiOSMRtYPKUN+a+UpeHWzaZr//OByTYrQXB7zW8Cx4J9CoHbqfa964W7lpExHIAAIifxuCXqXQXlNsT5RpOsu7gvNsPh8tRs2iK1DsmhQEAlyS+O00r+e3UJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqXK5qL8y864xazacTllVHJQq4s3Me8VIpNlYkxROBU=;
 b=fE3uQlIa3XiBi4BQ6ScPUP/QXisn41TTaKyZl8MSPO6kV02KI2/hDeNLCIHcMAnj9TdwgpLRRcn3wfV97qOArdos47sLGTK0275+rF0Ui+2tFWo8CNzYRcvDmQJYLnU/fEcDmkiY6UAnk1ujoHD99jX+44oIE+3yg1wsiOq42+VPujSTM2TosGDnlSa5MjViZlgjPnrylbDNpy+0AGSOFJiC74szBwhQQ83DsM2BVjYXkHd+PoHKyoLa3tJMK67WnnUvYy0v5YwTA1hmIxvR7rIWlVXC9UuN3zse/0M8unNQjasQJI1iXVCPrmbhme7CGGvjVbxuo5I+WH3HGwkdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqXK5qL8y864xazacTllVHJQq4s3Me8VIpNlYkxROBU=;
 b=rt6TMfdPatSoayU2hdUj2vsAUqZjH3twpNmm4d9nOUPLg2zLaxqtRIX/2GUzc2zSQjJaK0Z6NTjzqxFyp2bdUI2/FlFQNEDQ90QQjUq9B+/iSnPXGXrY/nKvrkBjI3T/QiBZQzC36Op8m2RcaUAm0uVjy6PfyJ/CyuzcEr0ugN0=
Received: from TYZPR04MB6595.apcprd04.prod.outlook.com (2603:1096:400:28c::12)
 by SEZPR04MB9626.apcprd04.prod.outlook.com (2603:1096:101:338::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 06:28:05 +0000
Received: from TYZPR04MB6595.apcprd04.prod.outlook.com
 ([fe80::3cdd:e95d:2702:a223]) by TYZPR04MB6595.apcprd04.prod.outlook.com
 ([fe80::3cdd:e95d:2702:a223%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 06:28:04 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BW7bOHWqAgADGtgCAABO/AIAANpwA
Date: Tue, 15 Sep 2026 06:28:04 +0000
Message-ID: <20260915062800.1089775-1-ke.li11@transsion.com>
References: <CACOAw_wRYcgKhDe_KfEQUoYWrFOe2cm-ux92ZdiL=-SzH3FXeg@mail.gmail.com>
In-Reply-To: <CACOAw_wRYcgKhDe_KfEQUoYWrFOe2cm-ux92ZdiL=-SzH3FXeg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB6595:EE_|SEZPR04MB9626:EE_
x-ms-office365-filtering-correlation-id: 5fc2f2b2-aeb2-4317-07c8-08df12f27fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|42112799006|23010399003|366016|18002099003|22082099003|38070700021|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: chYzF7+XMpri7+C6kRgHQSGrANYi8LVH/RbnE0G0KVH6s0QiAeCMvZBPorhDQJ3MyG77q3owX8cepcTxN2kUpgXSNKc1o8dk+Gf+vG20H2Ot08AaHaUnjB2zca6d4zxbg6DzLN5dBAggrJ+xCIQcXplutPHt3g8ReQf1PJsZuoyPtkPyAoprVnMJuRZ/bpaQwdV0EQ8NvXdJJ09YuiLXzPCCZ9SefIW4IlA0HLmsAJLXrkSnwI3iwUEU3mG0RXBnQsWzfBnQ/5qqFMC7XD3Q0r4TMoqjIpeXnUgVOdYmnNddZem1PIAWjLpH8dxlpEePtBatTRHK6+q9jdoDs5JN3O/fYyvBQdBtYsPlMmHTRPZJMb4zXfhXmEPerEB8Jf14x/dzsIcD2fXg6cxQSnSum9Tmniq4E2QHkZ2NRcy4e91Fyl8RKKJZ65P/MIDQVi6RMS9+iiNTqF0NdMLM3Bkc16yjvjFZNBhCjXdcFFtA5S4FZVfRLxjDK6PMaIyh26O2hdzbJIB04cPTCsQnOvATyP72b6FArHu/ndbmj8Ya0Wk843NBMQVwGxdKgzrNMq6YT4aZY1JfLnkbHpyKYK532boflCCZfWnsTyIfxDRzY9iChSNzU3V7fpvI7qQydnSjI1beWXozRiyOlWlTVkbEM1ht5NDtnZ6RwoWD9gihZoj1JlzB70oftViw2uNFsi4OHA4YRyjMZcoPfo9vzeJ6FYmQF/LI1+NDNYoBqVY0G8g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR04MB6595.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(42112799006)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NSs0bU4zMkgxN25UZnVkRFZUZ1IycHhDNjNxMVNCamtsdFQ2UmZDWnpj?=
 =?iso-2022-jp?B?ZUVXenh5MXA5bEIvUVVUMXliZGg1bWJtUnJBZnVJa2NSeTNBZ05pWlhB?=
 =?iso-2022-jp?B?N2NwZXpnbkR0dytRRHpIejY5T2o4M0pNclVWalYzVnRBOTN0QTh2MU9z?=
 =?iso-2022-jp?B?V2hrd21pci9ISElYVkl2eDNreXFYcjYwdEg1TnlIcFhYMmJjWnh3a2Vz?=
 =?iso-2022-jp?B?OHVhL0w0MUN1bEZBN2VJb3lZTzVEZ1JmbXQ0S3FKbG54MEpvR2V6QUds?=
 =?iso-2022-jp?B?UmF1T24vN3ZnWFBoZERtZzBNYWpSbWZZb0U3R205c2xaVG8wVWcwaVo1?=
 =?iso-2022-jp?B?SnVhUWZDMVkwZDJXK3Yrb0Qxc2J3S2wxMDhYVStMajB5SFV3by9DTU5Q?=
 =?iso-2022-jp?B?NktLZkN4ckpreW42QTdVeUNBMG1mZzlpN2RjbEtXbkFjTlRUUWNodHY3?=
 =?iso-2022-jp?B?Y0hsWDFtOGc0Mm10UzM3RWRJRStCZUNtVkcwdUsrbnp5Ly9XdUwydHNj?=
 =?iso-2022-jp?B?UlhGSDZ0RkhMTUhkU0NVMDZiVk54bTlrbzZIYU5VblBzMzJLb3lSZWhW?=
 =?iso-2022-jp?B?RUtuOU5hZXpmUm02RTJZbjR5UzdxcWhFYXM0bEF0dE9PYVRmSWEwdU56?=
 =?iso-2022-jp?B?UzVZWVJxR1ZBMGN4NFdSTnlqWFNXY2svS01VVnFLYXpxT1I1RFJUckJk?=
 =?iso-2022-jp?B?eVRZeG56aFFNd3UyOHpzWmRVMURIY1gxZWZjaUxRNWVQUWhZd3VTWG91?=
 =?iso-2022-jp?B?YTVNWEtXanVlUnRpMk14ZzlqQk10SzlZM21TcS9UNy9DT0lGMnJ6NlFv?=
 =?iso-2022-jp?B?a1NERVl3Q05YcC9vemVJM2FTTFhjYlFQZ2I0QjdpaHhyZnNBUVRzZ3dy?=
 =?iso-2022-jp?B?N3ZDdHJ6VDhJbnBrU2pwbFN1c1JRMXJ6eEt1NlBza3QyOUJWQWoxY0Ey?=
 =?iso-2022-jp?B?SEh6K3JjTExUUWg3V2FUd3Z3ak40UGc0aTdNTFIvWDBhYndiRVdhMDl3?=
 =?iso-2022-jp?B?eUYrTHJjajhjZDJ5dDRlRk9SM1VuOTRIQTlWdnpiS2ExYzBaSkl3WGJ2?=
 =?iso-2022-jp?B?bnlhbms1WE03TGtZYzVUWnlYcU5YTUVUb3RQelcraE11WWJ5SjAwa0hM?=
 =?iso-2022-jp?B?NnFsZW9RdjA2Wk53SURwS296NU5xcExXc2NGNzhlSUR1Tml5b0FYbDJ1?=
 =?iso-2022-jp?B?T0lUWU9rdlkwc3h0NFBRbGNYamxhSFg5ZE5hUDdFanZycWJ3ZEdWclNj?=
 =?iso-2022-jp?B?UHd5QmxsU2Rta2pIcytoM1pJOVE2emNwQmJ4SVJvbHlXY1dISmZLU29S?=
 =?iso-2022-jp?B?cEREQnVsZThGVldYb1RFRmI2by9FdmNaa3M4eHlmcSs5Q0tRbXZxc3lD?=
 =?iso-2022-jp?B?V1owZ1RoY0oxK2huY3hyd2lZajhpNEJOdlBobTVKS1RqeEZrb3BIbGhV?=
 =?iso-2022-jp?B?OHF6ME5udkhFL1dFRm5lSHJtc2pNNFlrYXBpN1pWRHJ1SDAreFJtT2JY?=
 =?iso-2022-jp?B?YW5JQXhTZlcyU3lrdnE2elROYTNOODlKSHViVi9RT1NPeDZzVTBGeGxs?=
 =?iso-2022-jp?B?MTVXcnp4dXFaWFllYTZGdTNRVGdxUkZRMmRZUUk0dWZ6NUgzODVZQW93?=
 =?iso-2022-jp?B?SG1YSGUzMU9zUW1pOXA4UE92dnhlVlhmQjBCd3VLWEJWVUxTWTNUdFFI?=
 =?iso-2022-jp?B?MXpobTBFM2IvQ0tQNUdmbjhkRHk2eUZkcFlCR3R0d3NObEhmV09Gby81?=
 =?iso-2022-jp?B?OVBDMkVxNlRGeEFVZnZhK20yaEJCSlNsZmxtWDdXRytCbVpza0ZtWjl3?=
 =?iso-2022-jp?B?MFNFN0VYUVRVTTFvOUI1ZlhGdFVoSStiMU55VnBicUs0ZHZhbG1CaW9s?=
 =?iso-2022-jp?B?VTk2R1RBbUgveEpCUTNOZU44ZU56SVF5aTRkTlg1cXZPanR3VXpCKzNN?=
 =?iso-2022-jp?B?Zk81U0ZBRkxLRnhXeWZTeEZ3ZWluQkhVRDdYK2xOTFh1dzFPTGZxd21t?=
 =?iso-2022-jp?B?Z1F4Q3pLU0FRL2F0SUR5MzBiNTRWRm5pYk9yNndwaW5nVTJwNjVXeXph?=
 =?iso-2022-jp?B?RkVmK3JsTlFTU3VUTk1JdDc4MXdrMWcyRzNtL0w2bEZSeDdCL1BQK0xl?=
 =?iso-2022-jp?B?RGxFZ2xaRHpLNVVqSHYyOFc2TFNVQVhHL0pMNTFYSEVkeFpMb052eVAz?=
 =?iso-2022-jp?B?ODFEUzVRMG5xVnVObHROUGNyclBybzN5WFNjbzhYTkFUSE93Um5GUWdj?=
 =?iso-2022-jp?B?M0ZQTHhjOGdiVDNFaGtqcVdheGNUT0hXdWQ4cVR2bUkxTmliSzJnUHZG?=
 =?iso-2022-jp?B?RzZTSG5odnZBYURic2FOR1UyNThoODVCM0JkQUZXQWl2a3BCM2k0WG84?=
 =?iso-2022-jp?B?UnV4ZEtyaC9rTyttYWdnaGpnM1VMK09pRnBtM3ZGOWZpY1A2QlQxU1RV?=
 =?iso-2022-jp?B?VG9VSTd2TmE1Mlo5bHhMUkdkN2RMREFrT3NaMFBUS0ExWWYxNnBxdDU5?=
 =?iso-2022-jp?B?TlhteFVaUFZMUnhMazJhSFNneDE4KzF2L1J0Zz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6595.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc2f2b2-aeb2-4317-07c8-08df12f27fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 06:28:04.7134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uJ02vXIaU7VPSSMlG3CHGazLqlrqT3Z38aHmQsoCoyfZ08CiJtOl52CNXfuN+lu2Eee+1O+iGNx8w2XD/If6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB9626
X-Headers-End: 1x6MeK-0004Af-7z
Subject: Re: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage
 support
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
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Thanks for the suggestion. We evaluated single-device /data with
resizable_tail_secno and standard resize. It can reclaim a tail in
principle, but it does not fit our production layout.

On our devices, primary userdata is metadata-encrypted under its own
Keystore key; expand is a separate block device with a different key.
We need to reclaim capacity for super without resizing the encrypted
primary userdata device or disturbing its crypto metadata.

Also, reclaimed space must be merged into super at the physical layout
level, so it must be contiguous with super. A single userdata device
puts the reclaimable region at the end of userdata, which is usually not
adjacent to super in our partition table. Reshaping partitions to connect
them is difficult and risky during OTA.

That is why we use an expand partition attached as an F2FS secondary:
primary userdata stays unchanged, expand can sit next to super, and after
shrink we can drop expand from F2FS and assign that space to super.

So resizable_tail_secno is useful, but it cannot replace our expand
secondary flow. We still need alloc_primary and resize drop-last-secondary
for the reasons above.

Thanks,
Ke Li


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
