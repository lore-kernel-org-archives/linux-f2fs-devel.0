Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05071606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CukYGx4F;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GEMyt8DI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Rb0C4xVL;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6Wa8Ysr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zyTlFUsrsArL2e6iY0zA7seRSt4Mw49zMnr2ABTWkoE=; b=CukYGx4F3Ett6LetLTa/WWa+ng
	tlJDZOLAG8H50/fIb4ERA6N8RlmRRCrdoQNwirADGJO1hvx0wts9d/a7iFWApDnS1+EjXrYYbFgLb
	PRkGhacVQR56rQ5GUQIFveHc5LqwEOeGi8o4oBgMOQsMLi1z3q/z7kIiXcw00pGvXMKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtcy-000000002oh-37sY;
	Fri, 27 Nov 2026 10:56:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtcw-000000002ob-3k1N
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcIDSrMX4GfRswyhZ8Mr5fmEaIdp0nKGVydna+0B8qU=; b=GEMyt8DIe+3uRfztcdaHsXVtbT
 bH/YkJaz2U4FE14/a4dGcM4auRKXg+7t9qG4vXGnDMPP/G3qBiQYO5LpDA6DeGXR9KwBa86NlBY/q
 +1njjISyWRyxduY1q9NWgVNnT3gSh7k4MuKWeFkdHU9pwX9w6ASATKLjdSX5EQusO0y4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcIDSrMX4GfRswyhZ8Mr5fmEaIdp0nKGVydna+0B8qU=; b=Rb0C4xVLI8D6K97Ck3KYHmir91
 YkFGCXAGQgkjvFVSRjSborC/2zGPs1w1bK0tQxMkOaoYIjTMAIKSQrXdQeyHZH6KBrnQtPC9bd4An
 hdGcU9HPZqJE/lSdNg3qHFOV3GizGp/4tIHEySPbz16+IysMo3/T4cWX9p6Xk+vQLOK4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtcs-000000006A9-2TfN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E65696240F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64DC1F0089B;
 Fri, 27 Nov 2026 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776976;
 bh=PcIDSrMX4GfRswyhZ8Mr5fmEaIdp0nKGVydna+0B8qU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i6Wa8YsrXOYlquO8VqjYTWal3vnNjX8cX+bD198l0isO1KAAP5XYTKyKsLYPA/Sqs
 ZEPkm9FoI1xUv40386Dg9hcjD+tADctA6ZbBDDm6Og2QH21VFoiBCPJ21AcNg5MxXK
 7MSzBMtPK1ypOQdbQtvI31PnKnza3cyY6sz973Ujr/cJ3EQHLb4U2vweT7hQVe8SXp
 GTMtaRWcF7EaAYYmw0ZD9a6Xds7ztu4gK8NYn8uIvQFR/4Sr0XhByEtVcjMI/UpBqz
 OfIJaRU4h1FD1o5YpDUsT4EItzMJoyO7FrjFNSA6pQk2zA3ph6rBsynkCv5hnwbH4i
 FEFdTCNc8lzXw==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:09 +0000
Message-ID: <20261127105608.537148-9-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWtcs-000000006A9-2TfN
Subject: [f2fs-dev] [PATCH v2 2/7] f2fs: fix to return -EIO from
 f2fs_sync_fs() if cp_error is set
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

f2fs_sync_fs() returns 0 w/o doing checkpoint once cp_error is set, so
its callers can not tell whether checkpoint was done or not.

For a file which needs a checkpoint to persist its fsynced data, e.g. a
compressed file (CP_COMPRESSED), f2fs_do_sync_file() calls
f2fs_sync_fs(). So if shutdown (e.g. F2FS_GOING_DOWN_NOSYNC) races w/
fsync, after f2fs_sync_file() passed its cp_error check, fsync() returns
0 while neither checkpoint nor fsync node blocks were written: after
recovery, the fsynced data of the compressed file is rolled back to an
old version or lost.

