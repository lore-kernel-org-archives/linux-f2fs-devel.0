Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA5CCA9ED1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BfMWS+2dmrDvE1hPs2MiZoD9n6I3taZuWB4u0u6Eu4w=; b=g/LD+kvtIgLwMH/rH+yyf8qOxn
	CmHfQiABLuHz/60GmPUpCyaeDlaux7A1mG+lRel2MLmCB7nbjVVcHh4Jcg7f73ldN9PBMGwrojBDW
	zWLKGLJasVPcGbnunPDfNrospYYaEDDF8RvIb7uOtsBoguEAB1E3KJ/O2SnJBe3gz7oY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG6Bi-0005MX-8U;
	Mon, 12 Oct 2026 02:54:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jnhuang95@gmail.com>) id 1xG6Bh-0005MR-Af
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 02:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u/DRWkttqQoIGBR0GONeTzB4dOwo8mbIklzruyiYFLo=; b=RJSk5Lks6BcxNQ6BAM/oPkRiCs
 XqfC5lj8Kve3oXAhsaxnfZdaLqGbB1WoqI+WFnCDsMG+wc5mytbf3lEd5laMvq1BXZaGtQ+L3Kl7W
 +jDlaKDuD/CsdwsAaC3mR8Xb57hVpmy5MvFtds/8V9MkrEl6GPdxHx/HBvX6ltgivQnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u/DRWkttqQoIGBR0GONeTzB4dOwo8mbIklzruyiYFLo=; b=Y
 KVcnMpFjtU0pscc3AW/qNkcdrFTRxr17o/Fa4wDdT9rIzWAoN7PVfcgNqO+OHKduYfKPofVS4S4s6
 tAdigjyf7rEmrNCH5YZzf4sOq3BRrZcZU/vATHvTmfD1/wbi6i3lBZCeOHo4mVVPQ26qCWeNTYSph
 U6UF98fqTwsuekSs=;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xG6Bh-0003YM-Jx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 02:54:53 +0000
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso7612015ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 19:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791773688; x=1792378488; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u/DRWkttqQoIGBR0GONeTzB4dOwo8mbIklzruyiYFLo=;
 b=l8bK5ox9Q23H04zhYKnXzb88fuLNbogMtKCJT+nCswu2sHidh3TJdame4P4NdvDe6U
 yCa9kIUahzMlcTLwAmI4o/ZHDUKaLCVDtA6ufNR6Bi1L8ADY49ehi8J7S3X86BcefcLV
 1vboI58JLdy9IBHfe3HGiuLy7xqeeOTC0ZxCW804b+Ae44fnX7OLHSTM0WcZD56mWH90
 e+mssTQu84Rh3YrM8eh1Z79rQYo6bIfpOJAEVv9vYD6BXt3tsYE8LYX3Q7156TSoCEHc
 pVlyZguVjXiH8YlK7qwN1oftGytoIqqDjzzTL60GC/dlnzVbhggNf87kOqJaDHvglh9a
 uvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791773688; x=1792378488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u/DRWkttqQoIGBR0GONeTzB4dOwo8mbIklzruyiYFLo=;
 b=kgXbptSE4e4Qyzk0Bshcq5CMwxFmkX/9XcajppWwrCK9ggWHfdgYe7rpIqRZQ72W47
 oaoXS6a6mvlzG1vBTH6t/Vz7zByfGxBNNd3MSUOv7n+F/1fjlrRiLhxz+Z1gejOKWiDA
 afL2d1sNonzG9n3/TyDzHrMvGh+TaE4/ohg6zAOlffnY96ehWvO/CY5ttUysYezRZ11S
 BZDvMd+SG9ZOM6M+6jR3lzRDDYumjnegzyvbOd+LT/ZQZCT/YAwN+KxmXt5WQlblLZIn
 OTnInSGMOAA9IqoKV1i+2hibMbjp/pA6MT9Ax4EwKSSS6Nkel+b8Rb/4OqAVWLoQ50Ov
 D8cw==
X-Gm-Message-State: AFq9FYLBzzs3TJkWhPCcq+xCNPFpL8+/e4yKIJQsaEx56qCfFhcAfF7O
 15gV6lrcXPDX52WJB0PneDCU/K/IslhuWpewxPjZJj3kxj2qQiTadHR+uHpaTJ93fEA=
