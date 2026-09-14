Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58794C88E64
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:In-Reply-To:References:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y91vmKMoOdLcaFzgI2ACEerFdjxGxQVSfGmz+UUqcL8=; b=UobB8xx/YLicpzswKV74pFAS3Z
	6oRlBS4E4JOkuiAw/ScdUT0/1sgBNslXKMqYTcmXKHKnn1/+0Km26gd+GZkQgHy7Nqz/on0CQv47w
	an1VieB7eQEhblTT1qoNPevQPnH+s/PoBKhSwnDggNDHcVoKvldCkioTXgd7XTdvg3pY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x61LB-0006z2-FV;
	Mon, 14 Sep 2026 07:43:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1x61L9-0006yu-BR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 07:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mLaOPZPtHeFP8yY/LDqO0tz3SRNtbajJXM0RKWH8uQ8=; b=fErV8VxfDrDYS7CtVfkSe+C1Fs
 7jpBaTGFA8iIeDKSbWQet4KNSBl6aqFHc4Auwe/m3zzpjH3l2t+FsFTkc1dFmxs0qk5KZqSlubAax
 88oZlc2HzK7L1ou6hEJrsQcOXjtvNVjaThhX1POT+Qwk2X8LFGJitUqGQYoG4NoY3nNU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mLaOPZPtHeFP8yY/LDqO0tz3SRNtbajJXM0RKWH8uQ8=; b=MBHM/Sqy1JrkWlz5TV2ETXWAVF
 aIN3x2xxYMMqry15XjRb6xLLlEYOqlL2uTc+7InZ39n//FgAW4I3v9Sr8BHqV7jsqa8CJAE4WJOkr
 eJfksDOb142OuP3q5RyhMRxTfCNWUj1lc0mKb1pZlpiKanULBFaaOLERt26t28xh19+o=;
