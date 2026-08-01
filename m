Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ABCC54FCD
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Aug 2026 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:In-Reply-To:References:
	Message-Id:Date:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tguNXEPdbDvEs95WsB9lJ6rnOej1T7b7PTSM3HRKso=; b=hlRZ8VSxtvO2S+Fh/IUckhRkyj
	5/oeYkjk5Jdhm0U+D44fNkgGdY2lo6qAAb/dAghV+Y7596R/w5se68j7nR9Ax2WrUp0sAFLPk9AQm
	wIWZcbic5PdNJGzgnJp3hGkLJS8649Rg9z6PpMEku27P/tUmlNhCo/IrJPTBtexureKc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wq0je-0007pj-6s;
	Sat, 01 Aug 2026 03:50:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ziy@nvidia.com>) id 1wq0jb-0007pa-FC
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 03:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Cc:To:In-Reply-To:References:
 Message-Id:Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMgAg6910qK7vf5U2o9gm4F3uUSFgtChdf3nqlA7jhA=; b=YgaJDYazWTid1QlK2QoJjCIaj+
 Rh7xBu6A8QU96lJ3/zuBjDofpurgEpi3AqyTN2jhQ9D01hJkjHhSTew2nv041WK21XfZo1GApUz5D
 YtMQgq69M9K0Jsu3RMuiabYiUtqSr7K0QhNrQp8w8v2vL/3GYgfl+C00TYGHHPfLV2sk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=MIME-Version:Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:Subject:Date:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMgAg6910qK7vf5U2o9gm4F3uUSFgtChdf3nqlA7jhA=; b=Uj6ylVlb6gj0QAPaZ1X/iXKVbE
 U4pJdcjxgb/qwDYNsoDJrcRPN4ibRFEYxJBLYqRTJJzLf06v6Dm7iDcgY7liwPsALs6rAFYpHvKoR
 VlGUxDzi/S4rfr5Ue38ROA/aTZI77ss36r9uMCSgFqsL3pZgdZMw2BVQTY2197lQ3Hys=;
