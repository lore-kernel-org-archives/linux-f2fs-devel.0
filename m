Return-Path: <SRS0=UNYl=FC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C9C63777
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Nov 2020 17:41:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97FD246DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 28 Nov 2020 17:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Yy/K+hvS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CbliGMU4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgCPDm1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97FD246DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kj4EF-00017X-LZ; Sat, 28 Nov 2020 17:41:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shacharr@gmail.com>) id 1kj4EE-00017P-5e
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Nov 2020 17:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=40L//mR7mpkTS3t1iaELnVbQvjPoARioHELJuLQ1ZOA=; b=Yy/K+hvSYzvW7+IeABSISAGIrt
 sws038PsdznN2hlysAS9RF1CdZGspXFLeyJEe9wkWEaH1PbSwesSwzeZplWgFupApXnvkL556rCSL
 9hKPFkSpHg3UWUzPZPkKgVQVoEwtfCNaIkMdj6Wrb+hxxBMlh+bF3a1F22er5jhLdiFo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=40L//mR7mpkTS3t1iaELnVbQvjPoARioHELJuLQ1ZOA=; b=C
 bliGMU40ue71A/aTKADDEZvHrpJ9JEIT8V31BKoS1o930PiXG3DisW5YgInK05supQ5O4Y4utbesM
 KqTPCyAIzLkxyv4N4P3FHXTnGexB7Qs8vA5ygvZAZc8Sypf+r0H5xv636moeOjiMIVZPcS5eYwVK1
 QJOUZF2v2PFvrR6I=;
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kj4E3-003JRm-Pe
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Nov 2020 17:41:46 +0000
Received: by mail-pl1-f193.google.com with SMTP id l1so4207314pld.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2020 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=40L//mR7mpkTS3t1iaELnVbQvjPoARioHELJuLQ1ZOA=;
 b=pgCPDm1rOx/KGw+G2zsZ96CTC3/SsDRwhMm57nw4knrqMFbvKIDkQEzD0bDuGjFg06
 qrAQNqeRfIYRbWlprQf5fc3bWlgjxUPQIw1Sk5AbWwdhsu2VlbbYM7VFBBHKm90qyWzJ
 k8Dzm7PH1tvsACKQ48DXq/iB0GLHIzc5v0QPZipTdYGw9mxzBEdQnb2ckuV50+asQp15
 apeu0PQFPCRM6SUup8X+yJXrtjkUzrsmm4y7/vMa/YKAKb5u27GXWfLpnXkpHeqfk515
 opvXeZRjKkiRhDMm484VO1f0KKmdYKDb8nUujZ8DhFGoJ6p/USH8SB4BZh/j1YQfGDFw
 eTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=40L//mR7mpkTS3t1iaELnVbQvjPoARioHELJuLQ1ZOA=;
 b=VttwpIcQFV2O3ryG8TJm1jZLChVofLRHYllfdVAioP8cv2j4pNUw+XO8etW67NSgt1
 Zlfy1BWwSYDIYfvZfXpXsSAk0ohGhZNi3ZuLB36Q/tH/0Qvy8ix6Gg0kXhjuqlCG5aCl
 1mWeV+FL0PQzPbAG5z+p0YRH6qHS1ieaN/AFiKaxNP3KrjQILDlb4yCOcvKvpIn1apEZ
 6L6+YFTZAdQmxhY1Y+vkw9IX0gC7Yiub/K8vtWneMxHjmEEQ9O609LXnJJYC4pzrTMdv
 PYMCKrBbypq5DMhMaFNHnvRJ5RDr5jnoSgrc0LWbjeV0WZ5JHi4VT/p6O14asaSbTDYP
 ihyw==
X-Gm-Message-State: AOAM530+4pacFKWKjYKJlSDhdks8Huab91x2lFX3FIhmVwAKa6RnX4of
 L9Qv+OF1Phr0kXx1BGGx9JB0Focf4ACPpj91
X-Google-Smtp-Source: ABdhPJwPOscNvx1pSiNFc6Cpt1i7blHZkozSHzGjS9avpj0QcYGA1CLtmW6e+ZzXXJU5kXMuNPx8ww==
X-Received: by 2002:a17:902:32d:b029:d9:d8a9:11e4 with SMTP id
 42-20020a170902032db02900d9d8a911e4mr11883997pld.6.1606585290184; 
 Sat, 28 Nov 2020 09:41:30 -0800 (PST)
