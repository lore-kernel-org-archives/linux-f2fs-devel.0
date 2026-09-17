Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC547C88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ZmXzh5WFrrG2RS6X2sMTiXOk2r9NO1+emCctyEt2HA=; b=HjYWVXJsjLCK2m74karnIc1uwg
	ZSmM0NF5hpNoHqFz3R1/Yfk0ZTXlZh8Trs4VyOPqi3D4U3JiDdLwsMdH9zJgzyVNvpO9CTSH9J049
	TQIQbuGpxZuSOJ8N8iCTPrWzhHaoEtV4/OLZuDFAW/pX/j6Qq8NTY/9uShR5m56Krf7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7D2G-00088H-Bb;
	Thu, 17 Sep 2026 14:24:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <arnd@kernel.org>) id 1x7D21-000882-K5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:24:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cdva6YpF/Ja+1yjzpPsUXCUumY3O2u6hUMGtR0VRNpo=; b=RW7cgT0aI+0L6m80oyeoVtnVc4
 DmH4vr3OKRsy29bgSgsZfIeLFFaYmLvMaB6SKnrOTvwyVoBJMarlz2KzPTS1WLCjx9pIwJbgcyYR1
 Stmucpb+SzPOnEK4QFZAMYjhJutB9lGD+jJx54ItRMGVliPU/WmPanFo92zOwYgoHM6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Cdva6YpF/Ja+1yjzpPsUXCUumY3O2u6hUMGtR0VRNpo=; b=g
 YC4uY2CPvAmDJ/RDW37KPlnlTeBsFIsm4casoHr3LpOReTNiHE7SeDBm01O5r93N1UZLT5cq2Rnxm
 FK8+ObwUlomzcJNAo9dWaXqcp9E0UzIPJ7/IoGu7U+tqxf7LaIm88ONWMt+Z4VGI8s3gFIndThrJb
 L5V3MjLuWe818zrE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7D20-0003OW-13 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:24:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0CD3438CB;
 Thu, 17 Sep 2026 14:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63C31F000FF;
 Thu, 17 Sep 2026 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789655042;
 bh=Cdva6YpF/Ja+1yjzpPsUXCUumY3O2u6hUMGtR0VRNpo=;
 h=From:To:Cc:Subject:Date;
 b=X0MollIMPRneb9S1Dc5mWlLOeAeV5sc0w8LGstnzb4Z3p16J/udWOCiDjGiDb6nB6
 kc3V3uyJ9uG52wFSxTwqUrSu6rC1u5pO0TTmqUqCIRv9C/yB7H8fwv0gsScPK3m86F
 E5HCpVk2js3bPdnRnGjF1QQxO6nWnySUj5SAJbBvs+hrvid8fRnsy7q2bveLi8VHH3
 reLJYhJ0St9MQf6jzmVMfvn6dSoAX9TrBHW4SkX0Rs/3PO6DniGu5Gsz/Gb3u/eNFK
 cqepOPT5zUo6alNheK5SybThILWKSoGWbseUBTRPsilpKyzRvRzrU0/6S8yTQUUV3h
 Ps58AhixZQHlw==
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Jianan Huang <jnhuang95@gmail.com>
Date: Thu, 17 Sep 2026 16:21:42 +0200
Message-ID: <20260917142222.1591270-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x7D20-0003OW-13
Subject: [f2fs-dev] [PATCH] f2fs: quota: fix unused-label warning
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
From: Arnd Bergmann via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Arnd Bergmann <arnd@kernel.org>
Cc: Kelvin Zhang <zhangxp1998@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Arnd Bergmann <arnd@arndb.de>

The newly added label causes a warning when QUOTA is turned off:

fs/f2fs/super.c: In function '__f2fs_remount':
fs/f2fs/super.c:3142:1: error: label 'restore_holder' defined but not used [-Werror=unused-label]
 3142 | restore_holder:
      | ^~~~~~~~~~~~~~

Fixes: 3f140a60c92a ("f2fs: quota: fix stale lock holder on remount failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6a2f09c61dcd..8358cdefa859 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3139,7 +3139,9 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sbi->mount_opt = org_mount_opt;
 	sb->s_flags = old_sb_flags;
 
+#ifdef CONFIG_QUOTA
 restore_holder:
+#endif
 	sbi->umount_lock_holder = NULL;
 	return err;
 }
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
