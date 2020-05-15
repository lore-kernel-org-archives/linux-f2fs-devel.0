Return-Path: <SRS0=D49P=65=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D160C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2020 07:37:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1DE2065C;
	Fri, 15 May 2020 07:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JlU95Pyn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Dy42rc2o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mc53IrWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1DE2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZUuS-0000bn-FD; Fri, 15 May 2020 07:37:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stanley.chu@mediatek.com>) id 1jZUuR-0000bb-Fq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 07:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/DCO/zS7sesB2PVRfTMTsSwE8pj4v6mVVtmNsnUpisY=; b=JlU95PynKVaLpTKZi1z1hRgmQw
 r5T01WeKB1I8pRROMS3Lq19QceA2HLprCrtjuFmoQIOILD7D76rLHLriLi1KEcBK/DsoPy4Fc2PzD
 UWTv5UhZVKI1gOGAsY8iSazdKAGrNXF47nR2iKgloANRsSVKt7oPEi95XUyFPKi2ZQWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/DCO/zS7sesB2PVRfTMTsSwE8pj4v6mVVtmNsnUpisY=; b=Dy42rc2oqyTVdHqstM9HYqjbCq
 0fk1d1oGg2jRoTbAarpFR56B5SZArDbTl1s/ZIhGbtBFveQwaj41Je/wUByFC7CU/9w3n1xrl6jXW
 bwvZBlOHJbTLc7ZrPlSdF83HuYleSqXemX4tU2iU9VPISqUAwAqEjX8zcFiJXe/7sfLI=;
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1jZUuM-008HbN-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 07:37:31 +0000
X-UUID: 592f197f268745128398747fa762b992-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=/DCO/zS7sesB2PVRfTMTsSwE8pj4v6mVVtmNsnUpisY=; 
 b=mc53IrWVbJ+QF+yITq9W+RJtiRzw/Im0K8UCmXksgoT20zYkNPfdBnBiDEemIfDnQnt2H3YNc7uARzMCvDYBH4p7wCZKMDWVvoe4trS35E7ICLkv+vNXWRV01seYMGFC8/GgBzTsI6rOkU4iv1+LT5PZ6vbeikuIROOKSCQZ6Vs=;
X-UUID: 592f197f268745128398747fa762b992-20200515
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <stanley.chu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1287260482; Fri, 15 May 2020 15:37:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 15:37:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 15:37:06 +0800
Message-ID: <1589528228.3197.114.camel@mtkswgap22>
From: Stanley Chu <stanley.chu@mediatek.com>
To: Satya Tangirala <satyat@google.com>
Date: Fri, 15 May 2020 15:37:08 +0800
In-Reply-To: <20200514003727.69001-9-satyat@google.com>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514003727.69001-9-satyat@google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3162AC34A7748C1611374E99FEE9C8C991AB3926776566336456D27B7D911DA92000:8
X-MTK: N
X-Headers-End: 1jZUuM-008HbN-Cc
Subject: Re: [f2fs-dev] [PATCH v13 08/12] scsi: ufs: Add inline encryption
 support to UFS
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Satya,

On Thu, 2020-05-14 at 00:37 +0000, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Thanks Satya and Eric so much to make inline encryption upstreamed.

I will provide essential MediaTek vops patch to adopt this framework
soon.

Thanks,
Stanley Chu



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
