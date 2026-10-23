Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C864C606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GUa7uY1C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JCD7iprU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iL8Xtwbk;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M+Ja90gp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=RHYkQduHu8/dI34p4GToF/9OuYZaJZzwbmyd+7J68jw=; b=GUa7uY1C9LkvA+xG2xIvWNZ/Q1
	5emB/hM6Sqdutg1pzosL0fVGd7iuNnkoS5XLQ5U8DO6NBq5cQ2YK9DmkfgVmm7fGtu7TEqFWE7+vI
	3i+ERU6QcfjewC80a9IGoNrvYzzLE+AaXrhI9786GxHf7iSVo82sqdVxRC4fVK2oIkWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xK54J-000000006T5-3blk;
	Fri, 23 Oct 2026 02:31:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xK54I-000000006Sy-304k
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 02:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ksAqQEt7wgRnrEwMkGEYt7VjPYd0SKMXbelAnKdTXYE=; b=JCD7iprUFengjBzz/uP8gzwPJi
 BAkosGl27Y18xln7tw8hn9cLGWiUSXtmk+O6C9LY7EhMPvhca5rGkXKu8Q3oFpdR5b9aT5pDCCi8t
 gpg4A69QhZY6JzHbql+BtRLF2Rrw8ai7n6B2uu2QYD3Hipc3wp4+7Nu/YZCcBujqxOJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ksAqQEt7wgRnrEwMkGEYt7VjPYd0SKMXbelAnKdTXYE=; b=iL8XtwbkV9SnVR8q8RuMT3uLMR
 aUnDjpwu0ui0bg9PpEAMwZggYBSqB4JvGjihLTv0DGvKSUwxveye55cqMznJqiBU5Rf5cA/pAgL+G
 FyTQbwGqaXT+75u5Kp7P2VWd5f4Wu0WecIGPiEgDc+XF88vV6XL4HG4ITpKS83IFXOjM=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xK54H-000000005y4-0fDM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 02:31:42 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8a05f2d5cd3so191007b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792722695; x=1793327495; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ksAqQEt7wgRnrEwMkGEYt7VjPYd0SKMXbelAnKdTXYE=;
 b=M+Ja90gpoxEXMQvRMhNfaxPTwDRWdL2SpXGT4tfT3rhutHMfkPC4wXu6CLTnvEhRKi
 zvPW6XsCW23xottt2wvTdbrxHPBMCQaUHmNcYyzDfpSCRofYyUrJpXS+SZFmI9lbfBg0
 9KhGTmHFnPROEug/7mfrBzhI59NIQj4vggCqmv81J2NnUJ5WjIRDAvDGRapBFniUWtQe
 SdiFrIgwmFpLcJ7rm4WVmRiHkR3o/1PPTrJrB3d6eZ7M0xXCvWAtuNk1I9zMYpAj+sLU
 oFUahjHTAnIu7oW/B6DpuaaU18pAoYCik+XsPzXjNWWdJZGb0+2SAiqSGm9NzPd5Wiv8
 O03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792722695; x=1793327495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ksAqQEt7wgRnrEwMkGEYt7VjPYd0SKMXbelAnKdTXYE=;
 b=RauWj5sZdz6ehS5g5w+4huOQov+/AuUU6uPlUANhHY30wTW4RgelrRkZwIlMLd/tf4
 okWHzFm/WFjxxaqyu2Q5UZ2FqEaCjwZApDOYG2P500TNe1gAUYHp3cFig5kIuZCgcKDX
 ua6PUN1kP4wGAFMD9Lt0gwWLitjffgsRmamzvmn7Zm2ufcDYW2ZzjlVQIO+vVX0MeD9L
 3nvZxQW6qWTYCGAT4iKpHvZYAvrK9/0yedzgP8aBqxGhb0HwfmJm3B6EHQcIaXmuLReM
 mSrEThCfshcHkPOaxv8YG0QLR2KT5wQTuWC/JVG1MH7bxUpAjjeBPN5T7NCJ3fr/+tWb
 uvdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6qwgVhtclIn9nOBd/rWWNwdYULyJWumSUFRgnkWEUre66tbThQkSzgU82sw8RJraoFC/oU7FpAPONsYOkTjM2@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIVqzyFGRo+6O5DDtYc4f9P5zr95K6gZsGJaYSlmZRPAspC23bI
 5JKWGc/YKPpuSgkzNDCMByTkqpVGnzJscyJPCuRpC34/qXPE2IhB9nem
