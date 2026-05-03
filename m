Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B620EFF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  3 May 2026 04:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ObRiFawXqt7wDe69udZX8JKhASyaAs8r1aPDQm1/eNY=; b=X7QdkCp9Xdrg+PzvIDnWNQhXhN
	Z1zWQ7EJvBBEYcHE+xRjFkjJjiYc1xeXgJxEuzmLAHcD94wguoZMcB+b/akyQdrGrVI71wO1M3r4d
	P84SiAZVB0bgpQ9QOOLyKi30yx/l4dUESL4zxJg4X41IrstO8ErtYQeW3j1nWA/uv204=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJOuc-0004dN-Rj;
	Sun, 03 May 2026 04:58:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1wJOuc-0004dH-8p
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 04:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bx/V9bGyVRo8uv3ZHvZhi/z5CN9+7hIS1jPr7RlO1vw=; b=M+YnjpVQaacvq08sIPGVtCnjs6
 /eNCA3wNFzoAfp4oTI1bNWzXq9mAOrzmr5CU+BXsbvQdQb0+UuSLVXvJFB6BiEAY3/p4LFS7w/xX2
 59r5+7IYqy1JytkN6ytmh0VDvB+yRjfKdqwPNLQE6BAGL+X4Sc2zWvIumvlcqjaOYbOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bx/V9bGyVRo8uv3ZHvZhi/z5CN9+7hIS1jPr7RlO1vw=; b=a
 v9/3EPaghmwHXsl2dJX1+bDgEA5z/priZTq2sgq8s/BXxK/ZWOdfLYAqoONPdxvJKOKUI0uznKJxe
 FoSYTpDxX7TB/HXQpfkWebv46dPIRZQaLYQFjTivA6pkHXmikV5wAcrrTRCs+/gIjNHfwLDTgHqDh
 SyT5UGA0w/3MyJX8=;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wJOub-0002vC-PV for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 04:58:38 +0000
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2b458ca2296so17971655ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 02 May 2026 21:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777784312; x=1778389112; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bx/V9bGyVRo8uv3ZHvZhi/z5CN9+7hIS1jPr7RlO1vw=;
 b=eFPcgkcvy3MePUmEm/nfNrs0zpAavrGLsccy3AKD7F/gkQ296H+SqvvNvp4keiuT+s
 FLYO5cXmFuveYxCirNw6UO3vJJ5J+/QSZLedgWN+knsC1/3K+ZEBcv+H5B5Kd5i6+hOl
 HCrcNXTPRefuQl/680MR1HKq7Gg84pTAsOTcF4RIkgZ5dkoDyxEtwxjPnqeo4+tpW06T
 3qTKJVBex2l8KR9wZ0gtU8qHucVIsQnkHJYe9R9VrS8JpahVeekPVKNRwmEaLcxsal+H
 Unkxtt9yBo3/vCVv1xdCx7uPArnl4zxk+as+3UjGzDIHctoC792pEsB7t59x0DD39pnu
 gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777784312; x=1778389112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bx/V9bGyVRo8uv3ZHvZhi/z5CN9+7hIS1jPr7RlO1vw=;
 b=QP0mezzZkhVagsYbHj9iyBG3PzTYH2OyiZNrurxN1jsio/9qoEHk6dzJIMhU4F2ER+
 yKfj7bUIfOZQI9S+uyjIulbxrWqUzIVrlshWdBLHPJmpEWJn2dh/m9djgnY4GcPF0sve
 5hCrSs22s7GotcSSX7SxsG6yHZeAtHnPWfmq2ovdHlGEKdretAc1sA8ghcY0RhCh66wb
 ThGhbon3MzZL0s/8Z+89GmyYzbB8y7YU0H3jffe3/s9oFGKmZY3h7EMOvG+HgphnUHkY
 0eFN4yR7nL9L5Iqs1HKlmkgh5VM8k8aLM0ygIX3QHJ9sgPm+a5b6QxeLHJlhhg5Li4Bu
 J1JA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q2V0IxPy6PDRy7zf6ZGABp4M5br6sbK2e1bPm+GHq1ebhMS0MtFVTW48SiI+WkTwRy0pF9TyPZdoZwGBNmK0y@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw3iZ16xGfWFBlDaD72s+0ef33rD57Hojc1RcuVDhe4S5x2WRFG
 mmEzDibVOvJD8yd1qpei9pCgnDFv+Y9bhdUm3waR8iTquE4A4VDP5L9y