Received: from mail-westcentralusazon11013001.outbound.protection.outlook.com
 ([40.93.201.1] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wq0jd-0004sS-IH for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 03:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPBlD8p/2rgSjbh4voVM7RDBkVb6cywQHmuF5xQwDngQUhA+HGGjYF64yOkPku2e2ZT02oTH70bYXV2FKz2a/HABCTIGhgznjbFYcgPMdecXecUMyTmVfulQPOAOMa2cG3sAmSgz7dQ/HUoG+pNjMum0WE16B2o/fMcKEA9m24aR9aZxtViY3RCR3ydHrxTuiuoCNVyEXnyMQMgGl50cCyWa/cGlfkFQ4getYUk7Ka59W2e6aCCzpWMC+ZFPMQME4J4FSTYDfylQzoK3/KrKRtgXw0sIRQeQ7SN95e3XuB69Vr6gGb/rhPBNTWNePprJyyRZq+CkdgwZimcItt2yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMgAg6910qK7vf5U2o9gm4F3uUSFgtChdf3nqlA7jhA=;
 b=NiYaYvGfnLnm0Wiu+hWmutZZDcVg6r3DbD+XXvwIJsePsuRhKOf48/bOgxi5bheAcXHERXIIwbW03saOGu1bMs2ZV8iplzg686jCexGljBrgkNRrp3ut2Uw4DRX+uDXLNlkReCmKngBWE7E5p+Qf+SbyVGoQBNXieoRQNp6CqEJjhAifFlvUf4RBn+1kqeB81gNXjEkZWxhwdqAIpoHvNUDbpZwaL0F0XWixNbo9+5JSGtvk9Fq/ZfxPzvjvCVkQdJOdPxRuAlkFUraD3QhRj5aRTbeG/gsRXykhxtL+cPRqLcXryHq1tgSYnMH0C24+/7otcRXS6Zomo1dK0bzCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMgAg6910qK7vf5U2o9gm4F3uUSFgtChdf3nqlA7jhA=;
 b=fx0l1vm7gO0hjaCS8s//ANg1yUsHmH8VGwXf3v8GR//vPikT9kj4r+51LHbXjrzw8Hrkoo+vC7XXQqNG7or2tgo4xiAbAMaPG/1Lf9FhPLee9shft9/tVdnAjkYk9qLdqyMJ/Bnn2XQpNZSeAluggXKYifOZPXSTiVOn5jy+od+olT9HJvCupuNTYD2cIDRKDr1+C0pVkTmpqfgKVnoLX8sbASvwSzCH/Csk/ekSWw8eV8eaFp6v0AGTW9WNeuH2/0fz1pUL6xCCPLDML6HZh3Y5D4xUP/1o4nj6Ga6XnNN29X4edkmB9WM942GBznMrSmX/4pxlYi1TkBXUUWrSNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 02:16:59 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 02:16:59 +0000
Date: Fri, 31 Jul 2026 22:13:29 -0400
Message-Id: <20260731-remove-pg_private-v1-6-142c97ba3562@nvidia.com>
References: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
In-Reply-To: <20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::12) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 593623a6-9da8-4a8c-2886-08deef72f7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: vlfpQcmFH2nK3H69tHQ7qTP+m9pMc8hEfJQuipmoj2ws2hyeQc0vhxTATG450Wz+hAcMzRPCQXKLWtpqX6FjNkD5uIs6yjjtdFazJtjz7ftHQ5tHGMAyTMEr998gBOgMy0IFs2/+oCG1odQ5v23wnN7ncx5LIkXt3LbuWppIReSX5Acnj9chw6ZdpluwVtxv4H47mIyNh+kwXBbUr4Z4JL9VwCAMOtFDnanbIPu+YC+VJsZgZRvU72p7jz+jbDyThSn2HgYB8mKVUwdsOXnz0i6yIGmXFx8F1xim77m4naEnH59Lhp9fDQK3XxZOOVQva4M68Qlut02Osj8lzzEivLl/HbOtjlrd1VDUMghxHb/0/WO7KpThj1AAdVATV9f6QTy/WrznRjaF+onibcW3tMSUGYBYKc2LWnY0Yg6Yes5h0tS7G0czuY0DpOyAUtGAIfok/MeszjtrHdGpNYglK2CGWdj+nOcfpqz874P390hpX1C/lkx/VF4QMQf4+yXU5dPNzg8OVVF84abH+m56FzwHwyHlgNh4KnwTsKy5YPTirrQFBeaceRtojUkJMdMv1ny4XMI2t08s/VN54Kq4Pu2mz+DPEMAmvSgDXqke0Vab4ClLTFlIMPH3b+LcFY7W2bO49X7m23q8l7SVqzCsJ1tmfp7jbvoViLf1nDwFsJB1Un8NxtKgYsPKuDm+nbvkreMG9e4MrLlb0B722+f9zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8374.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm02U3AyUkhqY3E4OTlwMGJXOFJBUFRLUnk0clJ1dGJTOFU3MzBxUjZlTVRu?=
 =?utf-8?B?dlIxbXI2MU1zR3ZuTGlnNG4rOGJuZ09jaUxZZmlNdEJvMEZVSWlVK2I4RmhP?=
 =?utf-8?B?RjVxMnp3QmorbXNoUzVueGgrTkw2bU44Nko4emZTY0hpdWQ1TnV4S0thMTE2?=
 =?utf-8?B?YmpsZ3l0SkJLalJUQWZUTGUydS9EYk5WZDRmSXFwQkViUmU4a0lGQUdmSTNv?=
 =?utf-8?B?RW40RURydzIyWEVBdFYrMWxtV1lMVTZ6T0RVd2UzdnVNY0tpdDEvQnMxcDgx?=
 =?utf-8?B?Ny9HNWpiUTljdHA1ekRiNEMxaXVHV3RZZmZwRXpFSVBrNXp3TUJVUENEM2xu?=
 =?utf-8?B?NUdNY1NQbG51VmRINGlCc2tma1N6OHNBMmh5TjBLbExRdDhCSDVDOUN3dW1i?=
 =?utf-8?B?dCtwZmphWnF6Z3NwUm4zekJ0SGZsL0FVRWI2NWltT0pneDlCWGd2eDNqdzFl?=
 =?utf-8?B?KzNtWVR5ckp1TjJtN1VUMFl2SkdLZEowWWNsRzN5TTJHb0lDbm9GSEgwS3dr?=
 =?utf-8?B?SmYyYlZZUVEyQVpNZ2pQQ1ZqdjVUVmV0a1FrK09HQU8ydnFoUmhRWnByYm96?=
 =?utf-8?B?a1BqRTI4MjFXT0hGSGd3cGRIZk5yYWE0SkpYN3VDRDQwMCs0OFFqM0VrdEts?=
 =?utf-8?B?ZEpJaW1HU2s2ZkkybVZrS0tqQVZYTWJZVkZuMFhGc2Uyc2ZpWEZveEdTc2xR?=
 =?utf-8?B?YVRHSTNsVUtFYm4wUlFOU3FVYWFQQmwxRk5oNitJWkZoQ1Q1d0k3WURteFp3?=
 =?utf-8?B?WFR0ZHZOdHVhWlFmV0t0QzgyNEZ6OXZ3U0M4bWJIakpoU0hiMFJOVDBEU2Nq?=
 =?utf-8?B?Y2ErZHZCcGxwbEkwajZvaTV3M3JCVzMzYzVjWEJoL3N4eEticEg0M2pZQ2Rp?=
 =?utf-8?B?RVNmaS9tQTYrSmtsQkJCRThucml1WmlDak1ZVnZOdjZWTEZHQTZ3MjJwcUE4?=
 =?utf-8?B?UEJJcUVkNXNuNk9GMjBPZzFTQkllTzM2TVlyb2F1L0hoZXhHRVdZYmRPdTdR?=
 =?utf-8?B?NWhCOG5qM0xsRkp0MU91T0JFcDQ5UWNTMWo2MVZtTHROb0JEMXZCdEpGQVA1?=
 =?utf-8?B?R2NGdDZWK3k4YzJQdHdPTElCSzNnY2trcXVTZ0pjRGFIcW9maUI4cEFRWkxC?=
 =?utf-8?B?RHRrTWR6ekFYdjhYc1ByNTQxNEVzZ2VmZCsyTVFtSHhSbGV3VlhlVDlNU2NK?=
 =?utf-8?B?Zkl1eGZQVkVtcUJaTzB3N2E2S2M0ZGVWVms3ZHVDWXZ6VGZhQkVUNjJRNkh6?=
 =?utf-8?B?MVBXNFo2dUdSRmQyd3lLQjFETkZVOFhWM0t6NW5xMElrTlpGTHY5ZWFFTHR4?=
 =?utf-8?B?bXhzR2gweDFpaFp4VWhLaEdONVJWTU1SMDBiM2RwQVpFTXJqanhaOW9vdUxv?=
 =?utf-8?B?YWR6b0JhSjVvS3lnb3ZmNDBtLy9wSW5QN0dIdnQzMmRmM2Nob2lyOHBFaCtr?=
 =?utf-8?B?S05hZlBCM0FFMmtRTmF5SVhsNmF4Y0xjaG9WQlVvTmRSUzZJL0pNUjhKcENZ?=
 =?utf-8?B?bnkzWnFHN1BpKzNtbGdKOGx5MWw4MlFZUER4NERKalVma2IrY2NRUkFCZW0x?=
 =?utf-8?B?a082d2dFMlBqV21UcHoyeXZoQjBxUHhMUzF1Z1hNTVFBdWl5NUpVRVplUDQy?=
 =?utf-8?B?WEt1Y0M0U1FzTnhjd3hCT3BKKzVRM3IzRjhwSDJwbVhORTd6VVhFODBtWFhC?=
 =?utf-8?B?K3JnZ0VTTG1ueDZyaHAySzJOWWlLbVErU0o2T3NqdSt4RDY0R3htWHRzbFpE?=
 =?utf-8?B?U2ZTbSs1SktHUWZpL1g3aEJmWFRiU0JJVkp2YW92YVlsVkt3WU1SWi8xeGh3?=
 =?utf-8?B?T1phUi9iMXVXckZJSWRReXZKbGMreEpvM1pVV1pqWEMrNnIrMWE1RE1uc0Vz?=
 =?utf-8?B?c1BUV2hCV20zUlR6R05BbkdPTHJtdlRQSEUwN1JiOVZkaW1aQVAwL2RrM3l3?=
 =?utf-8?B?QWRoRkkzNUtWTkNNUmVwMlN1K2tTVmpsb3pXd2RZR0haQmVpTjlObjJuVlps?=
 =?utf-8?B?YTRIeHdNTUx2d1lJWHpGUDYrV1AxN2hPeTJ1WHgvVTE2Q20wY2dXWU5MZkli?=
 =?utf-8?B?RjJBN2xaNjRPRW1IR1NNaGZBcmQ5QUs3YmR1Q0J5N3d6S3J0VXZsK09sM0Ji?=
 =?utf-8?B?YlJLN1FTN2RQemRwejNCMC9KVlUyUFpINUU2c1MrTDhHWGdEbjh1OGVIQlBI?=
 =?utf-8?B?ak1XSUhBSE1URE9BbFpVV0VtM2YybktkdG1uTW5KZWpYM3ZhSm9EeE9MS2hr?=
 =?utf-8?B?OENDOHJMcm9od0NvemU2ZWFVY0xjbmxNQ3NMUWh6TkljeWJiWVRKSGRlNTZm?=
 =?utf-8?Q?F5iBAU/umosg4bD20u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593623a6-9da8-4a8c-2886-08deef72f7b2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 02:16:59.4869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZfrAFwmjrSSnKpGdVvBWJjvVvO+XnAUowpi3g4TRlorgYJjMeDitqdpc2RufSRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
X-Headers-End: 1wq0jd-0004sS-IH
Subject: [f2fs-dev] [PATCH RFC 06/14] fs/f2fs: stop using PG_private
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
From: Zi Yan via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
page->private != NULL is equivalent to checking PG_private. Change
PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
but it can cause confusion when PG_private is removed and
page->private != NULL is used instead. Change it to initialize
page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
semantics.

It prepares for a future commit that removes PG_private.

No funtional change intended.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
Signed-off-by: Zi Yan <ziy@nvidia.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
---
 fs/f2fs/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8f3e632f315cc..edf01eb4b3b30 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2643,7 +2643,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 }									\
 static inline bool page_private_##name(struct page *page) \
 { \
-	return PagePrivate(page) && \
+	return page_private(page) && \
 		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
 		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
@@ -2662,9 +2662,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
 }									\
 static inline void set_page_private_##name(struct page *page) \
 { \
-	if (!PagePrivate(page)) \
-		attach_page_private(page, (void *)0); \
-	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
+	if (!page_private(page)) \
+		attach_page_private(page, \
+				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
 	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
