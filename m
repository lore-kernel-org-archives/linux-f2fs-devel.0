Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9734CA5FC4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oXziLwt9JH86RhiXmUv3gl6O6vHQZu6oV8+RA3YUQEk=; b=dl2G6oCGszP0bxdkzOS+4TnP57
	0oyZV2wGAsRIisJR+QbNwuyxIyqDTAzYE5odYnsraJKkxj2VDL9JWKEQeIV+qkbuSAjkFT+0JXtfp
	XWtxB5Zd25HJIpnmh1gdNt3FWOOogxMJkIhPZVhlqo+Q8EB89wYLhoSAZgBPRRoOzgtw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xC6Ct-0007Ry-NR;
	Thu, 01 Oct 2026 02:07:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <caoyudong1@oppo.com>) id 1xC6Cs-0007Rr-Dw
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 02:07:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7JAhNGbBf8dItm2/LTdZ9uzeFeD+YTHh16tb8J/YhJY=; b=jUL4SNdSDApfkbY5sDJPUJ11hH
 FzWCwVs/TQc672ZgZF32EnoQ/CJNlZWuqTKyOuk5jGsZHsKAu+pfw7AdqvKYrfn/UV8rEuoFSjB6f
 kV7UzQWkl2YqvaVnaTiTZkcYwMXMGqFiPWjkmMptdX4tMPbj7SrwGC8hY6LntqevNjx4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7JAhNGbBf8dItm2/LTdZ9uzeFeD+YTHh16tb8J/YhJY=; b=X
 Xawffz99FudNZCg5mz2KephRd1pEonX4ej5VzGe2P7lUUkAjTkQmagRANZ8gkYJU+5Hme8SzJWUdy
 g/y+ITyMq4tp2keLSugpt3AxFwxPklkLegmym87fcMVwz9lJMO8vhQ38NLzD3s5oK1UwSKYfUvwBe
 bqG/LOMyHJfDkLYg=;
