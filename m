Return-Path: <SRS0=nAgU=C4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8036BC43464
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 19 Sep 2020 03:33:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F342D21897;
	Sat, 19 Sep 2020 03:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fWjoGUf2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QAvGkKAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F342D21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kJTca-0003K1-OL; Sat, 19 Sep 2020 03:33:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangxiaojun11@huawei.com>) id 1kJTcY-0003Jk-OJ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 19 Sep 2020 03:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VKcu4akA2WUwACL03jbZBTBBCZR5JN4uSZcGQPsxh0k=; b=fWjoGUf29W1KBqlK7JuyKJPfjS
 FnAKmKqzWSpoCEK/Sz0uFeqwVOxdoHDhSHCXZJASeUB5m7zrADuJcu8vM23tIIGQQuPKC2kP+Nedr
 E9qa+WoEjornFvUEWCFjOx77S6DxZW05E5WaJ5rtf+An3HW4T/rUhNdYoMlJbGlOE+Uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VKcu4akA2WUwACL03jbZBTBBCZR5JN4uSZcGQPsxh0k=; b=Q
 AvGkKAbnNZ7k32r/9sCHr/hYlbKrT7l1VedPk48OKxBIqfyke6GHFtJSWcDbfB3df5PxZPZLGfu+h
 LFlGc0ULA3V9ZYgvOLWssIfGospAiaOSpGVOYtx2T+H2ZLSAyOmzRnS0kR7vUt4UWGds6N1/vZwnm
 5+RUDL2api1tEPXo=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kJTcS-00EyO3-Up
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 19 Sep 2020 03:33:06 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 201563989844E7C05BDA;
 Sat, 19 Sep 2020 11:32:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 11:32:43 +0800
From: Wang Xiaojun <wangxiaojun11@huawei.com>
To: <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Date: Sat, 19 Sep 2020 11:35:05 +0800
Message-ID: <20200919033505.317527-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
X-Headers-End: 1kJTcS-00EyO3-Up
Subject: [f2fs-dev] [PATCH] f2fs: remove unused check on version_bitmap
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A NULL will not be return by __bitmap_ptr here.
Remove the unused check.

Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
---
 fs/f2fs/node.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cb1b5b61a1da..2cf11662f784 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3105,9 +3105,6 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
 	version_bitmap = __bitmap_ptr(sbi, NAT_BITMAP);
-	if (!version_bitmap)
-		return -EFAULT;
-
 	nm_i->nat_bitmap = kmemdup(version_bitmap, nm_i->bitmap_size,
 					GFP_KERNEL);
 	if (!nm_i->nat_bitmap)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
