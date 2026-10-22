Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAE60A2606
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f8dZCPD6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L+5jgYoi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XC0fMIKW;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IBOUgA8P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I9ajzZRZsfsWif+C4imxa68wEpF2pzVnU/ALOais5JA=; b=f8dZCPD6NNkeyyfbDQUqajMTnu
	nW7VPer38mT1D1iLEjwu/tHohAx3h0RGFdZBRnVVXMutYdQKN+dCpTL57UYV+Kl2yHgPd6uqhKIyb
	r8yCg20o1qCgkxhWpJqMfSyQE5BGXUf6eNcF7ABhQlcB4iT4+PqK5eXKdgaTKtCaKMSY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsI7-000000005gE-2b2N;
	Thu, 22 Oct 2026 12:53:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsI5-000000005g7-43VX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rD/zYPBi22vsuAiR4tO4UQi89pBhgDe4H1fTUVyIAbI=; b=L+5jgYoiiZ5s5H9PmtstiZbBWh
 wc0kSSL/ErsFActrGpBWTTBzzM7wELZF3UzzZAus69a2siD8kRfRuYkiTjj7KAkaBK/20eD2PM7oA
 4jp5MYUeIdDobYCbJqYc29S1efJP6ZU9dxr7LJOXYzPDInITZyleNu0ZK2Jo3WPOTlU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rD/zYPBi22vsuAiR4tO4UQi89pBhgDe4H1fTUVyIAbI=; b=XC0fMIKWOh/ofMihEo/BWKXsi1
 xAVzjYsB4oCEVJtmUUHz93FVhLvZqYw3l8LE9UpxYxkLgyUbyxhj0JdL8caQwIoHwElYr5mz1skUL
 CPK4tuTCrjzQLimauAMK3B6DsINLfUyABawouz5rIZtqwm5WESyFtqhoXsLX9QhPq4tc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsI4-000000006rE-1Tiw
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0125543F13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EA51F000C3;
 Thu, 22 Oct 2026 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673578;
 bh=rD/zYPBi22vsuAiR4tO4UQi89pBhgDe4H1fTUVyIAbI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IBOUgA8Pb8Wqvp+WCfY5ecnoUrksSDJ/VCHXIWx/OlGyCNK04Rh9mZAkGOjHCAN12
 IWz9gGumN/zMrC+h31N0thY1PKy2dj1JHrk08uu8TMYDRMXVu65DbFw8XXbm2VX4nO
 EO0C2jdhaLP2jUc+3b8x03VPDlmNb1F4abT11AKd/biaNjTWkBVFdHi9ziiSx+kyHM
 1ULlrGkiWcq34WE+WWrk96r/8c+fcmoIL09BIqy23x5E+AyMOtlTObn7PWFqpaEGh4
 r5hLxC6jnJlVdHaWpVSqY/KbgUCnXvATnNxOCoW/Wf1DIu3xIsZFaT15SCUELaKVMC
 jcB8h0PAslBsg==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:39 +0000
Message-ID: <20261022125244.2205275-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsI4-000000006rE-1Tiw
Subject: [f2fs-dev] [PATCH 2/7] f2fs: fix to return -EIO from f2fs_sync_fs()
 if cp_error is set
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
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

Cc: stable@kernel.org
Fixes: 1f227a3e215d ("f2fs: stop all the operations by cp_error flag")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c  | 16 ++++++++++------
 fs/f2fs/super.c |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b077e4eb790d..27e295bdce1c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -417,6 +417,8 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
+		if (ret)
+			goto out;
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -2564,11 +2566,8 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret) {
-			if (ret == -EIO)
-				ret = 0;
+		if (ret)
 			goto out;
-		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
@@ -2584,8 +2583,6 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret == -EIO)
-			ret = 0;
 		goto out;
 	default:
 		ret = -EINVAL;
@@ -2613,6 +2610,13 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 
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
index 149ad6061097..ba2ec6123251 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2130,7 +2130,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
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