Received: from mail-koreacentralazon11013019.outbound.protection.outlook.com
 ([40.107.44.19] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xC6Cq-0004BF-IX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 02:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPrWg4QR4ExHz8QVh02JsicPyInX9vrMhk0CiaXHo/9LrhiJFujH88VxqifANPY6W/qXfGSHnFYCigwKBXdbORfrYbLfIaURsX7so67+tC4y6ttW78zEAlPz0DlGRc3YTORX4hT131AitzHwGto4OPPx4uQh+sIZaCG4yEZu4BQ0u7ketK+86z4gq6KFiZAd74VtmXARf7/4TTdFT7TrlZrCIaSoVgtrWJi6V+6pbQRgyiC6HWV1UQF9sHKHiIjYfxa5gpQfTb21Vpq9h8L5zDUMTOquS+5f8pMV21qsfA2E264u63tQzqoEUMCJ6PwC0WS5PJi42+vQhXyTXb0emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JAhNGbBf8dItm2/LTdZ9uzeFeD+YTHh16tb8J/YhJY=;
 b=Xpy854X+pvBPjYbZowUTpZI3nL4N2w5WYLSXqXbbEDJ1O8VjsFoM5Ui9kl/1LF66at44wsxv4mQueGD5G4lx4X2qiOa60USdg29qwaZaFkR3zowigLO1afUOnuQC+MIdHilk57+qM7GR0Atnff4fSMIQs0hwauZCzJIKcA/H6fuFKcUx0bKVBhLUnmjamv6P4r/GsfEo0yyjBXmBMNcbQIPlXE6oP0sV9BRYrSGP5ilJ4aeUQrH4vBzvh3jWafhjDo3Sr+3krJ/9yPb8bct4JnmF20/aACBYB9oCT64e07F8QJmlcIdjIvwjAUcP4TerZ2ch0pXHSwFFAWV8su2K8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JAhNGbBf8dItm2/LTdZ9uzeFeD+YTHh16tb8J/YhJY=;
 b=hvCUKPCUWaGVBe5VsbnocDz3CU3gJHB2zvd6qKvqgmtgBppbKdrevyuiF87EAMRbPOMwrMtbcjsq3UG+EDacY64+7NZ5c9+JIua6pAnHb7i987sz48EEfIjR4CPCDiq4jngalrHx0XLEWb2bMad5ZA34/3LywI3tAoaFxjujJ6g=
Received: from KL1PR02MB5156.apcprd02.prod.outlook.com (2603:1096:820:7b::14)
 by TYUPR02MB6273.apcprd02.prod.outlook.com (2603:1096:400:345::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:32:23 +0000
Received: from KL1PR02MB5156.apcprd02.prod.outlook.com
 ([fe80::40d6:c46b:6856:d5fd]) by KL1PR02MB5156.apcprd02.prod.outlook.com
 ([fe80::40d6:c46b:6856:d5fd%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 01:32:23 +0000
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: RFC: f2fs: file-level deduplication and fixed-output compression
Thread-Index: Ad1RQ9SSQE4E7SacSPGYCnu9nOQhxA==
Date: Thu, 1 Oct 2026 01:32:22 +0000
Message-ID: <KL1PR02MB515693E46BC391F3CD7D22F3E78A2@KL1PR02MB5156.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR02MB5156:EE_|TYUPR02MB6273:EE_
x-ms-office365-filtering-correlation-id: 91585f70-7b18-4585-6746-08df1f5bd797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|6133799003|3023799007|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: BKpCt6phACl58WDn4Y6QHjzvaZtQ5iLP27mY5uvJa12NGJ6htlOJ9nwEtLFUF55ipnUtM5Yfuffw3e8NaCXY7MQ1wj3CnJOzZ+TLQiyllvaUk2HQRgwJfX9AEdD38KmI/j8Q/vt8gB5P72paMU/crlbx25ND+VcPnkAoBN23jx4dOdsVU5lH5A59SBkHz9T9zPOjRvkleU1Q+7Li1QLiIomc4NxCGz1CNtYWseTGqOUzIU1knBBqOfsLH+in0haA/RnSuK80nzExvsBaP5emfqLA6ZFE+XHikrkSwj4vLgSzimDWw/kuiYQP9oGxQ+/1W49qBADa+EJqJz1VyYjX0Rj96OwpUJQB70X9L7TEE81q+QJ41tZ3YgHi79JTEWZh0nWbp/F10i5dMw69TtfGgcx7M3Q4r2sJslJpZxkinXI++c9+8BC3dn+Wke5r+JjLkGfXynG/muWhjKIjXkI4g8a4tbsO1w5LMwJlTXsNWG9lV6UljSJ5kPoplrk4vX+VeoxMqZFvdijKCgKl4bely9KSkLoV5+kkn9EgoLm6aMin8/n7Mv/2h2RlqqnOS4SEmEdFCPzEYVnxCFZjFuuPQTuWVFAFJTgDVtNEfPZ3PT3BSBoQ/CLiZnMO0f6kwnima6uC8gX7gIW/zwF/hnEczy3sxr5b7uHnX3CNrE0RCVhEP+tpp+hZEdDvR6tUZvynzUKhfvF/h3H1oodmbrJkhwBzw6EIew+dadmjVtdVCEw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR02MB5156.apcprd02.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(6133799003)(3023799007)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Zk45MmV6eW5YUkllYnJKNFpoMFRPblQxOHQ4d3hPQ1dMYUJvcFZqNjZzWjFH?=
 =?gb2312?B?cUFmUGd3NG43OU9ESWd1RHNnWllJYnEwaWpnN3Jha09SQXhkaUp5VXNoVDFr?=
 =?gb2312?B?bkVTZ1prUkdvdVBFSm1VdVV5OTFzNkJiTDZ2L0dUMmVKcmE1K2I5VUFxeE5a?=
 =?gb2312?B?MGhRWUx4RndHczRUWkZUYkt2U0RBaFNodWtuK0tldm44eHA2YzFVTk15cUFC?=
 =?gb2312?B?RUJHdEgxRDJxdk1PLy9ZM3ptMVppa05MRVRTd2pwN0l2Mlp2L2hyRVR0alJZ?=
 =?gb2312?B?Uno2eVpJcU4wS2RrZlhlNXNzVGV1ZmRCb1NUYUNHZ05KcVdCWGVRUE1wQi96?=
 =?gb2312?B?ZElTdkQ1bzA4dGhxS1RBQ09vWGRubHdHYk03eUhMZXcvcmV2N3JLdkdtYWNa?=
 =?gb2312?B?SjBOY3JWTmRBRCtFY1NGUGFJSFVoZFdJcHJMZTdoNy9VK0Q3aWppVFRpSlps?=
 =?gb2312?B?RmJRRW4xSUxNYTdoRjZHQTJRREFPUXkwNUpLaEo0ZUhqVlloRjZTK0g0SlQ0?=
 =?gb2312?B?UmRpcmZKb01kT3JsSkZ2bE1ZY2lyVTg2RnJ2eE1nZnloYWdHRGQ1ZGNoMzlQ?=
 =?gb2312?B?WjhsUGVvWVdKR1c1a1NwQkpNeHhWbSt2Z0kxRkpzeEtIWDdPZ0tVSGNEOVJL?=
 =?gb2312?B?Y0JSM3J6S2lzZTR6eU5iakVOR1BWaUpVcXNlVnd2RERaVC96c0hSVXJzWFh1?=
 =?gb2312?B?ckM1NG5abFIrbHd1dGtNTDQ4YkloVEMzYU9hamdkSUVCVzJ6a0MxYTJqWXFX?=
 =?gb2312?B?V2xMaGxyWHF6L3FxMEdnbzNCeWJVdVZTT1pPQmlNQzFvNitsOVpaM1IxTEdw?=
 =?gb2312?B?bUZlUXJyazJ6NXo2czFKMHZDejllZGd5UkNLYlVMSEhqaFlldExRU1ZZWkdx?=
 =?gb2312?B?NTVmVzJubjE3bnVqb3pYSDhOWTR3STFmZEVTR1JTeTYrVlFYZi9kYnFQdUZS?=
 =?gb2312?B?WWRhdnRla1BnUHQ4OUtGK1d3TGJ3cGhaUkwzSUthT293MUlROWIyTHI2ODhC?=
 =?gb2312?B?ektxQ2hScEpsK01MRFpmZWpHREM3b0ZQbUpEZldmR2kwMHJXa29PRGhPNmRi?=
 =?gb2312?B?cGhrUzROUTZObWtUTG85VHhQSDNMb0tBSE9oM3E2UldFT0FYN2tUWDBkRVl4?=
 =?gb2312?B?Z2h2YmV4TkcwdFlJQ0s1SUtFWkF3YzdyUTZEaFdOcnM3ckp4L3BKZ0J4c1J4?=
 =?gb2312?B?SG5JNFNOOTNNU3MrM1pCYTZVdkszNXFTckp3VXh2cW5CL1FTS3g2cCsyTHRT?=
 =?gb2312?B?d3ZNT3lhbStuVzA4VU5LaHRwWlRzR0JtNFdLdm8zb1FzMkJxcVVmc1RPTVps?=
 =?gb2312?B?cSt0OCtuTzBiUE02TkdSTFp2Uk4rdHhxK3U5eCszT0E0L2ZHdWtrMEh0Zjhm?=
 =?gb2312?B?bGx4SXIzM0wvclMyWjlPeklTdEt0UElwalVQbzlXR05ON29QR2tmQy9wQmJT?=
 =?gb2312?B?TWh6N0hFSERYT09FYmJYbUtIR1A5Zk9ucmxDak90S1FJWGQvOVNUMWxaQ2Rr?=
 =?gb2312?B?cnVnMkxhVTZtQVJNdm9xY21HMlVnK2lNMXdWakcvU01iZGh2SVMwUkZ1WXJk?=
 =?gb2312?B?ak9GWXAvK2RkcGhtVVlVTVlCb01TQ3ByYlpzNTdad2kzVWc3YUxxeW9BNVpw?=
 =?gb2312?B?b3BrS3pUaDZFY1BZcUhsSXlNMFo0RVp4aWZQZzVkMEFwRlM4UFRZeU5QTExY?=
 =?gb2312?B?VjdXeFdiSXMvTzJzcENZVXMyRFN3VDVXQzltRzZndFl5cU9YRm9lMXJzckd3?=
 =?gb2312?B?dFRxc2Yza29LZTdJRVE0cDR2dGxzSW5RdENXU2VndytDdzI0QjVScVFBVnUr?=
 =?gb2312?B?OTJ1L0JsUVVML0RqRlc3QU9hMDh5TUZpaFE4ell6Vm9wc050c3JMSEpYZGk5?=
 =?gb2312?B?VzBhbndMWHloQXBBTEpaSGxNL3UxRHZzWGJCM2lOTlFPTDBKMlZQU3ZtazRi?=
 =?gb2312?B?YTg2T25HNjJOekpnTWcwOEpVZDZ5Y2lmNVJZbUtxdVdXQk5mQmJFNzVpNVM4?=
 =?gb2312?B?K0VMK2JKeVVMOGRIM3RleDN4eXRIMFpjd2tPSlBCNCtNY3lHUjNHWURBckt3?=
 =?gb2312?B?NGd1V2NxcXZRVUxOL0xzQ1JwNzNjU1F4VDEvSHNqQVcyWWZuM0JVMUMxdXpY?=
 =?gb2312?B?aUUxZElsaWxCS3Mrakw3NUF2bWl5SkNoWlRZaHc4WkNVZGRFZ2hsUjhGYmJz?=
 =?gb2312?B?VnRqbHBCWlBybWo2NXpMWnIyTGR3SkoxWFJ6RWJoU3hCUHhuUUlJTFdFOHN0?=
 =?gb2312?B?M2JOK2MrdkQwMUM1dnNpb0laUFZvSnIzM1h6WjQ3R05OSlpVZTJaWXVnWHNH?=
 =?gb2312?B?U2xUSnFFQlFnMU9aZm05K0xHMmJPQ3o3d2lyRmR5RlRpVEdwRGRZZz09?=
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB5156.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91585f70-7b18-4585-6746-08df1f5bd797
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:32:22.8797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S740wrIOa0ehfICmBDrAccc/abSotJ8EP2DGgbAzAm6CwfxDlgo0cfXxRZ1sePFhlu1UlJngfbw//vGaC8dI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR02MB6273
X-Headers-End: 1xC6Cq-0004BF-IX
Subject: [f2fs-dev] RFC: f2fs: file-level deduplication and fixed-output
 compression
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
From: =?gb2312?B?stzT6rasKFl1ZG9uZyBDYW8p?= via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: =?gb2312?B?stzT6rasKFl1ZG9uZyBDYW8p?= <caoyudong1@oppo.com>
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGksDQoNClRoaXMgUkZDIGRlc2NyaWJlcyB0d28gcmVsYXRlZCBGMkZTIGVuaGFuY2VtZW50cyB3
ZSBpbnRlbmQgdG8gc3VibWl0IGFzDQpwYXRjaGVzOiBmaWxlLWxldmVsIGRlZHVwbGljYXRpb24g
KGxheWVyZWQgaW5vZGUpIGFuZCBhbiBvcHRpb25hbA0KZml4ZWQtb3V0cHV0IGNvbXByZXNzaW9u
IGxheW91dC4NCg0KVGhpcyBtYWlsIGlzIGRlc2lnbiBjb250ZXh0IG9ubHk7IG5vIGNvZGUgaXMg
YXR0YWNoZWQuIFdlIHdpbGwgZm9sbG93IHVwDQp3aXRoIGEgW1JGQyBQQVRDSF0gc2VyaWVzIGJh
c2VkIG9uIHRoZSBjdXJyZW50IGYyZnMgdHJlZS4NCg0KSW1wb3J0YW50OiBib3RoIGZlYXR1cmVz
IGFyZSBvZmYgYnkgZGVmYXVsdC4gVGhleSBhcmUgaW5kZXBlbmRlbnQNCmFuZCBjYW4gZWFjaCBi
ZSBlbmFibGVkIG9ubHkgd2hlbiBuZWVkZWQ6DQoNCiAgLSBDT05GSUdfRjJGU19GU19ERURVUCAg
ICAgICAgICAgICAgICAgICAgIGRlZmF1bHQgbg0KICAtIENPTkZJR19GMkZTX0ZTX0NPTVBSRVNT
SU9OX0ZJWEVEX09VVFBVVCAgZGVmYXVsdCBuDQogICAgKGRlcGVuZHMgb24gZXhpc3RpbmcgQ09O
RklHX0YyRlNfRlNfQ09NUFJFU1NJT04pDQoNCiAgRGVmYXVsdCBta2ZzL21vdW50IGJlaGF2aW9y
IGlzIHVuY2hhbmdlZC4gRW5hYmxpbmcgZGVkdXAgZG9lcyBub3QNCiAgcmVxdWlyZSBlbmFibGlu
ZyBmaXhlZC1vdXRwdXQsIGFuZCB2aWNlIHZlcnNhLg0KDQoNCjEuIE1vdGl2YXRpb24gLyBleHBl
Y3RlZCBiZW5lZml0cw0KDQphKSBGaWxlLWxldmVsIGRlZHVwbGljYXRpb24gKGxheWVyZWQgaW5v
ZGUpDQoNCiAgIE1hbnkgZGVwbG95bWVudHMgc3RvcmUgbGFyZ2UgbnVtYmVycyBvZiBpZGVudGlj
YWwgb3IgbW9zdGx5LWlkZW50aWNhbA0KICAgZmlsZXMgKHNoYXJlZCBsaWJyYXJpZXMsIGFwcCBh
c3NldHMsIGNvbnRhaW5lciBsYXllcnMsIGV0Yy4pLiBBDQogICBmaWxlLWxldmVsIGRlZHVwIG1l
Y2hhbmlzbSBjYW46DQoNCiAgIC0gcmVkdWNlIGNhcGFjaXR5IHVzZSBieSBzaGFyaW5nIGRhdGEg
YmxvY2tzIGFjcm9zcyBmaWxlczsNCiAgIC0ga2VlcCBhIG5vcm1hbCBkaXJlY3RvcnkvbmFtZXNw
YWNlIHZpZXcgKGVhY2ggcGF0aCByZW1haW5zIGl0cyBvd24NCiAgICAgaW5vZGUpIHdoaWxlIHBv
aW50aW5nIGF0IHNoYXJlZCBjb250ZW50Ow0KICAgLSBhbGxvdyByZXZva2UgLyBicmVhay1zaGFy
aW5nIHdoZW4gYSBmb3JtZXJseSBzaGFyZWQgZmlsZSBpcyBtb2RpZmllZC4NCg0KYikgRml4ZWQt
b3V0cHV0IGNvbXByZXNzaW9uIGxheW91dA0KDQogICBVcHN0cmVhbSBhbHJlYWR5IGhhcyBDT05G
SUdfRjJGU19GU19DT01QUkVTU0lPTiB3aXRoIHRoZSBleGlzdGluZw0KICAgY2x1c3RlciBsYXlv
dXQgKHJlZmVycmVkIHRvIGhlcmUgYXMgImZpeGVkLWlucHV0IikuIFdlIGFsc28gc3VwcG9ydA0K
ICAgYW4gYWx0ZXJuYXRlIGNsdXN0ZXIgcGFja2luZyAoImZpeGVkLW91dHB1dCIpIHRoYXQgaW4g
b3VyIG1lYXN1cmVtZW50cw0KICAgaW1wcm92ZXMgY29tcHJlc3Npb24gcmF0aW8gYW5kL29yIHJl
YWQtcGF0aCBwcmVkaWN0YWJpbGl0eSBmb3Igc29tZQ0KICAgd29ya2xvYWRzLiBJdCBpcyBleHBv
c2VkIGFzIGFuIG9wdGlvbmFsIGxheW91dCB1bmRlciB0aGUgZXhpc3RpbmcNCiAgIGNvbXByZXNz
aW9uIGZlYXR1cmUsIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGRlZmF1bHQgbGF5b3V0Lg0KDQoNCjIu
IEZpbGUtbGV2ZWwgZGVkdXAgoaogZGVzaWduDQoNCk1vZGVsOg0KICAtIE91dGVyIGlub2RlOiB2
aXNpYmxlIHRvIFZGUyAocGF0aCwgbWV0YWRhdGEsIHBlcm1pc3Npb25zKS4NCiAgLSBJbm5lciBp
bm9kZTogb3ducyB0aGUgc2hhcmVkIGRhdGEgYWRkcmVzc2luZy4NCiAgLSBPdXRlciBpbm9kZSBy
ZWNvcmRzIGEgcmVmZXJlbmNlIHRvIHRoZSBpbm5lciBpbm9kZSBhbmQgZGVkdXAgc3RhdGUNCiAg
ICBmbGFnczsgZGF0YSBibG9jayBsb29rdXBzIGZvciBhIGRlZHVwZWQgZmlsZSBnbyB0aHJvdWdo
IHRoZSBzaGFyZWQNCiAgICBjb250ZW50Lg0KDQpPbi1kaXNrICh1bmRlciBFWFRSQV9BVFRSKSwg
d2hlbiB0aGUgZmlsZXN5c3RlbSBoYXMgZmVhdHVyZSBiaXQNCkYyRlNfRkVBVFVSRV9ERURVUDoN
Cg0KICBFeGlzdGluZyBleHRyYS1hdHRyIGZpZWxkcyB1c2VkIGJ5IGNvbXByZXNzaW9uL2V0Yy4g
cmVtYWluIGFzIHRvZGF5DQogIChiYXNlbGluZSBpX2V4dHJhX2lzaXplIHR5cGljYWxseSAzNiBi
eXRlcyB3aXRoIGNvbXByZXNzaW9uIGZpZWxkcykuDQoNCiAgQWRkaXRpb25hbCBmaWVsZHMgKCsx
MiBieXRlcyCh+iBpX2V4dHJhX2lzaXplIDQ4IHdoZW4gcHJlc2VudCk6DQoNCiAgICBfX2xlMzIg
aV9pbm5lcl9pbm87ICAgICAvKiBpbm5lciBpbm9kZSBmb3IgbGF5ZXJlZC9kZWR1cGVkIGZpbGUg
Ki8NCiAgICBfX2xlMzIgaV9kZWR1cF9mbGFnczsgICAvKiBkZWR1cCBzdGF0ZSBiaXRzICovDQog
ICAgX19sZTMyIGlfZGVkdXBfcnN2ZDsgICAgLyogcmVzZXJ2ZWQgKi8NCg0KICBTcGVjaWFsIGJs
b2NrIGFkZHJlc3Mgc2VudGluZWwgZm9yICJ0aGlzIHNsb3QgaXMgZGVkdXBlZCAvIHJlZGlyZWN0
ZWQiDQogIChERURVUF9BRERSKSwgY2hvc2VuIHRvIGF2b2lkIGNvbGxpZGluZyB3aXRoIGV4aXN0
aW5nIGYyZnMgc3BlY2lhbA0KICBhZGRyZXNzZXMuDQoNClN1cGVyYmxvY2sgLyBLY29uZmlnOg0K
ICAtIEZlYXR1cmUgZmxhZzogRjJGU19GRUFUVVJFX0RFRFVQLg0KICAtIE9ubHkgZmlsZXN5c3Rl
bXMgd2l0aCB0aGlzIGZlYXR1cmUgc2V0IHVzZSB0aGUgZXh0ZW5kZWQgbGF5b3V0Lg0KICAtIEtl
cm5lbHMgYnVpbHQgd2l0aG91dCBDT05GSUdfRjJGU19GU19ERURVUCBmYWlsIG1vdW50IChjbGVh
ciBlcnJvcikNCiAgICBpZiB0aGUgZmVhdHVyZSBiaXQgaXMgc2V0IKGqIG5ldmVyIHNpbGVudGx5
IG1pcy1wYXJzZSB0aGUgZmllbGRzLg0KICAtIENPTkZJR19GMkZTX0ZTX0RFRFVQLCBkZWZhdWx0
IG47IGVuYWJsZSBvbmx5IHdoZW4gZGVkdXAgaXMgcmVxdWlyZWQuDQoNCg0KMy4gRml4ZWQtb3V0
cHV0IGNvbXByZXNzaW9uIKGqIGRlc2lnbg0KDQogIC0gRGVwZW5kcyBvbiBDT05GSUdfRjJGU19G
U19DT01QUkVTU0lPTi4NCiAgLSBPcHRpb25hbCBLY29uZmlnOiBDT05GSUdfRjJGU19GU19DT01Q
UkVTU0lPTl9GSVhFRF9PVVRQVVQsIGRlZmF1bHQgbjsNCiAgICBlbmFibGUgb25seSB3aGVuIHRo
aXMgbGF5b3V0IGlzIHJlcXVpcmVkLg0KICAtIExheW91dCBzZWxlY3Rpb24gcmVjb3JkZWQgaW4g
Y29tcHJlc3MgZmxhZyBiaXRzIHNvIHJlYWRlcnMga25vdw0KICAgIHdoaWNoIGNsdXN0ZXIgZm9y
bWF0IHRvIHVzZS4NCiAgLSBEZWZhdWx0IHJlbWFpbnMgdGhlIGN1cnJlbnQgdXBzdHJlYW0gbGF5
b3V0OyBmaXhlZC1vdXRwdXQgaXMgb3B0LWluLg0KICAtIEtlcm5lbHMgd2l0aG91dCBmaXhlZC1v
dXRwdXQgc3VwcG9ydCByZWplY3QgZmlsZXMvZmlsZXN5c3RlbXMgdGhhdA0KICAgIHJlcXVpcmUg
dGhhdCBsYXlvdXQgKG5vIHNpbGVudCBjb3JydXB0aW9uKS4NCg0KDQo0LiBDb21wYXRpYmlsaXR5
IHJ1bGVzIHdlIGZvbGxvdw0KDQogIC0gTm8gb24tZGlzayBjaGFuZ2UgdW5sZXNzIEYyRlNfRkVB
VFVSRV9ERURVUCBpcyBzZXQsIG9yIGEgY29tcHJlc3MNCiAgICBsYXlvdXQgaW5kaWNhdG9yIHNl
bGVjdHMgZml4ZWQtb3V0cHV0Lg0KICAtIEJvdGggZmVhdHVyZXMgZGVmYXVsdCBvZmY7IGVhY2gg
Y2FuIGJlIHR1cm5lZCBvbiBpbmRlcGVuZGVudGx5DQogICAgYXMgbmVlZGVkLg0KICAtIFVuc3Vw
cG9ydGVkIGxheW91dHM6IGhhcmQgZmFpbHVyZSByYXRoZXIgdGhhbiB3cm9uZyBkYXRhLg0KICAt
IERlZHVwIGFuZCBmaXhlZC1vdXRwdXQgd2lsbCBiZSBzcGxpdCBpbnRvIGNsZWFyIGNvbW1pdHMg
Zm9yIHJldmlldy4NCg0KDQo1LiBRdWVzdGlvbnMgZm9yIHRoZSBsaXN0DQoNCiAgUTEuIEZvciBj
b21wcmVzc2lvbjogYW55IHByZWZlcmVuY2Ugb24gaG93IHRoZSBzZWNvbmQgY2x1c3RlciBsYXlv
dXQNCiAgICAgIHNob3VsZCBiZSBzZWxlY3RlZC9yZWNvcmRlZCAoY29tcHJlc3MgZmxhZyBiaXRz
IHZzIG90aGVyIGZpZWxkKSwNCiAgICAgIGdpdmVuIGl0IGlzIHN0cmljdGx5IG9wdC1pbiBhbmQg
ZGVmYXVsdCByZW1haW5zIHRoZSBjdXJyZW50IGxheW91dD8NCg0KICBRMi4gUHJlZmVycmVkIHN1
Ym1pc3Npb24gb3JkZXIgZm9yIHJldmlldzogZGVkdXAgZmlyc3QsIGZpeGVkLW91dHB1dA0KICAg
ICAgZmlyc3QsIG9yIGJvdGggaW4gb25lIHNlcmllcyB3aXRoIGNsZWFyIHBhdGNoIHNwbGl0cz8N
Cg0KICBRMy4gQW55IGV4aXN0aW5nIHVwc3RyZWFtIGRpc2N1c3Npb24gb3IgcHJpb3IgYXBwcm9h
Y2hlcyBvbiB0aGUgbGlzdA0KICAgICAgd2Ugc2hvdWxkIHJlYWQgYW5kIGFsaWduIHdpdGggd2hl
biBwb3N0aW5nIHBhdGNoZXM/DQoNCg0KNi4gTmV4dCBzdGVwcw0KDQogIDEpIENsZWFuIHRoZSBp
bXBsZW1lbnRhdGlvbiAoZ2VuZXJpYyBuYW1pbmcsIG5vIHZlbmRvciBob29rcywNCiAgICAgZGVm
YXVsdCBuKTsNCiAgMikgUmViYXNlIG9udG8gY3VycmVudCBmMmZzLmdpdDsNCiAgMykgUG9zdCBh
IFtSRkMgUEFUQ0hdIHNlcmllcyAoZmVhdHVyZStsYXlvdXQsIGNvcmUgZGVkdXAgcGF0aHMsDQog
ICAgIG9wdGlvbmFsIGZpeGVkLW91dHB1dCwgZG9jcy90ZXN0cykuDQoNCkNvbW1lbnRzIG9uIHRo
ZSBxdWVzdGlvbnMgYWJvdmUsIGFuZCByZXZpZXcgb2YgdGhlIGZvcnRoY29taW5nIHBhdGNoZXMs
DQphcmUgd2VsY29tZS4NCg0KVGhhbmtzLA0KWXVkb25nDQpjYW95dWRvbmcxQG9wcG8uY29tDQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
