Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB5CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TE9Vau6OAAFkg84nz4gs/CnJFiY9Grd3DaaFDrsQbKY=; b=B/W+CyTqpUrHSjCUlQw0g0TZAb
	CsI6m1ucDJnZaBQT1nCKoRw3k5Cjus/p65sO9nft4zRUQwfXW9q1b1SMZzjsPBBDMAQLd/Nng1p/p
	PZ5Oe3QH87SQcfKOvqcZpM/OPLDn5KdQ14xcDgT5Yme/zvCJi9TUabG54KvYS0aGMapE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDPeE-00034R-5Q;
	Sun, 04 Oct 2026 17:05:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xDPeD-00034L-3K
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 17:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VQ6hfrRhV924+ySu7XC403bWMbHO9La3En6qCzc3AsI=; b=WiBNzGvEQaeKJcHEopr509m7II
 f8NqKtt4VNPuI7tmNtkfnjI1ATfm57/L2j0o6EXUhNf6h8BFmygROcP7Wz40y/6fW2zI/h2dBsOyy
 zbBQQU3DwoOOn/W0HcAznTFghhmOkc79aHKWw7BgtvdrTAzfZ1gbmh4FVm/bz5x0mFr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VQ6hfrRhV924+ySu7XC403bWMbHO9La3En6qCzc3AsI=; b=h
 RbSpm4gS27NMvzs9yBq+sDT/bF2mL7Pw/dc9Bnyb4I94ztsgGBMs0ny8HVl3bfhB0C9vhc5y37qR9
 hMYKbBMGgit5JdMWZ/BcoOZrwVcGKzJ9m8rFVcr+a3LlQAjrfhClGgXjWiZkNTPkG9WGvKy4cABhy
 IqzQ2YiTBtGyVnJg=;