Received: from mail-japaneastazon11023134.outbound.protection.outlook.com
 ([52.101.127.134] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x61L7-0006Cv-Ky for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 07:42:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcMEqLqGLFiMcsqy/efnir59nx6lR/PYGaLZtfocLPoMcKipI/r57E2tsRhcQBmBFKqLTjqwyFFPtKxjKpiegQC0f9EOuyuBNQg4WXpzH8+nhxLmp9HYIpgpRZkaEzmwVy8bLzXKxEDEz/Pu7IU4VteNafUnSo0dNR5xjblpU2nlFYj39//0RW2mu1+o7Pc9q12wLCYhHmas1nznwpR8cGGGuPXk+R74onyEeDBaoiOnDSLTHTjoqZYSVeVu9/rjtHDryQuVf6S9f0tPfN2jnqRCDIpCTG+pqwKnP4Jt2t489HDjzqVW2cjQXqHGCIuPo641kGFNrEG3afMdMTKODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLaOPZPtHeFP8yY/LDqO0tz3SRNtbajJXM0RKWH8uQ8=;
 b=zRJQKWALHEcRP1fusZ/7XEvfHqvu3WfqR9G6JcaVhrPThP+iVi3CsJKzYJSUxmViqs9KNsxMqJK9ihMYQPfAB4piZw6LzOhIziwc70eZN/iaz2hrgSuZ5C/bviiGwLUYGWB+15FM67FYgI65LW3580lk6lX7MtSSVfO4wePAnMiAX0mjhnZDuByQXbxXfTeWa3IONxoUbJqP7GMZK0mZfnqVLrVbXKjWuCCjQEOh6O6146+FhUTP0KNHfJG/x341sahUgpQ1GvYg51kH/m2WeGhMcQWA08KfNhyKD2HWj3xevkvmcUV79SzOq1Ea/RaHDaL6hzTKdWODPrp3UQKlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLaOPZPtHeFP8yY/LDqO0tz3SRNtbajJXM0RKWH8uQ8=;
 b=W2afHOrfb0NrIpHime5667wIrR4OZqRKQbd9z8D7ssmxITRUwOd5lUQZeScCI77jY9QbROJfHsv2WGfVEC0u2peMqQcpsxMkh8xMxQp1J07fOOVMPNDt3YFbNqo4wqXBMjE6oLMAY13AYerl7oiMTp6L3nbEf7lK5nDorVPtyTY=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYZPR04MB7908.apcprd04.prod.outlook.com (2603:1096:405:b2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 07:42:48 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:42:48 +0000
From: =?utf-8?B?5p2O54+CMTE=?= <ke.li11@transsion.com>
To: "daeho43@gmail.com" <daeho43@gmail.com>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdRByjvgq1d+cgtUiNBlbw1C1BWw==
Date: Mon, 14 Sep 2026 07:42:48 +0000
Message-ID: <20260914074246.27816-1-ke.li11@transsion.com>
References: <CACOAw_yyfGt58mTk2oUPdqR=CbvHBtMgpfF3NhaN0vvh6EbVnQ@mail.gmail.com>
In-Reply-To: <CACOAw_yyfGt58mTk2oUPdqR=CbvHBtMgpfF3NhaN0vvh6EbVnQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|TYZPR04MB7908:EE_
x-ms-office365-filtering-correlation-id: c35254e6-8539-4e7d-c1f6-08df1233c60e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|42112799006|6133799003|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: O+aN6nnTLN19KdNJXSr55jRab5IWruzOHBTHAQdB044xDhMsxYahydYpDf7CY8OUDmUlbtSaaQKM44mvtoAlOGpyU+VQvcu7x0NCrjmDVpyW4IhIvHAdoE1nsNmlv+OIzqbxSKytWSh9fIWs6T6cLpI5etIWRrT6HgRS9ldbwwGER8d1q6NSOH6OmmcxIxYMOSMDSYldtTDviuwqo+qM8E942+cPfFAAwF9GYxo3SMMkq0JdhNdUKG/GsT4iOkz7acqT6P5Vs2B9Shpd9nrdY18JZAJY2zf9ENYtYZuRSp8eJUBRAb3nZN2PN7X1qDbOlaXUEdYxcJUkMFt85geK2aieXbuB1PFuuEuTbTTVEAUKMx0MBk0fCPchK1+GaclO9E6O6WAvNKvluJvMhodH04euX4sjkcc9FwNKqzyOykl0kF0Leo9AL6ee07CRt2Q9WLEp2tCCA7wkLRmXwaOidnBCDrsfm0b+uoMiWTMuYaUrzNh4ChjjlXkWJOeJRnyZN03XlFDiBWxbGCBJovEg6+n1pWFuZpgfnLwXTOKaZKNrjZ7x5hVxKerngS7wMzWBGW4siI2rFWSqxk4AkVUvf7C0v1ka5kkdexLBKXdkdymsKOIvBzkpJg1JsWzQuZjZZxXCGB131U5AMIzR3m81NrNWXHiJn7MhQGPx3Zdm81JvQzTpXPpNCwBx5yaVaNSd1uoL/O7YXWb8hCSi1In4Up1eq7NrtHzcjj5GtQxO4TE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(42112799006)(6133799003)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVRWNW9mYmxXZ2FHVUNqcXFNV3JoTmI4bVNnMjBUYnZaazNkS3dmY08zNXNM?=
 =?utf-8?B?QWF6QkEvYUQvdTNrb3RvUnYwdkl6QURhRVBvZGIzam5MZE9vM244QWFnamRN?=
 =?utf-8?B?S1gyTUlWQ2JLUlpuczludkl6NXNWa3VPS2t1Qk9wNVB2YlhFUlVZTVlZeTFD?=
 =?utf-8?B?S2VVcFRvZ2s4cWt5MkxrS0JMRXlwdW5INDBRUFJrNGhRV3pSTmVBckdNeEYz?=
 =?utf-8?B?MHJ6enJDMmZnZVp2bWh4a0kyVWNCdTNNVWkwbWxOYkkxaWthUnp0Vm5lWWNY?=
 =?utf-8?B?ZTZ0Q1ZNMWt3bFZMZ2ZzZFJyOFZlWU5nUHVXTTk4NUFESEphN2dZZXJzbnBB?=
 =?utf-8?B?dk1Yd3AweTF0NnJndTgzcUh3aVZvQ3pPMUZOMTU1ZC9rR0pNcGZQOHFGK2ZR?=
 =?utf-8?B?dXZXaks1WkxHbVdDaEtuVlRNTGdsMkpLQ2dHNjNlS0FXenM2ZTQ4OXh0dzU0?=
 =?utf-8?B?bUFzZ1JsbnpVbzlwb3pOTHRmeGxHTFhnRVRqTklyQ2x2cktRYVFVUHVxRkoy?=
 =?utf-8?B?cEdQYXJvQk9oWWdsQkk3czQvREVaK1E1dmJSVWkxZmwzeGI1MWlEWklFR0Ns?=
 =?utf-8?B?UGRBWFdIdEtVcWptV0FOaUthVisybU8wb05nRStOTG5qd2Z0WE9TM3pCSFRi?=
 =?utf-8?B?VkxIRjdMRi9oZmtFb2I0dTdGZ3N4Z0dDSFQ4QzZxMW42UzBYaC9sRGJiZ2RV?=
 =?utf-8?B?M0t1MUFzN0c3UzdJamgwQTlHNWFlTG1RUFpHNnFjdUo3dGp5OHFGNUhHSS9m?=
 =?utf-8?B?UEcwM1daRVZmTC9wREtjZlFOdEMwVTF0bUo4VnJzakRmWllLM2VSMFJTRVEy?=
 =?utf-8?B?ckNrTm1EeWM3ZXJBajN4Wkl1ZTFFYjFCZTk4eGs2WCtWcnU3RmdialorTjd1?=
 =?utf-8?B?RmZNUXQ5cENkU24vcGVjVFEvNXZoL3RFdWl3c3o2K05udVRRdHNoUXZ4aDBt?=
 =?utf-8?B?YXIvK0NaMmVqWUtrVTlqa2YwR1ZoSC9mMkY0VENtT3ZlNWFhajVEODFDamVC?=
 =?utf-8?B?cWNJM1FvL2JYb2tXWnZyeHRkQkxyNlBYeDQ4MFZROWpqWXpPSXZHTkJPUjR3?=
 =?utf-8?B?cEJaQ1hPYzVQbTdLeDZLeS9abVhlVTdwazdJUmZINk00K1AyNS92eGswdUxo?=
 =?utf-8?B?UTZsWkpVcFkxeUlpVVptalIrNE9lbmtSZmlmb1dTa1VPSGpqaXMyNlZXVXhm?=
 =?utf-8?B?YXprWEd0QnVkWDh0ZDV0TG4vSGdYWlRmVWovU2xVeEZ1MmV5T20zSTZrK29T?=
 =?utf-8?B?dWREVm9ycy9lVUFMVkpORHlnVGpPajdOa2EzdTFDZDAwbTVGVDhmMjJ5N2RU?=
 =?utf-8?B?dFJMc3liL05wZXMvamxIYXlvcmJnZzlOdkZ6SDRIT2pwTVJITWFtVGVHbkNW?=
 =?utf-8?B?Zm80T0tRU0F5NkkrUndwVCthZjRXUE90bDg3RW5nbktwQm55OU0wSzQwc3Vo?=
 =?utf-8?B?cVNPSDZSWnVJZmZuNE9IMGNyVXZqTUkwa1pLeTlYMzRnWTN4ek9LalV4UnZF?=
 =?utf-8?B?MXNZdVVyQXVPcGQ2L1o1K2dLRERqUVR6THc1K0c5ajNkUmYxMDNCSWwvUXVv?=
 =?utf-8?B?Z09UcEhJVytrYURJT1dnMFJ3cGxtVXlvak1Qa0ZFNEVqekk4MFMzM0RUNktU?=
 =?utf-8?B?WElrcmdSWDRRZEhiL21sMXFsa2l1MmUvMDJ3Q0c3U0xKcHByZWN3MGg0ZFJq?=
 =?utf-8?B?OXMvbW12TUoxVVFEbFh0Wi9YN09ucmdvY2lYVE5jWS9iYzdtSGJxNi9FdlNq?=
 =?utf-8?B?Z2dCcHR1ZjE3dk1uMUc3dmF4YUcyNzVwY3gwYUhTT1NkN2E0ZmE0OHZvYkpV?=
 =?utf-8?B?Zmg2QXk2WGRMMEdkTmNhUkpDRlAwZzFtUzBNdFdJVmRMS1NYMU5JNm95WW1k?=
 =?utf-8?B?WlREeEVzK0xpSmo0WmRPdUhFUFVGdUFHSml2VWI3dVJlS2kvdnc3OVpTeVBP?=
 =?utf-8?B?NXRWUDZsb0g0TW81R25tM3dDYmZuWWF4NTkwczVzVEFYZ1gyZ3M0akxIcmJq?=
 =?utf-8?B?bzJpSDVFeUFpbm9pcm1WZnJxOTF6V2FoRzFheDZyT2x3UWxHYmZEbEV1MEpz?=
 =?utf-8?B?S0p3ZUFyd0IyOVhuYzZoSlVPbXhTVjBaT28zWkJzWHlEcUJmbDlVZ3lNWE5D?=
 =?utf-8?B?d01OZEk5dDNuYmVzdW5lU1A5NG1Lb2pYN0xBMDBWSnpDRndmci9yeW1ZelRZ?=
 =?utf-8?B?QnJyK0doSWwxYkF1VGszbjRGOEZTdHdrckdFY2dSLzhEN00rcE1ZTTRuZkh3?=
 =?utf-8?B?QldzL204M1BMZ2FuTE1STDA4UVZtL2VNd25yZW1yMURXUlROVVo0VDFJenUy?=
 =?utf-8?B?Rzk3WVMwWDJCQmxkQ2JEN0hBcUVCSHhqVmowdm4xNWFHS2hZSUhPQT09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35254e6-8539-4e7d-c1f6-08df1233c60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 07:42:48.4886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piZqyMxoCyL3FsLcH1srT6Uf10l4B9V8UdUPnUYjZvDcSkh2X9mk0W0nYkgaK9xUPrM9PmY7plWI3wWs7HVsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7908
X-Headers-End: 1x61L7-0006Cv-Ky
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

Thanks for the review and for pointing me to resizable_tail_secno.

I went through that change and also tried it locally. For our case,
resizable_tail_secno can indeed keep pinned allocations out of the
secondary / tail area as well, so it can also address the problem we care
about.

The remaining difference from alloc_primary is mainly about when the policy
applies:

- resizable_tail_secno reserves N sections at the end of the filesystem and
  limits pinned allocation with that tail boundary. Even after the secondary
  device is removed and the filesystem becomes single-device again, that
  restriction remains in effect.

- alloc_primary is a multi-device mount option. It only applies while a
  secondary device is present: it skips the ALLOC_NEXT steering of
  warm/cold/pin allocations onto the secondary, so they stay on the primary.
  After the secondary is dropped, it does not impose an extra ongoing
  restriction.

So resizable_tail_secno can cover "do not allocate into the area that will
be truncated / temporarily attached", but as a persistent tail-boundary
policy. alloc_primary is scoped only to the multi-device phase of our
expandable-storage flow.

For the second patch (allow f2fs_resize_fs to drop the last secondary
device): after a final section-aligned shrink, userspace removes the expand
mapper and the filesystem becomes single-device. Existing f2fs_resize_fs()
can shrink capacity, but it does not clear the last secondary's on-disk
superblock path or detach FDEV[]. On the next mount F2FS still tries to open
that missing block device, and userdata/data mount fails.

So this patch is specifically about making multi-device -> single-device
after shrink remountable: clear the secondary path in the superblock before
commit, and detach the in-memory device only after SB update and checkpoint
both succeed (restore the path if either fails).

Thanks,
ke.li11

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
