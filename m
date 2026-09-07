Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CECC79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:In-Reply-To:References:To:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPG828LcRNw4vN/EtDb7oY0h91afpAGPXzqvQaGNwV0=; b=AU7OPhSz3qSc0w3fIZkKSkt7du
	fwRxGRJcYlGr69e8rRIpTuCfLnQwZ3ahvR6Jc+XUnb7gI6x/jIB8uZsxKBCIkeFC6sgR8wrtNCMqP
	5e6IY15JejRSvrqASoqBXb5APc9x4eJhUPnGeYq+PJY4i2EfVJVfQzJYYkMErO3vogaE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3VEm-0007hL-PD;
	Mon, 07 Sep 2026 09:02:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Jiucheng.Xu@amlogic.com>) id 1x3VES-0007go-Mu
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:01:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hKk7l+SrvGBaEuKKYjueKX/FNs5PIs3Rdo6uj1a95YE=; b=eV+3XU7IAigN/Xz/LmzRGir0wx
 SLIcKNWvzWD2SQb/i70C7J4b8zRMD0Z73ree3DU+/55pektVQMf/R77gsmsqSN5SSXS8tYBiyb2Nr
 6XhUOBO4T+hiwbkKp8TnK83bXnekDufMqLSDtT5JprD/gW7aNk4tiSFsC9wvdLiJHRgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hKk7l+SrvGBaEuKKYjueKX/FNs5PIs3Rdo6uj1a95YE=; b=mWCj52dPe6dC2+Q229ZEwduTLk
 2FgxzKW+U2/RnbxzajJYjroDT7FEPD4d9HAqSinA5qi1tDz7boZ0Tv8WwRT8KRvl6m8McyYGJzNgv
 qHQZ/iaJJdO5zO2UezKQhm68dRl7tBcx6btRhElfj++kZ2rKSLJyICZtoPtE0JQt/v4c=;