In addition, syncfs(2) and F2FS_IOC_WRITE_CHECKPOINT report false
success on a stopped filesystem as well, whereas other filesystems
return -EIO from ->sync_fs after shutdown.

Note that f2fs_write_checkpoint() already returns -EIO if cp_error is
set, so callers of f2fs_sync_fs() have to handle -EIO anyway.

So let's return -EIO from f2fs_sync_fs() if cp_error is set, and in
f2fs_do_sync_file(), bail out w/o clearing FI_APPEND_WRITE and
FI_UPDATE_WRITE if f2fs_sync_fs() fails, as the non-checkpoint path
already does after f2fs_fsync_node_caches().

For shutdown, F2FS_GOING_DOWN_METASYNC and F2FS_GOING_DOWN_NEED_FSCK
have already converted -EIO from f2fs_sync_fs() to 0, however,
F2FS_GOING_DOWN_FULLSYNC fails w/ -EIO once cp_error is set, e.g. when
the filesystem is shutdown again, because:

- f2fs_do_shutdown
 - bdev_freeze
  - fs_bdev_freeze
   - freeze_super
    - sync_filesystem
     - f2fs_sync_fs_super
      - f2fs_sync_fs
      : return -EIO due to cp_error
    - f2fs_freeze
    : return -EIO due to cp_error as well

whereas other filesystems return 0 in this case. So let's do the
conversion for all shutdown modes at the end of f2fs_do_shutdown(), and
only if cp_error is set, so that the error is still returned to the
caller if the filesystem was not stopped, e.g. bdev_freeze() fails due
to other reasons.

Cc: stable@vger.kernel.org
Fixes: 1f227a3e215d ("f2fs: stop all the operations by cp_error flag")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- f2fs_do_shutdown(): if filesystem has stopped already, i.e.
  bdev_freeze() of F2FS_GOING_DOWN_FULLSYNC or f2fs_sync_fs() of
  F2FS_GOING_DOWN_METASYNC fails w/ -EIO and cp_error is set, still call
  f2fs_stop_checkpoint() and do the rest of shutdown, i.e. stop gc and
  discard threads and drop discard commands, rather than jumping to out.
- rebase to the latest dev-test branch.

 fs/f2fs/file.c  | 25 +++++++++++++++++--------
 fs/f2fs/super.c |  2 +-
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3caa6ceea554..f1fc0177df1a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -468,6 +468,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
+		if (ret)
+			goto out;
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -2764,19 +2766,21 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	switch (flag) {
 	case F2FS_GOING_DOWN_FULLSYNC:
 		ret = bdev_freeze(sb->s_bdev);
-		if (ret)
-			goto out;
+		if (ret) {
+			if (ret != -EIO || !f2fs_cp_error(sbi))
+				goto out;
+			/* fs has stopped already, shutdown it anyway */
+			f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
+			break;
+		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		bdev_thaw(sb->s_bdev);
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret) {
-			if (ret == -EIO)
-				ret = 0;
+		if (ret && (ret != -EIO || !f2fs_cp_error(sbi)))
 			goto out;
-		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
@@ -2792,8 +2796,6 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret == -EIO)
-			ret = 0;
 		goto out;
 	default:
 		ret = -EINVAL;
@@ -2821,6 +2823,13 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 
 	f2fs_update_time(sbi, REQ_TIME);
 out:
+	/*
+	 * If filesystem has already stopped, e.g. it was shutdown before,
+	 * bdev_freeze() or f2fs_sync_fs() will fail w/ -EIO, let's return
+	 * 0 for such case, as other filesystems did.
+	 */
+	if (ret == -EIO && f2fs_cp_error(sbi))
+		ret = 0;
 
 	trace_f2fs_shutdown(sbi, flag, ret);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b73fc6e75c7a..43ef7a4ac219 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2138,7 +2138,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	int err = 0;
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		return 0;
+		return -EIO;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
