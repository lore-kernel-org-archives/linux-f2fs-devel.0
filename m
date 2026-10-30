Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB25D606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l8uRh5FN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Va44KFQ+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eFLZsYFT;
	dkim=neutral header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=IHQ9iYHd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=nrDHMRCI/bcp5AyVuN8trI10og5qJIoGTpIoIduIrio=; b=l8uRh5FNF3g4b7fFwseb2QweZs
	1uEN0Wvt14OVaYstlTJ0gwZGpHRoibGrFR8RbjEZEdQg6aBI7GvXupgyTecGPoxTlRSj77Hh03x2s
	tQU+Id+thhXUv1/HbgUO02I/0PJlxHuNBoNLHaif6SwH10tjRR534IjrmAmmjR3OKnOU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMj7X-0000000040b-2Uge;
	Fri, 30 Oct 2026 09:41:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hengyul@cs.unc.edu>) id 1xMj7W-000000003zv-0NMN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 09:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=; b=Va44KFQ+nh6OLPiwA64XjgJ74W
 HZnzwe0kXsgTxZ4IrMOeoHFxEoRYUYC89usQTg/0/vhd4b0hYLdBj4DKM6vRtSv1XE1OU5jkBN41q
 323GXlzSxQdGBbj8OCRaZoRCa9HJ7o19lkuiRhiQpoGiOJ8rIQ3SbtNaCdNtT5vUwWtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=; b=eFLZsYFTXLfJp7m5cxb1/N53Ce
 3WCpNMufSyNXazjp/M/wu1SYA2SPeb3rNaiB0JQTEApW7+W8lSp5ZJpU4RDwiswdwOzdwTGgt/pDA
 kLaw2Y67B8bfr02yVQR9unedy7oV0Sh478B0zOKbziLj1yBSje2UMLi5itgk3ik5pSlw=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMj7V-000000000Hh-0jpJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 09:41:58 +0000
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-ccce6d9abfeso337218a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1793353311; x=1793958111; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=;
 b=IHQ9iYHd2iAx9mXbtpAiyDHyRiQPO/rKZfM5kE4wa3lF4e2MXWqq3cW8Wmj2J5wPWp
 IZcsXcTEiMI03MYRTuyZcXInPdXPaxvNVTPqTUtFJlx+Hg2CHStozzmQ34C1OrMgG7sg
 FJCUxPeGdlE2jPG7EfOF4jF/LgYgrOknOIU2qOtv2dJxNb1pzMy6BFa3V9/CaR7VZL+1
 Djsi1hEi6dxfPQ73nilxsfcfJFaIATmLQSvsStXrGVHhoRpB7wDO9i55nUnkzEvCPpdJ
 J8LRQmqdhaqQ5eDYIaOP3sfv8UoNhTazNUtpajxS2MxbGC25+mW0q+trbfYUMKxaqm2f
 eDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793353311; x=1793958111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0Pwj0msTdPhzaKN21Jqub3HQ2ivQUi/T4qOGcLK2DU=;
 b=hYSDjEfc1my4UzrFckgCcPOUNIHIUa66op+83Wu9uTJQUDuCN+Z1wQfMhuNZwrf82c
 JKySc8QE+kJdnJ6gsdviff0JomSrPmXxm5bdUnvDROCx+qH69DrmWMMjnxZzXr0QEsnq
 Ewy5d9a0cDmpHG2aLDW+mHdNQO6H0FOFL5tAzIYUUgFn6XnLJYVRxEKgxWNoQDmCDoWt
 arn9I536Qapjfl5itHIzuilDoFMdyMtHHQg4/hH+J/BxLfLDgxArNLWZo5XNZTU4gb07
 W3WgS/IlTPwqY471xEhGW232XpZIMeCFNPE3FBN/gzXRF+iReq3k4b5Xwq7GXJGVOLX4
 0rzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiBsiV+07LX0OT801IXp8evxL23GVF8hywj+SchVArQSg8sslNKB0yiV0uizVxa0HOIxYIwfS6Ejx0XoQdmazv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLrXfJXaEWk09f75hfteZgVuIb4zTwFu9qfjBTjPOjX5sGYxLA1
 ba3I/xUvPffZ8dmRpOrCmiQT3iePrl9ZSMinKV2C3mHbg1Lpgx53f56sirQN37V0XBxeSJnt34P
 gOZ+TNA==
