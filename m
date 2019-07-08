Return-Path: <SRS0=R28F=VF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C3C0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jul 2019 02:17:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1D820665;
	Mon,  8 Jul 2019 02:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CSozjPuG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="YEb5fvD7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BJd6suig";
	dkim=neutral (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ee4LqQup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1D820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkJDh-000371-RZ; Mon, 08 Jul 2019 02:17:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=085e64fe2=Damien.LeMoal@wdc.com>)
 id 1hkJDg-00036q-Th
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 02:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=MIME-Version:Content-Transfer-Encoding:Content-Type
 :References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=; b=CSozjPuGKPHfOWHDYlx9Z8/OPK
 kzu3u853X8T7ESQAsKZgPpAy9ux0hxKzzcrFhynBV+CV9S1VWOav0vh7UI/OOglYrRFBqv/fww6XX
 4K9CmHyvsM4tmDyGJxbNaBrp2G2oWQLlr7PZwsarLuHqom/vRwKrzg4jqirmFDQoIlsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:Message-ID
 :Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=; b=Y
 Eb5fvD7pnGbM2YybEaYztlVOLlVXZl/kUoNnzBExM/6WDoC3iEM3H9jwO7EYiZkdZZfIjqtcutNuK
 +Cje4xWq2+KyFZWNYb88nr6rqyaPx+umh93J3IaSQf1iJtkrfSsKlN+DLj7yxdwcRyf6EBruuzzXe
 C/cS4QHYNNKP089Y=;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hkJDu-00ArQ2-Ea
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 02:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562552267; x=1594088267;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=;
 b=BJd6suigPO+alQkC5xFzAVBNJAlyQdxuvQzP1e3GOPvpDByS73kNt84i
 xJDEgwGTwgioSy8OIEhe3rNepwOgTY8xlRXInayccVopgXIAZnyPA3NCb
 4aBzT4HDJiP+t5FK+ANdwpaRZrB2Hhp25WF6VwHPn12wFtKpfxSOc2E8q
 oDWgXDP2zh+M2LbRB2HPmscZef+4BLPlAORF3oVnLQf6B8V3Qy+huHBua
 enIxYWdN80sZjBvrvwnvi0cPNJhQe3DpdikHZzrjBpLcIhPUMw8IBhn4N
 /AokxdidTAsfLlF1dOb/cmriY9wBdCoPVERfMmRyz/t4f+H7WNw1Ivcwn A==;
IronPort-SDR: Nuwvt1vSYB9AK/4EaB3/mkm2iSck6iVQOHpsJiylSYGGHgRdPHP5Fxa0U2uM6JwiHfYX2RqS4d
 nnDW/tm6lxfDOo2cXQaD0epQwVdqoVhAQGnRuwzENrRquLXqYwb8EgVfUwN4ciwFg/QEPbaxag
 NRs43ByCufgghDlalQK7TTqVT2iDll2WEVAgLPRmB116un+dbVqzZpsp15wohvyKL5fmipJU7h
 /p61xz+iaZbEHBPQWWD0qE2m/mSYH0I+5M20M69aXQK/xU0ZPK2zhSF1edxTIOhDBb7csuTkO8
 LXA=
X-IronPort-AV: E=Sophos;i="5.63,464,1557158400"; d="scan'208";a="113580885"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2019 10:02:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dywAFDrj0MfAgVkHqaTVZ9P6BjevwEczcnCxLBSf4Sg=;
 b=ee4LqQuprJ1WGiHqfCiM/XbQeJ6M9xrEiDBXoHTs4BtNAjQlyNRDtFSkJ3tARCZBC79kIsJL2gq/TUQ1kkiYfTUB3IkzSnKFJxaORzudzWA84Ps+PYeCRJ85e3ATbtOrzqT/Yz7FnqxkdxmZkV7nydEZGIyO8MJe1DUC99u4lEg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.59.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 8 Jul 2019 02:02:07 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 02:02:07 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Mike Snitzer
 <snitzer@redhat.com>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, Jaegeuk Kim <jaegeuk@kernel.org>
Thread-Topic: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
Thread-Index: AQHVL8ssJYyertgVkky0I6r2FZ0yYw==
Date: Mon, 8 Jul 2019 02:02:06 +0000
Message-ID: <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0f2b04-9a7e-408b-18e0-08d7034847a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5864; 
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-microsoft-antispam-prvs: <BYAPR04MB58643D8DB32AAB7739ED6344E7F60@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(2501003)(486006)(26005)(6436002)(54906003)(53546011)(9686003)(316002)(53936002)(7416002)(476003)(446003)(55016002)(102836004)(76176011)(186003)(86362001)(6506007)(110136005)(7696005)(229853002)(8936002)(14444005)(2906002)(33656002)(81166006)(72206003)(99286004)(3846002)(81156014)(256004)(8676002)(478600001)(6246003)(66066001)(4744005)(71200400001)(7736002)(25786009)(71190400001)(4326008)(73956011)(66946007)(76116006)(91956017)(52536014)(68736007)(74316002)(6116002)(14454004)(5660300002)(66556008)(66446008)(305945005)(64756008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5864;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XSdjz4wqQe6MIde04G1uCKnIysFNjimO+WZUG9lZ03I1rJ/w0p2lygjCoM4s73jCaKXmbNBRsIAgDRUcBx7NqvSreO5D3xjEqm/UnyAVj7qhv1fnyDKkYLU1egwO+WWy/8TrPuK2VaptGKvc7dWdbQB7S5UBKYfA1bkySRe5TFTvVH3b7fqvkSs4l2YEITS7DbKdyMHa9AIBq9Ot+TnTLAIl+7uz8DArxvTnuF7vDuoCFHbpak5YRBh0HvCtFz5rHoi3OzsqUZhoGO+MQh3dlAZWvKVTuG70PZgE3kKCGfhIvVgsmf0OwFQjMwjDgEUiARuU+kpeJdcf/XT8cVcTcUfXsaaiLymGoJzcP2W2r00IWSKuuECUc5ebXtVuwkoMISfQE6QbxYSTY6izR5fOfVMLy6ooHwCH4IND8JJdm64=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f2b04-9a7e-408b-18e0-08d7034847a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 02:02:06.8556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
X-Headers-End: 1hkJDu-00ArQ2-Ea
Subject: Re: [f2fs-dev] [PATCH V6 0/4] Fix zone revalidation memory
 allocation failures
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
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/07/01 14:09, Damien Le Moal wrote:
> This series addresses a recuring problem with zone revalidation
> failures observed during extensive testing with memory constrained
> system and device hot-plugging.

Jens, Martin,

Any comment regarding this series ?

Best regards.

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
