Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05EBC88E75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLqkaiDkAqM80YZmqG4drMR59zNj8uxQL8dg8pEsteE=; b=VSaDS4ofNf+kUCUFXGbRGBfqw0
	AggaL1NiUEQPGRWFxIFaTOijA6Vp4tN0JcHEYrroYOgRvGXNrt9reeNARuHf5F5j9GJFO2Uy+Gcdh
	av5uZbPyK41+/pSCF1CuUjzgF623Pq7aDvaRqxzkLScuAelWGZtQEJgUHaoL03iSagC8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6Iiv-0004fX-NN;
	Tue, 15 Sep 2026 02:16:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x6Iit-0004fQ-Uo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z70Bo7lpAcsRF8s5p7K/2DG6aDCrkS8kgEedyMza0HY=; b=Tmss/ojqChz/eQYIfF1Y61JIUj
 i0p0yHD4bBCRCJmm1EUeTF3fBqP7qZM8r/7NlFkDxoxlAGGnZcwPuIX0uYWIP66cQ4lc3YC4uEIPO
 lFODogxwRTq314vKmbdOuWqHLUNKvYorrx/dTbALfeXRX7AaW99dW5zoXU/r0CVWhCUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z70Bo7lpAcsRF8s5p7K/2DG6aDCrkS8kgEedyMza0HY=; b=Prn6rpyMG6mF04GW38lpXRN06u
 RoXxLikK8nnlIabo9btzZOXDMKBNNadRtRJvFgIbogapkXIYIOZs2KkO3BSvKyHE4dUr1Ky4jfLbv
 ZBef8jDK8HUGOV9lCmkObYFFc7XO2AoJvYdxlD7TIhMMSo5HlvTLsBYkoWlgSTB8jCcw=;
