Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE1BC32792
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 20 Aug 2022 03:06:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oPEok-0007Ve-Td;
	Sat, 20 Aug 2022 03:06:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oPEoj-0007VX-CK
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Aug 2022 03:06:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RAI2JlXHqyYOnDYC2QHx5zoOZm6pRlSIPdpvDGrb6Mo=; b=mMkNx00bINQgj8vFuix1584XWw
 WEgQWdKulIQKUp2ApgHlW+IYEh4Wdmu6fnzdCXnfA20Qsr2fN1v7Ugr5ikgzLYoxuSS+Poizlgcq4
 qb8nojygFoUMU+dTs4XiYyD3Ur1u8U9+JeLWAw2e7rs+/QelgUGIbONI6Q/eDjPOgJYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RAI2JlXHqyYOnDYC2QHx5zoOZm6pRlSIPdpvDGrb6Mo=; b=S
 6nMYhcNgvDp9DrL1Tfxgw7xlfzPvd4w87HQzDc+NXYpVzNiY7gyYp3yTNUudZSHW9xtzcNwQYYgbF
 7Z+cT1mxgWqnLYAXzPnU/2ORMavz8ubthjB3QNaVR1NVIYKdF+mPG99bw7W9SdSQ+ujQPzqRomaiA
 4xuiuy8zLWrvhPhY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oPEoi-0003d0-Hp for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 20 Aug 2022 03:06:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A9672B82A31;
 Sat, 20 Aug 2022 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D7C433D6;
 Sat, 20 Aug 2022 03:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660964783;
 bh=RjXdwcWPdrL/4i/EG/8q1BEfNqlJJsKx6SU+UP5QRPw=;
 h=From:To:Cc:Subject:Date:From;
 b=cQJmhXReefvs4vo15RyLZNBCE1Z171mHdnAorUr5JRdxVCnsag7L5hfgJwsV2kAY+
 CGpZmMHIp913AsoAqWdBYuY9HbNY6Im7aiXr8B9mEeXOwpikW3PRbdMU5pJitg7w3/
 sYZHySvUpLrJLNYccWctGqR+pmOJ1ZczQubagG4xo4qHhjQZy9JAxR2BF/JdeyPGMd
 drRUE0cyV/WMp3r8tqvGMJ4ib+oqAjgVtMSbb04l3y2X+gZiwWQwzwcPR0ATM9nnNO
 aVbxbCFgy6NNZKIxwdaOw0vNRPnK2LkmdjKQ4SiGXIQ/5ZWLt0ecYok5NPvWzj7/Qa
 TSmCb8YiLDPbA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sat, 20 Aug 2022 11:06:00 +0800
Message-Id: <20220820030600.3509403-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oPEoi-0003d0-Hp
Subject: [f2fs-dev] [PATCH] f2fs: remove gc_urgent_high_limited for cleanup
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

From: Chao Yu <chao.yu@oppo.com>

Remove redundant sbi->gc_urgent_high_limited.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/gc.c    | 8 ++++----
 fs/f2fs/sysfs.c | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e47d5e77ec7..088c3d1574b8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1731,7 +1731,6 @@ struct f2fs_sb_info {
 	unsigned int gc_mode;			/* current GC state */
 	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	spinlock_t gc_urgent_high_lock;
-	bool gc_urgent_high_limited;		/* indicates having limited trial count */
 	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
 
 	/* for skip statistic */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2a3816c20f84..fd400d148afb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -97,10 +97,10 @@ static int gc_thread_func(void *data)
 		 */
 		if (sbi->gc_mode == GC_URGENT_HIGH) {
 			spin_lock(&sbi->gc_urgent_high_lock);
-			if (sbi->gc_urgent_high_limited &&
-					!sbi->gc_urgent_high_remaining--) {
-				sbi->gc_urgent_high_limited = false;
-				sbi->gc_mode = GC_NORMAL;
+			if (sbi->gc_urgent_high_remaining) {
+				sbi->gc_urgent_high_remaining--;
+				if (!sbi->gc_urgent_high_remaining)
+					sbi->gc_mode = GC_NORMAL;
 			}
 			spin_unlock(&sbi->gc_urgent_high_lock);
 		}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index eba5fb1629d7..39ebf0ad133a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -527,7 +527,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
 		spin_lock(&sbi->gc_urgent_high_lock);
-		sbi->gc_urgent_high_limited = t != 0;
 		sbi->gc_urgent_high_remaining = t;
 		spin_unlock(&sbi->gc_urgent_high_lock);
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