Received: from hpilion.hsd1.wa.comcast.net
 (50-47-105-203.evrt.wa.frontiernet.net. [50.47.105.203])
 by smtp.gmail.com with ESMTPSA id gb4sm15610246pjb.30.2020.11.28.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2020 09:41:29 -0800 (PST)
From: Shachar Raindel <shacharr@gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com,
 daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 28 Nov 2020 09:41:24 -0800
Message-Id: <20201128174124.22397-1-shacharr@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Headers-End: 1kj4E3-003JRm-Pe
Subject: [f2fs-dev] [PATCH] f2fs: Fix deadlock between f2fs_quota_sync and
 block_operation
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This deadlock is hitting Android users (Pixel 3/3a/4) with Magisk, due
to frequent umount/mount operations that trigger quota_sync, hitting
the race. See https://github.com/topjohnwu/Magisk/issues/3171 for
additional impact discussion.

In commit db6ec53b7e03, we added a semaphore to protect quota flags.
As part of this commit, we changed f2fs_quota_sync to call
f2fs_lock_op, in an attempt to prevent an AB/BA type deadlock with
quota_sem locking in block_operation.  However, rwsem in Linux is not
recursive. Therefore, the following deadlock can occur:

f2fs_quota_sync
down_read(cp_rwsem) // f2fs_lock_op
filemap_fdatawrite
f2fs_write_data_pages
...
                                   block_opertaion
				   down_write(cp_rwsem) - marks rwsem as
				                          "writer pending"
down_read_trylock(cp_rwsem) - fails as there is
                              a writer pending.
			      Code keeps on trying,
			      live-locking the filesystem.

We solve this by creating a new rwsem, used specifically to
synchronize this case, instead of attempting to reuse an existing
lock.

Signed-off-by: Shachar Raindel <shacharr@gmail.com>

Fixes: db6ec53b7e03 f2fs: add a rw_sem to cover quota flag changes
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/super.c | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..b3e55137be7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1448,6 +1448,7 @@ struct f2fs_sb_info {
 	struct inode *meta_inode;		/* cache meta blocks */
 	struct mutex cp_mutex;			/* checkpoint procedure lock */
 	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
+	struct rw_semaphore cp_quota_rwsem;    	/* blocking quota sync operations */
 	struct rw_semaphore node_write;		/* locking node writes */
 	struct rw_semaphore node_change;	/* locking node change */
 	wait_queue_head_t cp_wait;
@@ -1961,12 +1962,14 @@ static inline void f2fs_unlock_op(struct f2fs_sb_info *sbi)
 
 static inline void f2fs_lock_all(struct f2fs_sb_info *sbi)
 {
+	down_write(&sbi->cp_quota_rwsem);
 	down_write(&sbi->cp_rwsem);
 }
 
 static inline void f2fs_unlock_all(struct f2fs_sb_info *sbi)
 {
 	up_write(&sbi->cp_rwsem);
+	up_write(&sbi->cp_quota_rwsem);
 }
 
 static inline int __get_cp_reason(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00eff2f51807..5ce61147d7e5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2209,8 +2209,16 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	 *  f2fs_dquot_commit
 	 *                            block_operation
 	 *                            down_read(quota_sem)
+	 *
+	 * However, we cannot use the cp_rwsem to prevent this
+	 * deadlock, as the cp_rwsem is taken for read inside the
+	 * f2fs_dquot_commit code, and rwsem is not recursive.
+	 *
+	 * We therefore use a special lock to synchronize
+	 * f2fs_quota_sync with block_operations, as this is the only
+	 * place where such recursion occurs.
 	 */
-	f2fs_lock_op(sbi);
+	down_read(&sbi->cp_quota_rwsem);
 
 	down_read(&sbi->quota_sem);
 	ret = dquot_writeback_dquots(sb, type);
@@ -2251,7 +2259,7 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	if (ret)
 		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 	up_read(&sbi->quota_sem);
-	f2fs_unlock_op(sbi);
+	up_read(&sbi->cp_quota_rwsem);
 	return ret;
 }
 
@@ -3599,6 +3607,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	init_rwsem(&sbi->cp_rwsem);
 	init_rwsem(&sbi->quota_sem);
+	init_rwsem(&sbi->cp_quota_rwsem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
-- 
2.29.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