Received: from mail-japanwestazon11022122.outbound.protection.outlook.com
 ([40.107.75.122] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3VEF-00083j-Vm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy6yNeCHlUKTomN5HLbLSYUK+dH6E37akTmke2y5F2wfv+arxm1fcp5juUEVH+jZsB9w185QcL5eXxRpyz7vukAqk7MhZK6hDtPQNy8+e0KIY6fVjdrJy1qCxLY+0sUlpFLlFM0U/Qx8iFz8T5930/D28lYqLkpGqZJRCJhqe3UNcUgMF35ubGEo06clysKbN5Q4w1uLPPYhtCHktVW0x10jUYsLYdA/ZpZ8TrjpZ5df5Nu8ONN01vcqW4LMgAXrlORq8ilaZL4wS26+fzxQA8xTWQZvFKSZ3xKmwIgYaxkxsBrHZkN4Fpp/xOwqxnDA+8u5SlmuQWvIZR0wgsKchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKk7l+SrvGBaEuKKYjueKX/FNs5PIs3Rdo6uj1a95YE=;
 b=wbybTrDrbnsCGB4oSdrggZiJiv4eHEmaETg4vkKrPbw/F5cJ4JkyxXXEhP1YZ2RrVO4oNqI0s3Aiw7ygFZqRrS2rDRUPtrFDbY3GNxHcsEtR3quItHFR2Lfbz14eh4ww+QMHZjdFbAEN1Ov5utnVuSj44NY+IZ9CC/vK8Fc8slS076eFMFQADVFADEoxUb7bTJo+8w2vzHjqpsC4eswAKAAU+1izGvVqMPJlNJi5+X7ifNK9sveT19U6HF7GatoJBbc0ErFrwGn7B75KNusnXKod08bSKmc2E+w2Z39+gIjk4GH9BYF8qtZmZ4Cv4dDczSd9Jkf2E0dQ/gnVHx/xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKk7l+SrvGBaEuKKYjueKX/FNs5PIs3Rdo6uj1a95YE=;
 b=Dq+hp1LUS9Saak84ZXkVKmDVwqSiRwJd5vGrq+2LH8RrSzWQUubliQ0+PyBWJ/MBqiDJi9SowwDBLmGJiwAc6US+pck8um2xzQ0D8tsyB8eH2Sk7X6d3V4Y133lg++aMgRffg/HuY+XUEjRaUCuJ9z2xebWWU/GHmopxL/STyMOnjR/dUr8EkEF5r9//0vbd7bkcTjN3vuLy7QtfzRrI6GnVeDuDn84UizCEQOJQgmokSeXWDWx1Wy+RnmQq8W9TsGD4UzMKi7YvcphL4a40t4b1LA5o7u+7pzV3EdfB2zGyTCspCzCreXKg9GEdZ1MEtuTDsypvVpVcPFqeSVrFtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by TYZPR03MB7348.apcprd03.prod.outlook.com (2603:1096:400:427::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 08:45:27 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%7]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 08:45:27 +0000
Message-ID: <6e2adf29-e3a6-4033-80f8-e3ed672f47ac@amlogic.com>
Date: Mon, 7 Sep 2026 16:45:23 +0800
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <5de3d9c8-e847-422f-a9e4-31ac2a1b5c2e@amlogic.com>
 <b90c9052-b44b-404a-85cc-8221249b63d7@kernel.org>
Content-Language: en-US
In-Reply-To: <b90c9052-b44b-404a-85cc-8221249b63d7@kernel.org>
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|TYZPR03MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: bda223b6-3fc3-487a-abad-08df0cbc5d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: A5VGcyNUsjA8EX1/sN6mxGvhvGHZNiMYgme5+lK/uaKB82/7HxQbJLRBNJUMkU+UBajK8E7foS8zIEptsAjAN/G8FZxJVPwA/DdMGOLrqnlToxqEkhAh5PlrUvJISgohvgbjlL+QplSEt9DEncGh+qDle4fUsqYVFQJLxzzI62zMbm9aTNPqijVPdMnVgO5dbnE7mUMKRRiF4F3+5rW9aCe/amliw0Zkoxl/ZA3xdfGzOighGqDtly1SKqG0mu7jTg5WeKAG0R8aHGL86LAVNvYV5s8be1rAaeGht/b5hHENv1TGzkNAvSf3f+K8qTHIwRW88dHdsJVuLECRjTQboj4zmGnxJs3zslKzhI4q0YrfzaBd5mUbtFkfG/FVcxaVFYo6LOOreKsgb4Hz3Oqf4M7CWaZBAW6KfMbE/j07L7pIM6gDOE4UGVpmzobe0+yFaF1cP73bAn62hAzDpei8JBjVtju6LxMHMUPOJaHaMKXrUKMtBK2AES5uMEwSClNJ+Gk7Y1uY7vCL3lYQqiHYmWNN+3FS+b9XnEZjaju4rrAJ1T6nbNINnf6ifmDWnw2FKCetz16ruKs2L0WbcOLTlPdjg6iJMqVlsJhSaWqBm+7dDAJsyAfVwKNFsjkSZfSPDVu8ePvoW/rwNPAQRFTKFhsSjNgOq6L9QM0V1a8ZWDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYUPR03MB7232.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUs0eENnZkdWSUJRR25SYnNaVUxsTXE3SFRFc3BJaXBSNHRjdUhkc1d6aUlL?=
 =?utf-8?B?RUVhc0lkVXF5U0crRUxmdE5jZkVEOGxZU1I2bldVTEFjZzdmRVlRT0hSbDNv?=
 =?utf-8?B?TVZBNTdWRGdRS0lCVXRQU09ZNUxzR1BFeVBwTC9saGZNa3F0eXpzR3BIRjhK?=
 =?utf-8?B?d3RuQjhVdThIQkZwdFBaaEpyWFBFUlFEeFphK2dIZ0lmRHpVUnZQbzkyaWMr?=
 =?utf-8?B?dXFIRUZYQmdvby9UdUFuSzVrSkV5c1l6eXZDcjFZTlg1KzI0TVc4Q002RVFr?=
 =?utf-8?B?enRzNElVbnhnL09qYk1ma3FDMXR3cXRJZHlVQ2thdmphVzRMV3FSWTlNTXBC?=
 =?utf-8?B?dlVsTzVwbER0UVp1RzliRXRjTjRTZzlDUGR0ZnF6UXRUWXlLV0ExVlA2YnZo?=
 =?utf-8?B?Um9mQmRCRm9xcFFVbi9WaWp4Mm1VUVY1R2RBNWo3MFdNVzlOVTNMUVVsY3Jz?=
 =?utf-8?B?MVp3TmNjNkQ4aUtMbTc0UTdpUU82dGFGUlV0dHA3OWE5VUp0Mnd1dWNHenpN?=
 =?utf-8?B?bnJFMkpVeEptNDljN2NyZTNUQUx4R084T0tOZWw4QklrcmpRTnNtdC8zQ1RQ?=
 =?utf-8?B?eEYyZUlndWF5d2g3ZlhuTS9jejUvb2ZsejJ4VTdsV0o1OUpFem5DM1p2T08v?=
 =?utf-8?B?eWdOd1ZEQnFGamdwZVRBaGtOSHMzTGw4aG9vbnhPMVY0dno5ZlVmQ0F6WkZW?=
 =?utf-8?B?MFpMa0U2NHJBRm5aSXJGeWpiZzdpWDJ2aEVXWGcyYTlQQW1kOXo0L0VESm9X?=
 =?utf-8?B?UnAzRDNwVzNMbVgvT2Nvb2VaSVcwaElWMEgyVnZvSWkzMVVxQmhKTy80MUpC?=
 =?utf-8?B?S3E2eHlodTdIRmNhZ2FpU2twSVphTDFQRlFhZnFqOC9Jd0JacUtwRWhVU0Uz?=
 =?utf-8?B?MERIbXd2S2t3bGwyT2xmY1JjdXA2cS8rVHJiQUlmbkQvMW5abmRHOHlHdk9W?=
 =?utf-8?B?dzNsQ3hqbm95OE1Vc1BUclVDRUE1Y2VTTW9UbmswaGxMcHl0MkZOQUx1RDla?=
 =?utf-8?B?YmU1SWl3SWpqQnBudnlSQTR1aEhCdm5SVktCVGp2VWUxb1FnMHBaMmpnSUlt?=
 =?utf-8?B?QXJuczZ2ZCsxbEZRNkh1bm56dEZqOUhBVG4rV25VZlRZM2pvbVQzbk9QU3RJ?=
 =?utf-8?B?RnN4RTNNR2s0U2U4Q00zR3c3WWZzb1llUXhydzUzZnc4REJMcEZyZGE4eVJP?=
 =?utf-8?B?eWpEZm5aNFZvSklkTWs4YkJqTmZZU0FYeWFJRVAwbWVIdTNna0FsM1EzdzJN?=
 =?utf-8?B?ZUpKMjZoN2lkMHQ4QitYdFY0WlUyVzd6R3BlMG1KOXVoVlZwVTB6YThBcFRJ?=
 =?utf-8?B?MW5NZVRhaG9yN1RHaDFkR3JpTEF0OHl3Y3pib2ttS2hOaHFUcVdDNFl3Y3pH?=
 =?utf-8?B?eFc3am84dmE4KzlBVGw4NW4vSEFjeXc4N3FOMThhUlJHVGFhYWFhcXV3eUtK?=
 =?utf-8?B?aXRDUVBnelFraDFMVFZGdXpyYUNJTEVEU0lQL3gvZVRZN2VWNHhLYjE1V08w?=
 =?utf-8?B?azd4Z2VvNHBhUUJBZHU5MnB3dzltYW91KzlTZEgvb3pyQldnTHdpdWR1dExV?=
 =?utf-8?B?blk2MXZnaC9ndWcxbmJLWHRwdmNkY0U0cHYwUWVpM1l6VVh4TjVDWXlIbTJs?=
 =?utf-8?B?dFpiKzd3WEtxY2JzSS9nNkdoUU16eHg1ZGR3eUtVSENMdlFPMXVSQjBmN1dG?=
 =?utf-8?B?LzVJR2ZwSDYzWmNCeHlyYjB0VWxINHcrM0Z6d0RwdGswa0gxUmNCdDF5ZUcx?=
 =?utf-8?B?MTAyUng0UXhKSHltVk9GdTl1SS9LZkxBT3dmeEFoU09TaDF3a3M2Z0VYUk56?=
 =?utf-8?B?ckVnclc0bmVCcWpvVGlOdVNYczczdEhYTENQbUFaM2xPQmh1VndhMFNHbndS?=
 =?utf-8?B?MUkxejdUQzBra0M3ZXFZakhiQUdaeXhFWnFsRmQ3dXVqS1Q5MVdSZFowS29i?=
 =?utf-8?B?a2FsdkVvREYrRFVHblR4WWhNMVdNRThTT3RMMHBmSk90K0RlZzlDTFRjU011?=
 =?utf-8?B?TDJpM2doaHU0V2xOQ2gwNitsSWVOVEVzc2twT3p6QXZGOXQ4YjVwZHZzejdr?=
 =?utf-8?B?ckpsN09HTFpBdlViQUZsWlladnJHU1ZZOE54Wkk4VUx3SlBPdUJseW9uNElX?=
 =?utf-8?B?azF1eVlNV0gzRGpTaGMxa1g3QUd3cTNCMUcwcHpXV3ViQmQyM2FWK1JsbDNQ?=
 =?utf-8?B?Zk1oWnpaOWpINGhsNFhFSFpCQUVSMkx5SzRkT3QvQzVkbkFrUm5NQnI4RmN5?=
 =?utf-8?B?citQWkxXSERpbUVHT0h3R1RKN3Ria0tuWG1QQXNIQWlzUWxsNXR6Si9VU00v?=
 =?utf-8?B?dHkvUUdFeWdoNEdUdnMwUGNpRCtab1haM05mZFlPOXd0WS82MW1zQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda223b6-3fc3-487a-abad-08df0cbc5d2d
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:45:26.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huDMeR8+Np2WCdVzpyxO4HN1ZTPyAkxvzNYfvf6hFVlnNzKkoK+82oC9K7lVEfA4JTA05NAl+vWYaBQJsOk4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7348
X-Headers-End: 1x3VEF-00083j-Vm
Subject: Re: [f2fs-dev] =?utf-8?q?=5BPING=5D=5BPATCH=5D_f2fs=3A_force_out?=
 =?utf-8?q?=E2=80=91place_update_for_all_writes_on_compressed_file?=
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
From: Jiucheng Xu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOS83LzIwMjYgMzowOCBQTSwgQ2hhbyBZdSB3cm90ZToKPiBbIEVYVEVSTkFMIEVNQUlMIF0K
PiAKPiBPbiA5LzIvMjYgMTE6MTgsIEppdWNoZW5nIFh1IHdyb3RlOgo+IAo+IEppdWNoZW5nLAo+
IAo+IFNvcnJ5IGZvciBkZWxheSByZXBseS4KPiAKPiAKPiBJIGRpZG4ndCBnZXQgaXQsIGNhbiB5
b3UgcGxlYXNlIGRlc2NyaWJlIHRoZSBpc3N1ZSB3LyBjYWxsIHN0YWNrIGluIHJhY2UKPiBjb25k
aXRpb24/Cj4KSGkgQ2hhbywKClRoYW5rcyBmb3IgeW91ciB0aW1lLCBUaGUgY2FsbCBzdGFjayBp
cyBzaG93biBhcyBiZWxvdzoKCi1UaHJlYWQgQSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLSBUaHJlYWQgQgogLSBmMmZzX3dyaXRlX211bHRpX3BhZ2VzICAgICAgICAg
ICAgICAgICAgICAgICAgICAtCmYyZnNfZG93bl93cml0ZSgmc2JpLT5jcF9yd3NlbSk7CiAgLSBm
MmZzX3dyaXRlX2NvbXByZXNzZWRfcGFnZXMgICAgICAgICAgICAgICAgICAgIC0gLi4uCiAgIC0g
ZjJmc190cnlsb2NrX29wICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gLi4uCiAgICAt
IGYyZnNfZG93bl9yZWFkX3RyeWxvY2soJnNiaS0+Y3BfcndzZW0pOyAgICAgIC0gLi4uCiAgLSBm
MmZzX3dyaXRlX3Jhd19wYWdlcyAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gLi4uCgpUaHJl
YWQgQiBhY3F1aXJlcyB0aGUgbG9jayBmaXJzdCwgd2hpY2ggY2F1c2VzIFRocmVhZCBBIHRvIGZh
aWwgbG9jawphY3F1aXNpdGlvbiBhbmQgZmFsbCBiYWNrIHRvIHJhd+KAkWRhdGEgd3JpdGUuCklQ
VV9GT1JDRSBpcyBlbmFibGVkIG9uIDE2RyBlTU1DIHBsYXRmb3Jtcywgc28gZjJmc193cml0ZV9y
YXdfcGFnZXMoKQpvdmVyd3JpdGVzIHRoZSBvcmlnaW5hbCBjb21wcmVzc2VkIGRhdGEgaW7igJFw
bGFjZS4KVGhlIGlu4oCRbWVtb3J5IG5vZGUgaGFzIGJlZW4gdXBkYXRlZCB3aXRoIHJhd+KAkWRh
dGEgYWRkcmVzc2VzLCB3aGlsZSB0aGUKbm9kZSBtZXRhZGF0YSBzdG9yZWQgb24gZU1NQyBzdGls
bCByZW1haW5zIGluIGNvbXByZXNzZWQgc3RhdGUuCklmIGEgcG93ZXLigJFjdXQgb2NjdXJzIGJl
Zm9yZSB0aGUgbm9kZSBpcyBmbHVzaGVkIHRvIGRpc2ssIG9u4oCRZGlzawppbmNvbnNpc3RlbmN5
IGFyaXNlczogVGhlIGRhdGEgb24gZGlzayBpcyByYXcsIGJ1dCBtZXRhZGF0YQpzdGlsbCB0cmVh
dHMgaXQgYXMgYSBjb21wcmVzc2VkIGNsdXN0ZXIgYW5kIGRlY29tcHJlc3Npb24gd2lsbCBmYWls
LgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