X-Gm-Gg: AYBFou1m7VLvceeCNcdwejdVKGbtVfk+KRQKhLF3A2uv54tXaNxD+GuIEol19E1ot3P
 kQ4vvTuhmPruBFiMarFVjvEswUv2FHvseBJaKA6bPuNP+/4vRJHtBEZkgM1PeECR2C81eMbmdme
 Devz5OrCpGUT80ictw6G6jRZ2ET0wrhKRZRbzWTLlLWJ14c6jpQPOKmL1hxs8dx2tvaePYL0dfQ
 NRoMU2FJ4I2m+TK5hCi9Dvxa41AA9JMjYDEPVWv8z+eeVrj5gIsOxBVBMmNNhhDakYkOuz0m8Jd
 S7AWYFwzqSkTqYEEOL/Ywsg8rN8uoupcjTsC7ENAcJ9mFwuTOd3st9x4Kb3OqLc1qpCKTgdiloM
 FNKCVNgI9jpn7P23Rk2Uj7/Tbk8a1poHtGAjw7MmaX/C0023A0BwzrQ4qn+WmAW+QWbAXfq5Gpk
 vL1ZCx/Vq7rFVq43ghTRmu/IcZmOTNVffK6TKXf5k5DFL7xACDWTymgZiBNwtzNHBKQix7HMAsf
 o5xtIBufcYHcqX2r7KwYONS3PGxmN32P15JNPJ663wKfT+svgB1VZSsDncXKW9UfGBl6HBS2UcO
 Zvybkble3/TNbau0/kYcGCfOkPkuizsJbsYLyjQyinNsuj44sMKSyQ==
X-Received: by 2002:ad4:5cab:0:b0:919:5a24:d77c with SMTP id
 6a1803df08f44-91ca4b2a557mr24211986d6.31.1793351733042; 
 Fri, 30 Oct 2026 02:15:33 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f4767asm10428406d6.21.2026.10.30.02.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 02:15:30 -0700 (PDT)
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 30 Oct 2026 05:15:24 -0400
Message-ID: <20261030091524.292463-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMj7V-000000000Hh-0jpJ
Subject: [f2fs-dev] [PATCH] f2fs: don't fail namespace operations on dirsync
 checkpoint errors
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Hengyu Liang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit dafb84f092a6 ("f2fs: fix to propagate error from f2fs_sync_fs()")
made create, link, unlink, symlink, mkdir, mknod and rename return the
result of the checkpoint for a dirsync directory. That checkpoint runs
after the directory has changed, but the VFS takes an error to mean that
nothing happened and skips d_move(), d_delete() and S_DEAD. The dcache no
longer matches the directory.

For example, on a filesystem mounted with -o dirsync whose device was then
set read-only with BLKROSET, rename() fails with EROFS while readdir lists
only the new name and stat() only finds the old one. After a failed
rmdir(), stat() still finds the directory with no links, and a create
inside it fails with EROFS but leaves the file there. Once the device is
writable again, these "failed" changes reach the disk. A write error during
the checkpoint causes the same mismatch with EIO.

As commit 24c1a47f1ed2 ("f2fs: don't leave the hashed inode while it's
unlinked") notes for symlink, the final flush or checkpoint is not a reason
to roll back the operation. Ignore its result again in these paths. Errors
from before the directory changes are still returned, syncfs() still
reports the checkpoint failure, and the remount change from the same commit
is kept.

Fixes: dafb84f092a6 ("f2fs: fix to propagate error from f2fs_sync_fs()")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
With this patch a dirsync operation can return 0 although its checkpoint
failed, as before v7.3. In the write error test below the change is not on
disk after a remount, so the EIO was accurate about durability, but the VFS
cannot represent "changed but not durable". The filesystem has stopped by
then: later creates get EIO and syncfs() reports it.

Tested on x86-64 KVM with KASAN, f2fs dev 83f32c773255 with and without
this patch:
- 14 namespace operations (all eight callbacks plus rmdir, overwrite,
  cross-directory rename and whiteout) with -o sync, -o dirsync and
  FS_DIRSYNC_FL on a read-only device: EROFS and stat/readdir disagree
  before, success and they agree after. Remounted contents match on both.
  No change without dirsync or on a writable device.
- dm error target under -o sync, nine operations: EIO and the same mismatch
  before, 0 and no mismatch after.
- ENOTEMPTY, EEXIST, ENOENT and injected ENOSPC are still returned, with
  the namespace intact.
- fsck.f2fs --dry-run exits 0 on all images.

xfstests were not run; without a failing checkpoint the only difference is
ignoring a zero return.

 fs/f2fs/namei.c | 46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ce5d536d892b..9b127b38b6c6 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -402,11 +402,8 @@ static int f2fs_create(const struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -458,11 +455,8 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 	return 0;
 out:
 	clear_inode_flag(inode, FI_INC_LINK);
@@ -642,7 +636,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		d_invalidate(dentry);
 
 	if (IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
+		f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 out:
 	trace_f2fs_unlink_exit(d_inode(dentry), err);
 	return err;
@@ -730,7 +724,7 @@ static int f2fs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
 					   disk_link.len - 1);
 	if (!ret && IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(sbi->sb, 1);
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 out:
@@ -787,11 +781,8 @@ static struct dentry *f2fs_mkdir(const struct mnt_idmap *idmap, struct inode *di
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return ERR_PTR(err);
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return NULL;
@@ -845,11 +836,8 @@ static int f2fs_mknod(const struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -1149,11 +1137,8 @@ static int f2fs_rename(const struct mnt_idmap *idmap, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
@@ -1321,11 +1306,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			return err;
-	}
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;

base-commit: 83f32c773255720a661aa45d83e36278135f23f5
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
