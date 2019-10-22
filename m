Return-Path: <SRS0=7Gzg=YP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59907CA9EB7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:26:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFB82064B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Io2NLNI0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="N8mnbw33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFB82064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iMqR6-0000ES-MZ; Tue, 22 Oct 2019 09:26:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iMqR4-0000E4-Pg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Oct 2019 09:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNwfu6S54+AuksbyENCGJAE2ctkJ2UMDaumR6hhN/8k=; b=Io2NLNI0szll75h4ktdfOfUZUA
 wmLCI/YEMfP8o5sJP3+t24gYa8B0jwtl0FW5Mur34ob5TwvajWozOvQZv2ohVcrzI5Mi24vnWnE//
 agwDWN/oYATetvw8F2W2UU1bs6RVK+22msPU5y8IGfuh33BYmvtcHCGTgoydWXtsGVIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vNwfu6S54+AuksbyENCGJAE2ctkJ2UMDaumR6hhN/8k=; b=N
 8mnbw33fs+J7x6jgKesczwUXxAJ9PhhDcKVdID5c5fpd/1iKA1foANYxzX5g6Os0cbk3D7tkaG3pZ
 3+brwgOgbA2ijdPEHh7md6FUkjCjsrI48MquEdebvAhnIN/vB6U0+rdg7oYzsRTfq5xNHhHzw4X+F
 NILJiPZhw7BBN3F8=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iMqR3-00BH7J-Ck
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Oct 2019 09:26:38 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BC7A0B948B91837CA99E;
 Tue, 22 Oct 2019 17:26:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 22 Oct 2019 17:26:24 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Tue, 22 Oct 2019 17:26:11 +0800
Message-ID: <20191022092611.58191-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1iMqR3-00BH7J-Ck
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong description in document
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As reported in bugzilla, default value of DEF_RAM_THRESHOLD was fixed by
commit 29710bcf9426 ("f2fs: fix wrong percentage"), however leaving wrong
description in document, fix it.

https://bugzilla.kernel.org/show_bug.cgi?id=205203

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 7e1991328473..29020af0cff9 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -346,7 +346,7 @@ Files in /sys/fs/f2fs/<devname>
 
  ram_thresh                   This parameter controls the memory footprint used
 			      by free nids and cached nat entries. By default,
-			      10 is set, which indicates 10 MB / 1 GB RAM.
+			      1 is set, which indicates 10 MB / 1 GB RAM.
 
  ra_nid_pages		      When building free nids, F2FS reads NAT blocks
 			      ahead for speed up. Default is 0.
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
