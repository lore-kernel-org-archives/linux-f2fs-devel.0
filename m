Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EDEC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=InBVubQO5UpZ1qpU3QpCvMeiN0fr9zgJTzV+WQttrDQ=; b=at2t7zsz+hrc7HZh9a2/Cy0SIa
	A5skOHnzinEdsv0WoSjlCh1YI/nozQ9TAgDlB7GvFoTL5at2Htmw+hKRinIRhp76sSaUM9EyGy33X
	bTYZHVlha5t5m9m4zudUcEgOSjHjwuy7G7IV+oRo8d1pyqBq50I6VZlzU8aUWu/gyLFU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzx1i-0002Ok-6X;
	Fri, 28 Aug 2026 13:53:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ke.li11@transsion.com>) id 1wzx1h-0002Od-4F
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D2Dj+Mkg+y0dEovAeJb1Y/XaRXG9R0K3aEXPmJUycdk=; b=Wu4Jn1TyqL5l3S5HjdXtBpgotG
 Aue0DxV8OGBlRgzl/qd/se/hwkAC5y4jmXpykVKO1F3i/3dgFxYwlYccgVs9xGokkCPzRIiwT6FkF
 F/7LXg4emKNQ7chr6Tbv7phZv+PDWbTcf/0hDajM0Aku0P0Coo4sKKiZfnOJkqmAo9b8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D2Dj+Mkg+y0dEovAeJb1Y/XaRXG9R0K3aEXPmJUycdk=; b=K
 E4w0S7Rh0sGRewn4jISKmNYXTXjYBHb41jJY8MbBmBnU/Fgufr8NVqSoz4AMfyqDCyNwyE2bT48aM
 hC1mAyjKzHWYEbGn9P/2YuY6gLkoU7SkOLjQm7Q936U8u2tmVAjqnT75bVyOlzbmZj+KCDRUKcZOy
 ud+Q+/1eMWrEzydQ=;
Received: from mail-japaneastazon11022081.outbound.protection.outlook.com
 ([52.101.126.81] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzx1f-0006mO-Il for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:53:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCPezg1FlGYwz/DQ5a/8YtDNnfUB4TxJfL3oebGYpm8G7CiIOsX+sCc911RTNvWB0pt5tKvo1NnZIAyB430QuhkU2uPS8/7IZXK/e2eovPDGiWX+k32BL7nmF/1YfR5p8o8C2dnYjeHSDp//EUlyQ/NvA6CSVPpZi8+QpWg1yz+Z23gNPgtZ3yYDmTj0orRaIcNa1kf7Nb3RHJrxwoGCFpAxvu4/dLHm7+y/Yn1DYjVTIOWhAOFS9J7+q1oooATD7k42uCjM4Fez1ZPhmN89yUjGZCRWpnA1Xnql3sHZElPG0pfMRv8FGQffWW8G9/xQnLs0wIz25c/heRw7ZywRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2Dj+Mkg+y0dEovAeJb1Y/XaRXG9R0K3aEXPmJUycdk=;
 b=ux21FiKYcBzX3iSMesT0ABB4PPG79QMASkgevLyiKpl70mGKM1l0sYh2aGwMSkkK2QRQvpDBp8lO0AmPvRC/ANAR15qBB/YZZ/wpRHOg5In5miD8rw9ookw7YAR4fLGUauU0bz7hDDP7NS2Pt4iefEiwDdr6e8kXnZQstZF/jKxocxGw+BxDRJGQTlXigIql7nXc1DEQFJs3+uodoJUOgXX0J10U1u3sOTMjJm5vSR07zFhuAwBFCKdVhrDemkGsx81yC7QU/qSBeolr+fow3H9uXJYsPDLdx5KwMDBPfgIQnhlpI/GgDuKxLsTFA4TFgJabdSkX6lGY+IejhMv4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Dj+Mkg+y0dEovAeJb1Y/XaRXG9R0K3aEXPmJUycdk=;
 b=n0XLUT19bnvAJ3u7+Ro63UxJe8l87lZVNUE5K8ZEcZxpx7BBxGfwtSH9PH6hutFl5CCNPiSLLv8m4zH3nwTVv+djdKiuKlK8zxiFzIY/reBj031u+IQPAqHXQWzAzFIp+G96h7sH9UAhdDz9N5/20g6Hz28UrXZy/W6iyTG7aZU=
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com (2603:1096:820:b9::5)
 by TYSPR04MB8074.apcprd04.prod.outlook.com (2603:1096:405:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 12:18:34 +0000
Received: from KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605]) by KL1PR0401MB6611.apcprd04.prod.outlook.com
 ([fe80::4561:48d1:fcf9:e605%3]) with mapi id 15.21.0360.003; Fri, 28 Aug 2026
 12:18:34 +0000