X-Gm-Gg: AeBDieu3BGUfemKMIA+sYHown1QNGsIL387eaMjUUGs8F01u1D/hsEYwEWXLBCE9miR
 0yRxVvNKKunK0hham+XvTbBlgnII49Sy38cQspYmu5BzWEQ9BKJ+olHnFFgObLqHOtQVsBzrzeT
 idG7R+vanPYNrhOOcuzr8Bqq1NtGyMEolT5klBDAO1q4PAzFewpqXQHWS84/TaDuR7zL4O83RNn
 E8bH643B0Bg6YwhrH/J7CmmfZ7bjnVvnFEVHAfsAVbEHoYoaL5+iQvj464qwv63WZqf+MnmBPIJ
 WYFcrU46AN293iPQ4gYl6uRUMKVqrVyAtZdGmv1nUTaHugFfsFOxxsYli8LKtXuMn4oySebPXgI
 WPrJnQ2UtjuVYs+eNdceAQ38945jT2R6ZY65Ae6OqWH7a6askVvTb6trqQCYIhWDd7/sE+2F32x
 9yYGH1DCKujpuQvCWUNOUGYDSMTTzY
X-Received: by 2002:a17:903:2885:b0:2b0:a957:304 with SMTP id
 d9443c01a7336-2b9f2566d07mr28812215ad.6.1777784311964; 
 Sat, 02 May 2026 21:58:31 -0700 (PDT)
Received: from localhost ([111.228.63.84]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaadf8dsm66729695ad.23.2026.05.02.21.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 21:58:31 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun,  3 May 2026 12:58:20 +0800
Message-Id: <20260503045820.973718-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1wJOub-0002vC-PV
Subject: [f2fs-dev] [PATCH] f2fs: start discard thread after mount recovery
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
Cc: baijiaju1990@gmail.com, quic_stummala@quicinc.com,
 Cen Zhang <zzzccc427@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The discard command control is built while the segment manager is
constructed, before the node manager is built and before mount recovery
has completed. Starting the discard thread from that constructor lets the
background thread run while f2fs_fill_super() is still publishing and
initializing mount-time state.

After commit d6d2b491a82e ("f2fs: allow to change discard policy based
on cached discard cmds"), issue_discard_thread() may consult node-manager
memory thresholds through f2fs_available_free_memory(). It can therefore
observe sbi->nm_info while f2fs_build_node_manager() is publishing and
initializing it. The same early-start window also lets the thread test
the superblock read-only state while recovery paths still make temporary
SB_RDONLY transitions.

Keep create_discard_cmd_control() limited to allocating and publishing
the command-control object, which recovery can use to queue discard
commands. Start the discard thread later in f2fs_fill_super(), after POR,
recovery, checkpoint option handling, and discard tuning have completed.
If starting the thread fails, unwind the shrinker and any GC thread that
may already have been started before continuing through the existing
mount-failure cleanup path.

Fixes: d6d2b491a82e1e411a6766fbfb87c697d8701554 ("f2fs: allow to change discard policy based on cached discard cmds")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/segment.c | 17 ++++-------------
 fs/f2fs/super.c   | 12 ++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8390994a8..deb98f564 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2302,12 +2302,10 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc;
-	int err = 0, i;
+	int i;
 
-	if (SM_I(sbi)->dcc_info) {
-		dcc = SM_I(sbi)->dcc_info;
-		goto init_thread;
-	}
+	if (SM_I(sbi)->dcc_info)
+		return 0;
 
 	dcc = f2fs_kzalloc(sbi, sizeof(struct discard_cmd_control), GFP_KERNEL);
 	if (!dcc)
@@ -2344,14 +2342,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
-init_thread:
-	err = f2fs_start_discard_thread(sbi);
-	if (err) {
-		kfree(dcc);
-		SM_I(sbi)->dcc_info = NULL;
-	}
-
-	return err;
+	return 0;
 }
 
 static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 40079fd78..8228be53d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -5340,6 +5340,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_tuning_parameters(sbi);
 
+	/*
+	 * After POR and mount-time recovery, we can run the discard thread. It
+	 * reads node-manager memory thresholds and the superblock read-only
+	 * state, so keep it out of the fill_super() initialization window.
+	 */
+	err = f2fs_start_discard_thread(sbi);
+	if (err)
+		goto leave_shrinker;
+
 	f2fs_notice(sbi, "Mounted with checkpoint version = %llx",
 		    cur_cp_version(F2FS_CKPT(sbi)));
 	f2fs_update_time(sbi, CP_TIME);
@@ -5349,6 +5358,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->umount_lock_holder = NULL;
 	return 0;
 
+leave_shrinker:
+	f2fs_leave_shrinker(sbi);
+	f2fs_stop_gc_thread(sbi);
 sync_free_meta:
 	/* safe to flush all the data */
 	sync_filesystem(sbi->sb);
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