X-Gm-Gg: AYBFou2l4vhi0WW8Ea7rx+AW9AP5NAO9mRxmpkUCbirbD8rMmanS6q2JkXSbS1Eqq/Y
 FWeMcnlvGnPuE5+ZB47CYlfF6wCEL7/OIeOym0XiManORTyf4R1gy/ax+TQcvF58GcZamlysDyh
 WnUcpFroBTs8lhzdUW6+jL4ZiYeETiRPkzwPRz+cZP6i7UfJT2V8XPbFDpli2zwa479Or/YK/Zz
 RkdrEzyAfHfaOh6bVyyy1jXwRP6vXK5AbHnJo19zARdCREgbG/gk+uCSq3L/HJm1M5hrwIO97xv
 mX5P5XaV6kKjTcjyuD7INoFxuOZ2tH9PVvtjLFqgKRqoTmY5Oz3x+LPxBrHxT+1DZfXDMBqqg2U
 adOcOjkyKuDxrpNk9fM4uou3/jMR0Rwu41ltj9usp3jfuiahs/brUcmJ9qpAaDsc5Z+JNmIkGaR
 w+Oc+HXpQyOe7T/Y+hHsoGb26u96z1rkzxLcbO+1HBMoiTAslfIrxnaqhGzGTfrkcVsj3WJz83l
 Snp0dhmLfEqy8MfvGTVxyiQegdV248SfA3BTkcYVInTK6RyT89JOZJ3bF/eD+01/MPsf4AbfYi0
 7kQDPWPL/5q4oVV5jL8YdzqLEJAfgDLdIa6ll8XwxYW2Wx8AFqYcSK2a/UtOU0MpOZtXP60I6g=
 =
X-Received: by 2002:a05:6a20:a10b:b0:3e0:e400:3fd with SMTP id
 adf61e73a8af0-3e37665ccbamr644534637.43.1792722695158; 
 Thu, 22 Oct 2026 19:31:35 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c90f9397sm193403b3a.42.2026.10.22.19.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:31:33 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 23 Oct 2026 02:31:18 +0000
Message-ID: <20261023023118.3460118-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xK54H-000000005y4-0fDM
Subject: [f2fs-dev] [PATCH] f2fs: flush devices when a sync checkpoint is
 skipped
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

When fsync needs a checkpoint, f2fs_do_sync_file() writes and waits for
the file data and then relies on the checkpoint to flush the device
write caches. syncfs works the same way through f2fs_sync_fs(). But
f2fs_write_checkpoint() skips a CP_SYNC or CP_FASTBOOT checkpoint
without any flush when SBI_IS_DIRTY is clear.

That can happen even though the data was just written. A checkpoint
does not wait for F2FS_WB_DATA writes, so another checkpoint can commit
the new block addresses of the file while its data writes are still in
flight, flush the devices before they complete, and clear SBI_IS_DIRTY.
The checkpoint requested by fsync is then skipped, and fsync returns
while the data may still be in a volatile write cache. After a power
cut, the file points to blocks that were never persisted.

Flush the write caches of all devices when a sync checkpoint is skipped.

This was found by generic/455 with compression enabled for all files,
where every fsync goes through a checkpoint. On a 4KB page kernel, 3 of
100 runs lost fsynced blocks without this patch and none of 100 runs did
with it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c | 18 ++++++++++++++----
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/segment.c    | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1ed38c668fc..158d97fc349 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1973,10 +1973,20 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	stat_cp_time(cpc, CP_TIME_LOCK);
 
-	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
-		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
-		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
-		goto out;
+	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY)) {
+		if (cpc->reason & (CP_FASTBOOT | CP_SYNC)) {
+			/*
+			 * The data that fsync or syncfs waited for may have
+			 * completed after the last checkpoint flushed the
+			 * devices, and that checkpoint may already point to
+			 * it, so flush the devices.
+			 */
+			err = f2fs_flush_all_devices(sbi);
+			goto out;
+		}
+		if ((cpc->reason & CP_DISCARD) && !sbi->discard_blks)
+			goto out;
+	}
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
 		goto out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1f9bd8e3b52..a4a38818988 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4265,6 +4265,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg);
 int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
+int f2fs_flush_all_devices(struct f2fs_sb_info *sbi);
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
 						unsigned int len);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 06fb92fc847..5b015cf9071 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -822,6 +822,23 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
+/*
+ * Flush the write caches of all devices, regardless of which ones received
+ * writes since the last checkpoint.
+ */
+int f2fs_flush_all_devices(struct f2fs_sb_info *sbi)
+{
+	int ret, i;
+
+	if (test_opt(sbi, NOBARRIER))
+		return 0;
+
+	ret = __submit_flush_wait(sbi, sbi->sb->s_bdev);
+	for (i = 1; !ret && i < sbi->s_ndevs; i++)
+		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
+	return ret;
+}
+
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
-- 
2.56.0.218.g1ec904b173-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