X-Gm-Gg: AYBFou02jzOA2bnaqUgX/4qI8dPzP/dPG440mV8+4VlY6hjMaGncjOHWsPWlHDOZy3Q
 4RbnZZJ6yxXVpIo+SDrRQ6yQmaNf1BPSFCGPzd98W8bROw6cG2oymIq/x46Hphg1UTuiGnYQ4mh
 v6T54aQzEsx+jfCd+MmhxpqadLBxgqyjioNIuWUMzVEyap7x7kv6LpgT1NZSqI/Ovo8swJTWEBD
 bj0KnLrUjbYkjQlNv9GMMmX3vRG8UQ5m/an/qcXaN3QJS3jQbUTmKhyFaaQVZkMb4IJBy7DFQRn
 obsxN/PC9NCalPMILadtkxP8egPg+l4f97GrOTmiQwHpeQ8xApslyap9qMch+/6qHOa+nO9Kifs
 p+YEZ6DYCcHq1DjRAHb0YvBQIyuW33zE0mNqiXucMfst9XU7uTVxVF6ALT6QF/ntzn3S2J6xCT+
 GM956ZwTxLTb64xelMB8ekCjkRxVwD6vOr1QA3Y26qCiMSwDCsPw3EBMt/gZCrNTPRHLC8z+dz7
 hTc3yiPgXofF3vXHfXshQAEbhfZLw/Fnfpqug==
X-Received: by 2002:a17:903:2309:b0:2e3:1bb4:6121 with SMTP id
 d9443c01a7336-2e842ab7fa0mr64478485ad.49.1791773687789; 
 Sun, 11 Oct 2026 19:54:47 -0700 (PDT)
Received: from 4ce604c9y2.bytedance.net ([61.213.176.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e6b6sm36605375ad.20.2026.10.11.19.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 19:54:47 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, jaegeuk@kernel.org
Date: Mon, 12 Oct 2026 10:54:42 +0800
Message-ID: <20261012025442.770777-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xG6Bh-0003YM-Jx
Subject: [f2fs-dev] [PATCH v2] f2fs: quota: fix quota flush failure during
 filesystem freeze
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
Cc: Jianan Huang <jnhuang95@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Quota flush retries can be exhausted during filesystem freeze.

freeze_super() and the quota checkpoint may race as below.

freeze_super()                       f2fs_ckpt
- down_write(&sb->s_umount)
- sb->s_writers.frozen = SB_FREEZE_PAGEFAULT
- sync_filesystem()
 - f2fs_sync_fs()
  - f2fs_issue_checkpoint()
   - queue CP_SYNC -----------------> - block_operations()
                                      - down_read_trylock(s_umount)
                                        : fails; freeze holds write lock
                                      - quota flush retries exhausted
                                      - set CP_QUOTA_NEED_FSCK_FLAG

During the PAGEFAULT sync pass, freeze_super() holds s_umount for
write, but umount_lock_holder is not set until f2fs_freeze().  Thus
quota writeback tries to acquire s_umount again and can exhaust retries.

With checkpoint merge enabled, f2fs_issue_checkpoint() may dispatch
CP_SYNC to f2fs_ckpt. That thread also cannot acquire the freeze lock.

Record current as umount_lock_holder around the VFS PAGEFAULT sync so
checkpoint runs in the freeze caller and quota flush uses its existing
s_umount write lock.

Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
Changes since v1:
- Add a separate VFS sync_fs wrapper to avoid renaming f2fs_sync_fs().

 fs/f2fs/super.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 00da08504d55..fa105ca14653 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2146,6 +2146,25 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	return err;
 }
 
+static int f2fs_sync_fs_super(struct super_block *sb, int sync)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool freeze_sync = sync &&
+			sb->s_writers.frozen == SB_FREEZE_PAGEFAULT;
+	int err;
+
+	/* freeze_super() holds s_umount for write during this sync pass. */
+	if (freeze_sync)
+		sbi->umount_lock_holder = current;
+
+	err = f2fs_sync_fs(sb, sync);
+
+	if (freeze_sync)
+		sbi->umount_lock_holder = NULL;
+
+	return err;
+}
+
 static int f2fs_freeze(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -3757,7 +3776,7 @@ static const struct super_operations f2fs_sops = {
 #endif
 	.evict_inode	= f2fs_evict_inode,
 	.put_super	= f2fs_put_super,
-	.sync_fs	= f2fs_sync_fs,
+	.sync_fs	= f2fs_sync_fs_super,
 	.freeze_fs	= f2fs_freeze,
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
