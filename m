Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458EBC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 May 2023 14:59:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pyw9G-00014j-UX;
	Tue, 16 May 2023 14:59:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pyw9F-00014d-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 May 2023 14:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pp1WTNN73VDTBOzVnsmUPI/cVr/EOVT11WTMQUoS7mg=; b=bJBoACoX6WuX5Pqq3FGct4tvFN
 9TccvwBOsoon7BOLrsHplBjo873tnp4Ru+vNNw4//wCLGtkIWrMhId8Zu6bL4Cr1lrEJXqKj4fOBH
 y98V7LBV8H4ktOAC6EATsgJmN2v9x1rbN7Duf0b+jihkEPEsHvRBfSb4/fjOlFgorNoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pp1WTNN73VDTBOzVnsmUPI/cVr/EOVT11WTMQUoS7mg=; b=k
 IhZIBV/uXpoosWUml24WZXMUVlu4ujxYtfqapbjtysLq8KxT6M7oiTyVltAmfpUbfImt/nvrA4S/5
 ygfXmId5rcEwC7zS1LZGD2e1hVm0DDhYGHfZflaMpTX5dFPH/hVTXkBPqOGq2DWMvPk9P5EgsfB+w
 9y009/IWEzvMyZ1A=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pyw9E-00066U-EZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 May 2023 14:59:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D6B3361358
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 May 2023 14:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D03BC433EF;
 Tue, 16 May 2023 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684249166;
 bh=xadHQ5u7AP9D9UBRP9O31hXT7Tag8SIcHKaMxYMy4Xk=;
 h=From:To:Cc:Subject:Date:From;
 b=bOxujnbeamDXadHr13bQuuEetQvfsT6WgR06G+1jk5OmFv+qvsAT4vOT80iyvBy1z
 LhIPpLsyi1qFH1j/MYBYGp0LDMiDlASqrFOF2Mx5nwmPZwM3ucxvGl31Nx5vVWbg72
 +HW0/3WGxeUvFPJDFUJfofBM00kiKqEEe3rHjuL8U097afwPuiyDuXMMfuidUKz3Yt
 1MK7vFZp+FLJxWH40T1QJzxb44khIB75dCXJA2A/DjEHWGwTb2WBoQSvyM9AznlJyf
 nt7kkZeRCOb/J1cAtJupupcMtX39o64ycpAlSdegvfm+TzcPfxz9szUfYqJoSHw1+5
 GrnEP091obxhg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 16 May 2023 22:59:11 +0800
Message-Id: <20230516145911.162431-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1pyw9E-00066U-EZ
Subject: [f2fs-dev] [PATCH v2] f2fs: flush error flags in workqueue
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

In IRQ context, it wakes up workqueue to record errors into on-disk
superblock fields rather than in-memory fields.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- make f2fs_record_errors() static.
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/super.c    | 26 +++++++++++++++++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 10b545a1088e..75d3d99fffcc 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -744,7 +744,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 
 		/* Avoid f2fs_commit_super in irq context */
 		if (!in_task)
-			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
+			f2fs_handle_error_async(sbi, ERROR_FAIL_DECOMPRESSION);
 		else
 			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
 		goto out_release;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0f05c1dd633f..99edc4981edf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3563,6 +3563,7 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 							bool irq_context);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
+void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 51812f459581..17082dc3c1a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3980,6 +3980,11 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 	f2fs_down_write(&sbi->sb_lock);
 
 	spin_lock_irqsave(&sbi->error_lock, flags);
+	if (sbi->error_dirty) {
+		memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
+							MAX_F2FS_ERRORS);
+		sbi->error_dirty = false;
+	}
 	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
 	spin_unlock_irqrestore(&sbi->error_lock, flags);
 
@@ -4019,12 +4024,10 @@ static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
 	return need_update;
 }
 
-void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
+static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 {
 	int err;
 
-	f2fs_save_errors(sbi, error);
-
 	f2fs_down_write(&sbi->sb_lock);
 
 	if (!f2fs_update_errors(sbi))
@@ -4038,6 +4041,23 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
 	f2fs_up_write(&sbi->sb_lock);
 }
 
+void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
+{
+	f2fs_save_errors(sbi, error);
+	f2fs_record_errors(sbi, error);
+}
+
+void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error)
+{
+	f2fs_save_errors(sbi, error);
+
+	if (!sbi->error_dirty)
+		return;
+	if (!test_bit(error, (unsigned long *)sbi->errors))
+		return;
+	schedule_work(&sbi->s_error_work);
+}
+
 static bool system_going_down(void)
 {
 	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