From: =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Thread-Topic: [PATCH 0/2] f2fs: multi-device expandable storage support
Thread-Index: AQHdNudYDqah2N+7HkmYRojPuL70wQ==
Date: Fri, 28 Aug 2026 12:18:34 +0000
Message-ID: <20260828121816.1463654-1-ke.li11@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0401MB6611:EE_|TYSPR04MB8074:EE_
x-ms-office365-filtering-correlation-id: 7d211d95-ce7f-4e94-6add-08df04fe7b14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|23010399003|376014|10067099003|6133799003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: IrbGZqBIRPmYzdcL7LhV/a/toNVyYZx2IU2pRCXTnmSVlysmwuc8Eohjs/vNdc3TLdVhUH7y3zihgi/Q4h+84LrYwX5d46sytIOB5wppFzctOqAS57iBU7G+O/Agm5iZkvQ9xdQvEzYRPlS1DZTXRuoOAtvZFS9RqjKIsO8QXGnU9fl5GCAub6QOhHe4ybVhSc39OC004RHPpSSHL+2V+JKbqzrXvTUXjtYc58b6B2X4Hqtim30/898mE9j2cTwsUuwnfOap55ucy6Q5BPtTN/cS1zoGg5a5SUvrq6afsAcAeBRq5yo4cqu/mqUAlifiP16Dbgmi8y5bnkW+C8zDnNXERe4xAG3BjqewbRBXhrpyvgkQE9jsRCvZwB4T3IJ8Jlp8UHS+R6neFaEk6Po/EeL1Il4z3u6fY9zJVUudBj+We8zlpTwXgDIYYGSxvQXAEYOwMPNW/4ZkgA9RmC1I/T2YBXGCRvrRaLOnSpttFEvZJBwOYTQzKT8z8GvkylHSlK+TflH+WaTChK3N0gkFJlLouDb6w2sqeUpMY4h68m7ILNaPBjS0iR6X749rOtykiiasIIR1msEo7cMDynqfVunimsas3MQpTvtH+nEUwURHI2Pl/5Hy8CrBi/zfGD5/Ab1AHdGv77YQ/3QH7RobiKf7B5vH2t6s62CYIvNMML6IDzXh2IhV3WO/srX2oCQydlfcll1Pqm0O7btCZ+GR4z7I4tUy8IYZhV1MKBCMlRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0401MB6611.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UEVPYnFsWjY1S0p1a0tVaGo3bnhuaFIxZ200OENheGEyeXdtaitEZjJy?=
 =?iso-2022-jp?B?RnV3dDE4ZXZWMEN3aHVNN3V5a2lvTmhCSFBDVHZoYzJHZGFSMEZvNDg5?=
 =?iso-2022-jp?B?NXppNjFwMGhxWDMyV2lMZVJhdEwyeFBJVzU5WTc5ei9sUHVkRXNZbnBJ?=
 =?iso-2022-jp?B?UGxVT1lKMVVGWUpaZmRaWElaN1kyUmhEMGVFWXgwOVljbFpSSi9vUC8y?=
 =?iso-2022-jp?B?VnBUMUk2dVQwL2hjckxZQkRXMG5oM2hxQm1EZXR0OEEzbmdDMW1nSFJL?=
 =?iso-2022-jp?B?ZWJBYzYvY245L2x4U0ttaGRHUjJDa21tTi9UUDc3aTJFOHM3M3JUTHFF?=
 =?iso-2022-jp?B?cy8xd2FSNE96c0N4dEp6V2R4NUtidDRzUUp4ZkhCRk16dEFnbDJuOExx?=
 =?iso-2022-jp?B?S3JTaDVOMnVadDFSczBuZE5nTDErNmV3UERiNFNpYkVQcERMT1cxcmRN?=
 =?iso-2022-jp?B?L1oyc0Vja2hMOHMyQXNseXF0czAxRTNYeGxyK29NSkdiRWo4T3J1L2F5?=
 =?iso-2022-jp?B?eHZweitqQ3NpMUhkQ3NWbEpjNWtlc016aU92NVRVUmF4STF3bEEvd3Bj?=
 =?iso-2022-jp?B?a0hQKy9EbkVZczZ4RmRNMVVJZGZ2cXZXTE40eDJreXpmelBHbDRVQWxZ?=
 =?iso-2022-jp?B?NmY1bGRCT0Z0OVYxRG9qcEI4MmF2ak9DZ2Jhei8zRGNoN2hkdXN0K1BM?=
 =?iso-2022-jp?B?b0ljVkJNMDdJZDJFakd5M3dVcnE3TTZsd210K0U0ZnRRaXVtZGptMWlE?=
 =?iso-2022-jp?B?UFl3ODk2ZCtPdGtiUk4veG1HSnNzMmxsVDYrOTRQcTF4b05uRS8yWHRk?=
 =?iso-2022-jp?B?NU1WSWpqVXNJclBEY0RFU1MvdHFQam53UWc4c1NVbHZYcjJ5MzdFZElo?=
 =?iso-2022-jp?B?WnF5Wk44QVNTaWUwTVE4NEtadWhxaDR1VEdTek9menczRzcvODZtTFE0?=
 =?iso-2022-jp?B?UFZya3ZSbkNUM3BWeHpIbS9RUU1SWFdVQjZJWWx6L0hLa0JXTDF1L2tv?=
 =?iso-2022-jp?B?aDBvVjQ5UGZobEIwOXJGcFcrWmZXOWUvd0dGaVVoNGg0YlBWWERrSFBs?=
 =?iso-2022-jp?B?ZkRObzBrWWRlYVZKeTdjYTFPYWwwVjJSUTRVcGRNaUFENjkybUVNREtF?=
 =?iso-2022-jp?B?ZjlRRTYzUjNPckp2eDVuYjMvd0hWOEo4WjV4My96Umk0NFVSYk5HYlJY?=
 =?iso-2022-jp?B?UWM3RC9JazBQOGQ3NVlSVGFHS3VLa0FtT0ZKeVJxd3hWV1h5UjBWeW53?=
 =?iso-2022-jp?B?N1FjNFRPd1ppS2JaRGRSTFBXSmF3VzkwWU1ITHUvSWNGVVQrV1FTZnlj?=
 =?iso-2022-jp?B?a2gweGJ2Y1FFNWxQdkFTQVVmNUovdzNNWjZ6N0R0KzFWN21LaHZoS3du?=
 =?iso-2022-jp?B?MERwcHJFWExodWNUd3BaK1RCdFc4eFNGSktRcmNoRmdlL29oZFpxZFY4?=
 =?iso-2022-jp?B?YXFCVTArWWJQMXEweTdwSTQzVGlTSis0OEhTUWt0b2NVYmxoZlRRNEc4?=
 =?iso-2022-jp?B?Wlpid0dyVUhMekl0ZGhoY25PTitYVGRGVHBUNG9PUUs3UXRkVzlHUXk3?=
 =?iso-2022-jp?B?aHQvOUkxOE1QLzBrMkJwb2JyaGJqSUtIUkVKTGg3NURtQ3hJSDEzb2hk?=
 =?iso-2022-jp?B?YThWYzhRMWRENk0rQnZVckwrTUFVTFBEQmNvQ0c0a3N6WUJNSlZGdjNh?=
 =?iso-2022-jp?B?dVB0WEtMOC9TWG9VeDNXOVRaVGQ3TnBtYXdLNFJlTHB0RzV1aklsbVcw?=
 =?iso-2022-jp?B?Q01YR1FmLzlxS2doVDJxM0NsS3ZManFBbmNCOUNVa1Zod2NVaW0rRkFj?=
 =?iso-2022-jp?B?MXZTU2p5WlRvWmtDSkxORWNmSVlYeDVXaWNUTXlST2NueWpsRVhRRHhR?=
 =?iso-2022-jp?B?eHlDTDRtV0s0N3FuNG50VzRKc2VnVEJXYmxxRXEybzN6Umt5YmZnSm0w?=
 =?iso-2022-jp?B?Yi9TWnB6U2xId0xYRG96dUhWaHVxU3NPYWdCV2t5MWhaUUh2VXdZdmdN?=
 =?iso-2022-jp?B?TFlXdy9GUXVlT1I2RC9GZDc0dkJDOFJIb0U0am9pcXRLUTBtUXlIYi92?=
 =?iso-2022-jp?B?bnAzK3E0a1RzeVZzc0FGYTBJMm9BaS9Bc2NnK0pUOS9tT0xzSFhLU1lP?=
 =?iso-2022-jp?B?dGRzNXZuMjZ4dTFwZ1FpMll4Mm1Qc0pFSnE4dUlzWDFHeEpBV0hrTFd4?=
 =?iso-2022-jp?B?T0xLT21ERkJtTlV2RURTRXRYOXNRQ0J4bnlMY1VBalFYdnJvWUZUZ0Nh?=
 =?iso-2022-jp?B?WjdhZlFXUlJXMDRoRnF0clBENURZbmRHWUF5YmVMaWV2RWxWNU9PMWhp?=
 =?iso-2022-jp?B?MkRhb0hQeC9QQUlLc2tOdUkzOFhzak9tdXlCZHEzcktEcEhXSUtXRnIx?=
 =?iso-2022-jp?B?SjdLRUJ0aU5WaWYyZm11K2tWZnRYS2QvQVA3dFVoS0RLOUUxUnUyR3d6?=
 =?iso-2022-jp?B?VE5vVUlJdnlYOGpMOUhHSFdiVExGcGpRNkN6WFBxNVZOV3ZLM3hCbTBG?=
 =?iso-2022-jp?B?U3VrRFZoOFdHbTlGdXQ1cDhtdmpsam9rbXZyZz09?=
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0401MB6611.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d211d95-ce7f-4e94-6add-08df04fe7b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 12:18:34.2934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZW4c/mJ9c3r6p+D+ZQkN8M6xS5867h5Gu2oDz3CUVNK730dixQaRRR/tBN7ruR1nTrd+LTD5UmtFV7ZWZ51Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8074
X-Headers-End: 1wzx1f-0006mO-Il
Subject: [f2fs-dev] [PATCH 0/2] f2fs: multi-device expandable storage support
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
 =?iso-2022-jp?B?GyRCTXsyURsoQjEx?= <ke.li11@transsion.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: "ke.li11" <ke.li11@transsion.com>

