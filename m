Return-Path: <SRS0=yuZv=U3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED2C4321A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Jun 2019 11:06:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD4520645;
	Fri, 28 Jun 2019 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jH3Us0c5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mVUIH3G3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD4520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hgohW-0002mf-Bl; Fri, 28 Jun 2019 11:05:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1hgohU-0002mC-Hx
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 11:05:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kImcAoU0RwTBNjcgSEvQppC506wCUmjoPlq1zNA+Q2c=; b=jH3Us0c5TGsszKE27u7KH6WOBZ
 Nk3onXZnT6Qx6sHceDS2SNdYGSRz8DCxwrbtxtFyvqcuGitpHcRlioEsGMCAkCewfat+DyRvjO5LT
 XJq0S6AuLzRqTEc4PnrDWLvBt3j6emteqi7K7ZMslyXoneW6Dy8Gf+IIp0q/O2UzjjfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kImcAoU0RwTBNjcgSEvQppC506wCUmjoPlq1zNA+Q2c=; b=m
 VUIH3G3AiXMfnje6FZjIe5NG88c87ZJWQrSPf/sk1AZG+nfnv2QPF2lgDukyHZ0V5EqzXCPmEGO0m
 +/hvqLOgPj8A68hwB55wsdNeSWvjWHGZQKwQbhExzZSWGb3sOF2L+tK5IU5dpMA16cKMsZeG3CRTR
 ssfnZfRKT5PZHzFY=;
Received: from mout.kundenserver.de ([212.227.17.13])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hgohi-000kJU-7E
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Jun 2019 11:06:07 +0000
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mqrjz-1iJykT2h0L-00mrot; Fri, 28 Jun 2019 12:40:08 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <yuchao0@huawei.com>
Date: Fri, 28 Jun 2019 12:39:52 +0200
Message-Id: <20190628104007.2721479-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:i9pne7gOZCrulnXnNLDG96catfF75e570yRKxFiuSSGz1wserXj
 V+2v6vNon66+ukSkKeYP5KgkYiApttcBaBPeaidxkb24oPlO/LH7M7D126r1GBTEdd3AUPT
 XVYSmsJyz5A2TCi4arN4hYixkHJpsVxqxfNhgPx8TlBTZfg/yCy23rrqI9LR6mBaIymqMc5
 Jm+Rl+eFnIXH0yVU148rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KJiQv/emUw=:7IQFRd/mOhYCKn3no/O0kc
 u1ltsu6R2XULDhTAoZRVfEzoURCfnSkCLoKqLc582Nqi0Y8fMTrv2+3d8K4nN6aRdHbic9w/b
 a2JazNXfjjJKxMhXYDsaUc/fc4TN7DdgeJUQ01grH/S97iddPnl/R696IqHU1LrsgP+nlj5r1
 3coJ/VkP/+XTX/6qqWCHIMpBe9t8zk92PeD0EFOknk64TzZ37dJHsBFYjYwXoUBnG3pbtQrbS
 e5u6+Le5l43s8B5pLWvzGojkAn1shDmPZDuBTiPM7zPfzJcj4CS+qxAYzJQc7LzMrGtQU6U3m
 mqzfFjSjX9nqgpchG/E2eY/3zat9q3tSZ/WwyLUsNi5N++BLn0Xf9Hca3EwPvlrm8b/OK4gwz
 EGag233hCZ8fYoSHU5EWUAdeZtTtauV8pU9FE/jKtSRqgujGxllgub7tBZoMgyzZK5TtqOOH8
 Ess7Mq2+6OydCw2lIUcEyHirPCamFZlbwtT2JwvdNw59ownxei59pDC5uD+GID88l7qJMapwK
 miUOSBI95+umxkoVtzNTprkuzCywBp0Tn08RfHu0bfxtK2Dr3XS0B38gzOZz6wvIxQKwlUP56
 i/l9ifZ02+B7RgQhiJX/5im2TPxLCwuoDEFWEtogVF30b9bsGYETHxxFLubAEr6tF52ZW3a6S
 yp2aUh+sTFaYF9OkjoUPgL3YsfErqZufqEqOBeVIIw2+4vFDgwhsxMghEW3p2zT+9IRIAWXed
 v7BqEfs29krz5HTHOyB7up5MqKpwbP1vWmUYWg==
X-Headers-End: 1hgohi-000kJU-7E
Subject: [f2fs-dev] [PATCH] f2fs: fix 32-bit linking
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
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
 linux-kernel@vger.kernel.org, Wang Shilong <wangshilong1991@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Not all architectures support get_user() with a 64-bit argument:

ERROR: "__get_user_bad" [fs/f2fs/f2fs.ko] undefined!

Use copy_from_user() here, this will always work.

Fixes: d2ae7494d043 ("f2fs: ioctl for removing a range from F2FS")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 998affe31419..465853029b8e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3066,7 +3066,8 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
-	if (get_user(block_count, (__u64 __user *)arg))
+	if (copy_from_user(&block_count, (void __user *)arg,
+			   sizeof(block_count)))
 		return -EFAULT;
 
 	ret = f2fs_resize_fs(sbi, block_count);
-- 
2.20.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