Received: from mail-japanwestazon11022126.outbound.protection.outlook.com
 ([40.107.75.126] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6Iit-0002Jm-CY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 02:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuhNd7truV/LUksjNMR7hI9QzsBapxFtTbBqppFKDoS/tFn9iTG6X3bWnZrN9KZzXLJf+iXGg8r/V+re40OrPM2KFIYFHwMbU5bOgkWrd2YDYRrnfMRzU9k/VtvkJVsMT6ySXAnaDMZnrmvwFYqJUEKblYbve5nIuDokYdAXi7HWbWMj4knKj9g0RMmsaBbsTf7jm9W/u6YObczWNEj8l6e4UJ/DWnp3CKm75S4kysFI0ZlqNHtvcA3GqndwTAyhOT0QGW8S5oaf+Gv2Bu8Hv2HuHKQv5CnJvWqIMO4G2FQeYLY5/Q8dPjFOS0qn5Jf8o2kdfdAvTfaS8xigID9aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z70Bo7lpAcsRF8s5p7K/2DG6aDCrkS8kgEedyMza0HY=;
 b=Mn8epmPRm2nB/eA+Usk2sewK8fTzkNXdQ0MGeH9EWIIRIbFoif4k4E3Czw90jT30COdGHyffHLl6cjZPht/66bE2h8iy079o28QF46p7OEzxKh0HTc3m2N+NVm7mg8Yz9ud/h3tuXHi+9asxB6VLRBB8YTuYqghxVcJAqCQ5xCMFoMdTh0Sa/oT7rXpLbFlQgJsIKtcRtVHDs89/Hnu19qFiH45y6IjntqXV2A5l5UMCkG9juxkouAz17nwk9UqnU9uraZr6G6HdnAzF8I/gZ3zqQJqBJXy5yPUZLiES/MERI9RJMA80JOpFjIBPBtPLUA/A/438oDFgMUdnyyT7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z70Bo7lpAcsRF8s5p7K/2DG6aDCrkS8kgEedyMza0HY=;
 b=dAZQJ/mVCdDjAvA2xRE7RJnPe/Uak1u3u0oJ17lkje8lun02KL6hWk9+dBPnx5WbFhPy3pEw208jSqvjZ4kbW6mEFNCE3PPNkqxMQXCw7VxZlbMLTm1JyNOa7ryw8hWWL47PuwZ21QUu47EVYBlFmg4IufxtbyB17LLD/54sHmk=
Received: from TYZPR04MB6595.apcprd04.prod.outlook.com (2603:1096:400:28c::12)
 by SEYPR04MB7061.apcprd04.prod.outlook.com (2603:1096:101:16c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:01:54 +0000
Received: from TYZPR04MB6595.apcprd04.prod.outlook.com
 ([fe80::3cdd:e95d:2702:a223]) by TYZPR04MB6595.apcprd04.prod.outlook.com
 ([fe80::3cdd:e95d:2702:a223%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:01:54 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BW7bOHWqAgADGtgA=
Date: Tue, 15 Sep 2026 02:01:54 +0000
Message-ID: <20260915020152.1085430-1-ke.li11@transsion.com>
References: <CACOAw_xEPkZWv5zbWQiG6_stjaDZ8MJPtQ64_mwpJeviSDLCLg@mail.gmail.com>
In-Reply-To: <CACOAw_xEPkZWv5zbWQiG6_stjaDZ8MJPtQ64_mwpJeviSDLCLg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB6595:EE_|SEYPR04MB7061:EE_
x-ms-office365-filtering-correlation-id: c9038bc3-e237-40fb-88e6-08df12cd510d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|366016|23010399003|38070700021|56012099006|11063799006|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: OQvPfBtoC1TMAx71l6c564+K8WVXJU4ofmQXfrp0CyFlRpTpWI455Ojxk9FhKA8V/OGBGFj+TyAIB4/XankaQMceYq9GvvCIncCe/OJhElam7WdHG8W7K5HpTwzvsyl/QqRDj1jkVwm81KiVY+g3aVQ9pbM4cB7HXnJMY1ULQ5fy9OqBkbE3ueeQ5MgddhDf36O5T+tVPvBDDk7Y01FjEhNo/S/SOwNLkUOwRiLYry5Op0Eb0U69GW4iel1UAbE8KlzbQZEmKv9IKYdeGw1cvGWRX50TIrzgjj5nV3KCJ4geYIe3VJoRqlE6Wi4jJRIU43uNjaMj0WfKRLJk5lhqjqscr212qRdpV+dUhczbfdlq0Vim0jmxqYNHh9431uvBca/hwSW94jXMEheZ4y4IKZseVoF2OvkGTXrBdoYo1J/dfZHuw3jr5SUVVFi4v0oBbUT5wIyWZx7xPz/CI2gckVEtA8Wk5gaiI2L2hoOObzapI8jEJ4f3fkOfs+ICyM/GTO1WnD7rMG2uZRQp33I7MW75drSQRC5hxZ1R1H/hH5kTXS/IFEo3V8DlJtcysWolHyEfhjtG+9bz/qwh4hzIFrZ0Ebxw5otSgVxEITSR1LvOQYuJaNrL6A5yZec9aniahGqtzJ3FeDu2fGkLF/wDp05KJoPzUdaM4XM/5FHEPVIgFUiWG7p/u9KLNr30Dius6VDZ9LqCuAS/BegTFTpberTaO/q0LbpbJtz2LbnzBCQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR04MB6595.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?blJmbVBuM3ZEQWdBVlFvVFBuS1o2SkhweVVDWHp5cDdVZWNGNnU4MkRT?=
 =?iso-2022-jp?B?ekpnVSthbmVZb0UvcDRxOEc1TGZ0czVwWjhvZWYzT3owOElwSU1QUVFW?=
 =?iso-2022-jp?B?OXZrWFdWRDg1RUxzTkpkNkRuRFVPVTZQYSs0WmtSVkxJVlI5T3pyQ2pL?=
 =?iso-2022-jp?B?ZmdLK2JIRk9xRlFJcU5CSDJ2OE9XUXpTOXVabllFRGZvQ3VORFRiS3RL?=
 =?iso-2022-jp?B?b0NKSjg0U21kaE9lbEluNVhMM0F3Ty9tMWJWbjU5c29NQ0tLUWxicUFu?=
 =?iso-2022-jp?B?bjBmMlFYcTE2aFJlSS9FWWgwUnMrUHBKSTVjYmpFdWxiUklJNWxhMWR0?=
 =?iso-2022-jp?B?WFJpWGZUSk1WUmVYakxKQVZEVTlpR0o3MnFVSzNEVmhHMm05UXFybHZV?=
 =?iso-2022-jp?B?bTdqSTY3L016RE44QjYveTE0QVNQVTBaZk5OeWFkSStkU1R1clptanBP?=
 =?iso-2022-jp?B?Yk1TN2ZaM1JvZitOT3J2dGxTZExHVXJvMGVOREMzcW9KTGtrRlBlNjRK?=
 =?iso-2022-jp?B?V01raHd2WTc0czg3UzdEWWxFYkdBdVM1OGd5L1daVkdhekh2YmdvZjJ6?=
 =?iso-2022-jp?B?VzA0cHVsRCtyRHVsbHB4RmxOaC94L2VqZXBWTHZEekp5QWcwdXU4OE5I?=
 =?iso-2022-jp?B?TktWL2w0ZHJOYWdCbnQyMG9mbEc4RWI3L2Zld3lyNEQ2VU44SC8yY096?=
 =?iso-2022-jp?B?eEg4ZEhlQStPT0hZVy9ZZnVOTUdxZnAwTUQyQWRLN1R0VVZndERaaFBk?=
 =?iso-2022-jp?B?RzBzZFZEWTk3d2hpam1abXVTWE9UMnlGSGloalFtTkdzRkJzQWxESUcz?=
 =?iso-2022-jp?B?RGlJRStETWdyNEFvQ3hjdTRLSkhVNUdLU0pwbzk0L1diakt0VzFuWmRs?=
 =?iso-2022-jp?B?NWJLN1p5c1loMEErSTM5Wng1aXgrK1JNRGxQc2E0QVBjbWhabzh4aXZ6?=
 =?iso-2022-jp?B?TW9hVnJiWUJTVnQ1cWViUUhoN0ZZRjlXL0xKUE02V3RNWGNuaFUxVk1o?=
 =?iso-2022-jp?B?ekwwSk9QcGd2em1RM0ZMcDBpREV5YWd0VEFrWHE1STBUZUQzeVdPbTRq?=
 =?iso-2022-jp?B?cVU2TmxVMmtJVnh1dzlmUHpXK2dNMWpzR05HSy83bHl6RTQ4bFZFQ2oy?=
 =?iso-2022-jp?B?UWJtRFJsNnI4N2ptWi94SUNnbW9sQ2txZC83L0tnL0NPNkJXbnF5UWl5?=
 =?iso-2022-jp?B?eCs5blRpSU91UHZzNmFaTG82NWVUd0lhbTE2OVBUMm9BNXdDSzNZVEdr?=
 =?iso-2022-jp?B?aS9CMVg2VEgyNlJyTkNSZysrMUk5ZnZPemFnNjhwbm1YeUIrTXk5UVJT?=
 =?iso-2022-jp?B?TTFianptRTFxeW91cXR0dlFFdWZBdUc0VldwTlZGMGxJcjlUR2kwUmVI?=
 =?iso-2022-jp?B?ZjNnSnVNWUFHU1Bqa0t0dXRpT2hnNG5oYmtkOVFYUGhRYXpFR3dHZEFL?=
 =?iso-2022-jp?B?K3lMR1YvL3JlSGthaisvQmJQR2lqSEFvaUdlK2JUTGdaM2VPWHpsZDB5?=
 =?iso-2022-jp?B?bEZJK2hDNnFGWk9xd0tadXBpaDdJdG1GM2Qvd3U3R0hWQnBxcE5aNTM1?=
 =?iso-2022-jp?B?TVhZN0VrNmFCTnJwYVliWW1NcTRpRWxLdjRYRStwbVNsZmdIR0xlVzZh?=
 =?iso-2022-jp?B?UmQ5Nm9kbitGWjd4STJXUkdNSW5zbHlVbVhrM0dhOUFxekhaTzVrMUsy?=
 =?iso-2022-jp?B?aGtwMUR4SVdmWGcwTXdFN1NmdUxDSHR3MHhOUS9yWTR0eUlkM1hRRm9i?=
 =?iso-2022-jp?B?aU9vRDhUTm5DcGI0RnpJUzhjcksvbHBodTNJaDFHdmw1bzJIYVV4Vmxr?=
 =?iso-2022-jp?B?S3JHR1dobGwwUlNiZlkwblZsWmtUekpJR2xoeXlBZHZUeFd3TTZxa1g1?=
 =?iso-2022-jp?B?YVZBdisyUWg5SHJrVVAycll6cGZaYnRvSTVlVndQUnN2OHU3L0JMQUFZ?=
 =?iso-2022-jp?B?U2IrZVVKS0JUdEJybjNNS3NsWUlrS1E5cG42K3NYaDU5TGVkU1ZvdmpB?=
 =?iso-2022-jp?B?d0dVRk1QblZnWVJKdzBLWkErU29vUFFzbU1ZKzBoUk9XY0RxTFV0MEI1?=
 =?iso-2022-jp?B?T3UwOCtlY0ZHWnNESU1rbkpwa2FRZmlJYWxKcWQvUUZZelF1Z2t5bGha?=
 =?iso-2022-jp?B?amU0SCtPUjg5czdIMmJ2N3JKNnZ1bVBlWE1RSk5sUCtKa2NvbzZBYXRH?=
 =?iso-2022-jp?B?OUUweDhXU2NxMnJoMUtBL2RHOTJOUlNEUUpSUVFLS0YwQ1kwUmNUdVhH?=
 =?iso-2022-jp?B?L2daMFNYZjFnZ1dvQTFaSGM4M1kvSTBqdGgrN1BDRjBzWG9DYTNnWFZl?=
 =?iso-2022-jp?B?a29yVHgxRXpEZ0pCSDZDcEhWQ2VXWFBwQVV2RjdIM28wTURpdFJQT1pa?=
 =?iso-2022-jp?B?bWMzWFhEVmhvWFdORldCSWtOcm5zYnE3aklSMHhGZzBDWjBzdkc3WFhX?=
 =?iso-2022-jp?B?UWZsaXFCNEQ4NlF6bWVVMUdGVjgzU3Mzb1ZlT2NZTHpEWDhwaTMrdWxU?=
 =?iso-2022-jp?B?NklPUnp3QlNQTU8rd1Nkb1dZTVowRm1wVURHdz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6595.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9038bc3-e237-40fb-88e6-08df12cd510d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 02:01:54.7114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vs7FiJugDTnJP3yXktLCVL9ppOAo+lqjFf3CsHg4nScCGbs2z0+TNnN8AdfKOl0UJQ+yyyuzxD/gDSRiCHsjbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7061
X-Headers-End: 1x6Iit-0002Jm-CY
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

Thanks for the follow-up. Let me clarify the real production use case.

1. Production scenario

On our Android devices, /data is F2FS, and system images live in the super
partition. As OTA payloads grow, the existing super size can become
insufficient for a successful update. To make OTA succeed, we need a way to
dynamically move capacity from userdata to super when required.

To support that, when this solution is integrated we change the partition
table and introduce an expand partition, which is mounted as a secondary
device of /data. So from that point on, /data is a multi-device F2FS layout
by design: primary userdata + expand.

The runtime flow is:

  a. /data is mounted as multi-device with the expand partition attached as
     the secondary device.
  b. When an OTA needs a larger super, userspace shrinks F2FS and reclaims
     capacity from the expand side.
  c. The reclaimed space is merged into the super partition.
  d. After reclaim, /data must remount cleanly. If the expand device has been
     fully reclaimed, /data returns to single-device and must not still
     reference the old expand path in the on-disk superblock.

2. Why not a fixed multi-device setup or existing mechanisms?

- Fixed multi-device:
  Permanently keeping expand attached would leave that capacity inside
  /data. For OTA we need to take space out of userdata and give it to
  super. A fixed multi-device layout cannot satisfy that.

- resizable_tail_secno:
  It helps keep pinned allocations out of a shrinkable tail and makes
  online shrink safer. That is useful, and we can use it together with
  resize. But it does not cover the expand-device lifecycle in this OTA
  flow: after expand is fully reclaimed for super, F2FS must drop that
  secondary device and clear its on-disk path; otherwise the next /data
  mount still tries to open a block device that has already been reassigned
  to super.

- device aliasing:
  Aliasing reserves/releases a range that remains in the filesystem
  address space. Our expand partition is a real secondary block device in
  the partition table, attached to /data so its capacity can later be
  physically repurposed for super. After reclaim, it must no longer be
  referenced by the F2FS superblock.

That is why the two kernel changes are needed for this OTA flow:

- alloc_primary: while expand is attached, keep warm/cold/pin allocation
  on the primary userdata device, so expand capacity can later be emptied
  and given to super.
- resize drop-last-secondary: after a final shrink that removes the expand
  device, clear its superblock path and detach FDEV[], so /data can remount
  as single-device after the space has been moved to super.

Thanks,
Ke Li


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