Received: from mail-pj2-f12.google.com ([74.125.227.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDPeC-0002Di-DZ for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 17:05:13 +0000
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso291248a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791133507; x=1791738307; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VQ6hfrRhV924+ySu7XC403bWMbHO9La3En6qCzc3AsI=;
 b=dZWZMJNA3KQ3vg0WwkebwzSwFt8UUxbLUlkNvv3YfySXKXw3cIsrpqN113yXjkOlis
 KxNVVR+7b9rBfki2iOg3QWoOPhZtVB7f39KCs5KYi1yGkZIByOZU13VOaxT7xF7vcHui
 UnAAyQwSDIKkRB78TIsUEBm6vfBgt9wtNfWFz8HDsUAAt653u/7ksDNPpQMneFBSWME7
 TEAI/pQ+OxJ8BD4PhFeH49CdWKFWj/DIcF6p08WE/z9xZx9XGVyV1uWzu3C0qnfG9VeW
 yclzuxWYAyNqpbcr493nw5JvJQm6hkc1aTV/8Xq/PJnKDsel9mEgNA+oHfdByhAvfl5N
 KJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791133507; x=1791738307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VQ6hfrRhV924+ySu7XC403bWMbHO9La3En6qCzc3AsI=;
 b=CeZqwZlTkBp0p1g09DOpeoEXx0BE6veiglAp1QUg0D5P40AauXIjO6voKg85ydNXHC
 NgvGUpgiKrOKa9KbaXrtvlQ/f62k8lG/1b9kfIpdDc5nO7k6jTs3Enu+F1X+ndaQ6has
 DFF+NaVxu1WRhb/0HXtXtew3cGO4tsaLXfAY8TGS48IoJZi2ZLqGRjPA7UBANbVLbZbz
 L1KmbQN7GvJCM8ZGxMqgz6Rc/YkaILK48rQwfVitDve0GwH0+Lb3lJluqedf5VbhSS+o
 ovx9n0EM0a3MparstDDVjAvcTQyd4Jwc8tFFMMklbycLooa0jwWNdOgzepcid2IAXIBV
 6zvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9tyKKAcetDZExn18FPB42OHimh9YH7DbZdYDmOgm4UrfH+kXN0ptXsz9icH+4GL5GDyjJx8IAMmccWh+lF2Dl@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJv5wX8VuonaiKtlmHbTcdPP2ojTiNAIELl4OS35gpFSQ+2g4I1
 1Mv0UPP/hoPwGxyiyQU+GDPGsHiZcEUxAYUer056iyV3e0uWHRf5QFeR
X-Gm-Gg: AYBFou07ABEyGaOPWcFZQZDb54Hy2e3Rueh43etIF5UZE8Nds/gcFxzheNj6ok8MCLZ
 SIqFA9bb4CoHRkk8cu4iuxKmpITi60dU5TSLeTmFnXKtpGP4oxEgRA7IQDluPqp7rOWX9PEC09+
 sUI1yTKenT7oy0CxSYQOTHdSnYARcWWxaSY8VXwao3DC8uJDCwmHVzs4+SEHW9FnfaPYRi2801v
 eKAgmJLW2rqiU29qyK8zFVRwE18QUL5naWkWPutItljuLl+iOnV3z+KxxfNo5WLFVLjojut1C72
 bWz8PhCB/sOZVFV9f1lhcbofViI+sRE8BTUpXm+8aHN0q31a71i0uszR367nuK1iHqWV25Jr5XY
 kYN/4TVoRb1mknqUkeqzjehz9sExkxi36Bmgv1DhLFZvq8k0wHZUWUF0/TfBATAc4qg66nQ51YV
 PxrJaOgO5YSfDp8QpUhtRXYGqjSb/p083rwTkzz59IjrLrojkFf+b51qNM1h1CfzGDqxxAQczAQ
 gZvsHC3IK1k5HVjCOcoo3h6VckDTVEP/8BhIGBPPFeyXwmpYD9IscS2FreW5oQPko7Di01KXZAk
 VkUJr41UzhlFl2U=
X-Received: by 2002:a17:90b:4f84:b0:3a7:ee74:e8d2 with SMTP id
 98e67ed59e1d1-3a7ee74eac6mr562437a91.25.1791133506575; 
 Sun, 04 Oct 2026 10:05:06 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e48dbc2sm7250750a91.10.2026.10.04.10.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 10:05:03 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun,  4 Oct 2026 17:04:56 +0000
Message-ID: <20261004170456.4104287-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xDPeC-0002Di-DZ
Subject: [f2fs-dev] [PATCH] f2fs: convert inline quota files when turning
 quota on
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

With a block size larger than 4KB, the inline data area is large enough
to hold a freshly created quota file (quotacheck writes 6KB), so
aquota.user/aquota.group stay inline after quotaon. f2fs does not
expect quota files to be inline, and this causes two problems:

1. Quota file corruption. f2fs_write_single_data_page() sends quota
   inodes straight to f2fs_do_write_data_page(), which sees NULL_ADDR
   for index 0, treats the folio as truncated and drops it. Updates to
   the quota file are lost once the folio is reclaimed, so the quota
   tree reads stale data: chown/chgrp fail with EIO and quota entries
   of users disappear. For example, the kernel log shows:

     find_free_dqentry: Data block full but it shouldn't
     qtree_write_dquot: Error -5 occurred while creating quota

2. Deadlock. Writing a quota file past MAX_INLINE_DATA converts it from
   f2fs_write_begin() under f2fs_lock_op(). dquot_transfer() is called
   from f2fs_setattr() with f2fs_lock_op() already held, so chown/chgrp
   take cp_rwsem for read twice and hang, together with the checkpoint
   and every other writer, once a checkpoint waits for cp_rwsem in
   between (seen with generic/232).

Quota files only grow and there are at most MAXQUOTAS of them, so there
is no point in keeping them inline. Convert them in f2fs_quota_on() and
after dquot_quota_on_mount(), which keeps every block size on the same
path as 4KB blocks, where quota files never fit inline. Quota sysfiles
are created by mkfs with real blocks and are not affected.

Fixes: d7e9a9037de2 ("f2fs: Support Block Size == Page Size")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/super.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d683240040f..bb4d22694b8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3321,15 +3321,42 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
 	return &F2FS_I(inode)->i_reserved_quota;
 }
 
+/*
+ * Quota files only grow and there are at most MAXQUOTAS of them, so there is
+ * no point in keeping them inline. Writeback of quota files does not handle
+ * inline data and would drop what was written to them.
+ */
+static int f2fs_quota_convert_inline(struct inode *inode)
+{
+	int err;
+
+	if (!f2fs_has_inline_data(inode))
+		return 0;
+
+	inode_lock(inode);
+	err = f2fs_convert_inline_inode(inode);
+	inode_unlock(inode);
+	return err;
+}
+
 static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
 {
+	int err;
+
 	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
 		f2fs_err(sbi, "quota sysfile may be corrupted, skip loading it");
 		return 0;
 	}
 
-	return dquot_quota_on_mount(sbi->sb, F2FS_OPTION(sbi).s_qf_names[type],
+	err = dquot_quota_on_mount(sbi->sb, F2FS_OPTION(sbi).s_qf_names[type],
 					F2FS_OPTION(sbi).s_jquota_fmt, type);
+	if (err)
+		return err;
+
+	err = f2fs_quota_convert_inline(sb_dqopt(sbi->sb)->files[type]);
+	if (err)
+		dquot_quota_off(sbi->sb, type);
+	return err;
 }
 
 int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
@@ -3534,6 +3561,10 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 
 	inode = d_inode(path->dentry);
 
+	err = f2fs_quota_convert_inline(inode);
+	if (err)
+		goto out;
+
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err)
 		goto out;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