This series improves multi-device F2FS for expandable storage setups
where a secondary block device holds warm/cold data and may be removed
after userspace performs a final shrink.

Patch 1 adds an alloc_primary mount option.  By default F2FS steers
warm/cold allocations to the secondary device via ALLOC_NEXT; this
option keeps them on the primary device when required by userspace
volume management.

Patch 2 extends f2fs_resize_fs() to allow a section-aligned shrink
that fully removes the last secondary device.  The on-disk superblock
path for that device is cleared before commit so the next mount does
not try to open a block device that userspace is deleting.  The
in-memory device is detached only after both the superblock update and
checkpoint succeed; the path is restored if either step fails.

Testing:
- Mounted /data as a multi-device F2FS filesystem with a secondary expand
  device (device=exp_user_device)
- Exercised dynamic resize while the expand volume is attached
- Shrunk the filesystem until the entire exp_user_device is removed;
  this triggers the drop_last_dev path in f2fs_resize_fs()
- Verified remount succeeds after userspace tears down the expand
  block device
- Mounted with and without alloc_primary and verified allocation behavior

Signed-off-by: ke.li11 <ke.li11@transsion.com>

ke.li11 (2):
  f2fs: add alloc_primary mount option
  f2fs: allow f2fs_resize_fs to drop the last secondary device

 Documentation/filesystems/f2fs.rst |   3 +
 fs/f2fs/f2fs.h                     |   6 ++
 fs/f2fs/gc.c                       | 127 +++++++++++++++++++++++++++--
 fs/f2fs/super.c                    |  12 +++
 4 files changed, 143 insertions(+), 5 deletions(-)

-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
