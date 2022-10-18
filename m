Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C5C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Oct 2022 17:00:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okpxI-0007dJ-Nh;
	Tue, 18 Oct 2022 17:00:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1okpxH-0007dD-PF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Oct 2022 17:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JuyQVovxOb619q7qGfPmMX5V52ZmoS2AvZutN57Wq2w=; b=ghxAgCrtmbLllLxZhwW8zfwIi8
 2sY98DJ8f79iR5fI0oE4RzoLrMpeapUbWDtUOqulcaKEJvmNOVf/bsDDn239R61RpVanYlpGIjESg
 edt7IyxcYc22OOfoYrlsLZlr1DnglFTbnA4cS07TA4ezGiSB+STzfmyhanRlCy+dDvyI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JuyQVovxOb619q7qGfPmMX5V52ZmoS2AvZutN57Wq2w=; b=WP9XZDKR1cRm3Y0xYBbCJmLwSS
 hpyBs7LddVHI2Ov/X96kRj1zRZc0vdsZ4/tQBqIzAcxTQNBYWthsv5DXOjNqoMRs6WbtXrQVcTudu
 eSOA8gZqQOBwbsRV0NuGrELTPST0GRUsiZ6v+fsiBGU+VShGAvqjXFhNv6kiCiPdC2gA=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okpxC-0006Dq-CU for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Oct 2022 17:00:38 +0000
Received: by mail-pl1-f170.google.com with SMTP id o21so12007184ple.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Oct 2022 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JuyQVovxOb619q7qGfPmMX5V52ZmoS2AvZutN57Wq2w=;
 b=h9Jg6sHXmzo/0+H4voXj6NMHIbBfvljNGUC0QrDA4ggIO0u8rcsRJwDyEuJMVEnxR3
 zgj+qqYAzsrGoFX5I4+62hui7E7eTspVMC1uHT9mcig0D8Nx6SAXCYNKPcdFu5kSvvwv
 Tas0ivFCnc0pvMI9enMsGDOCC/yw1kZ+lXVzDeNsUHtXu0AaYVgK/Vl9GeTdbX2m7vaS
 B3rxjQwPd4d/rU0ZL4gqpEqh1rh/ZdOhT2w1LwO1DyKDzeJwzpdT5Y0X7Uiiv60+iH1N
 usI+/Sw1gx+DAY45tcqCfqJywlxLyXd8qWsWCD7SlYm4z7qokw3252rTluy4cuhtSStB
 LtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JuyQVovxOb619q7qGfPmMX5V52ZmoS2AvZutN57Wq2w=;
 b=e6e27LrahQo8f/QxqpFWWCX2JpsmMLsnSlW15p9EyWJECiwd3fmR/66SVPcebGKtZ4
 zEbAf5KAPXh/woXvLgMuldClHlf4zUWzP2ZcPzHt8acuWzUiPpeB5s3iicm39Ignvw8l
 WIuiG9SK+R6Uhz808zt33B11ZsXWdPbL4eEDgg0KDvci8oKejtt5W1ZwEz2ULaNdwrH2
 uGLOlSdNepC29VKDULcGibg8li8QJrY1VwJ3h7c/P0X9wpV0q1ntb7ugjhpidhq0eygl
 pE9cR/niViLqG0kyWpr/NrtSkoLGwdac5ltWG1yCtCD/lByKSugPlvrVTo006iXSMPEJ
 BjoA==
X-Gm-Message-State: ACrzQf2/sE3DYIPnpIO3AaTW4ZMLmD87L6EUkMXgT5Yww3O+xGLrbR3L
 wzkUQDqra8Jm5+ppw+Rw1v8=
X-Google-Smtp-Source: AMsMyM4rCJiPEtW2yCHkak9Y5mTHgyXBP1/ZHYmOluL/OWlZM+/05/spBFg04tsYk+6GOP0hK2O/PQ==
X-Received: by 2002:a17:90b:3ecd:b0:20d:9ddb:f287 with SMTP id
 rm13-20020a17090b3ecd00b0020d9ddbf287mr35760182pjb.167.1666112428718; 
 Tue, 18 Oct 2022 10:00:28 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:4968:cc70:9889:c198])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a170902d54a00b00172951ddb12sm8951375plf.42.2022.10.18.10.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 10:00:28 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 18 Oct 2022 10:00:17 -0700
Message-Id: <20221018170017.672824-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221018170017.672824-1-daeho43@gmail.com>
References: <20221018170017.672824-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okpxC-0006Dq-CU
Subject: [f2fs-dev] [PATCH v5 2/2] f2fs: introduce
 F2FS_IOC_START_ATOMIC_REPLACE
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

introduce a new ioctl to replace the whole content of a file atomically,
which means it induces truncate and content update at the same time.
We can start it with F2FS_IOC_START_ATOMIC_REPLACE and complete it with
F2FS_IOC_COMMIT_ATOMIC_WRITE. Or abort it with
F2FS_IOC_ABORT_ATOMIC_WRITE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: move i_size change after setting atomic write flag
v2: add undefined ioctl number reported by <lkp@intel.com>
---
 fs/f2fs/data.c            |  3 +++
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/file.c            | 20 ++++++++++++++------
 fs/f2fs/segment.c         | 14 +++++++++++++-
 include/uapi/linux/f2fs.h |  1 +
 5 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f895ddcd64a..bce4dcc3ad78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3457,6 +3457,9 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	else if (*blk_addr != NULL_ADDR)
 		return 0;
 
+	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
+		goto reserve_block;
+
 	/* Look for the block in the original inode */
 	err = __find_data_block(inode, index, &ori_blk_addr);
 	if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68d2a3383c38..5450174cde5f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -765,6 +765,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMIT,	/* indicate atomic commit completed except disk sync */
+	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_MAX,			/* max flag, never be used */
 };
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7ce629c95f4a..7b2d956bc52f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1984,7 +1984,7 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 	return put_user(inode->i_generation, (int __user *)arg);
 }
 
-static int f2fs_ioc_start_atomic_write(struct file *filp)
+static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 {
 	struct inode *inode = file_inode(filp);
 	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
@@ -2053,10 +2053,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	f2fs_write_inode(inode, NULL);
 
-	isize = i_size_read(inode);
-	fi->original_i_size = isize;
-	f2fs_i_size_write(fi->cow_inode, isize);
-
 	stat_inc_atomic_inode(inode);
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
@@ -2064,6 +2060,16 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
+	isize = i_size_read(inode);
+	fi->original_i_size = isize;
+	if (truncate) {
+		set_inode_flag(inode, FI_ATOMIC_REPLACE);
+		truncate_inode_pages_final(inode->i_mapping);
+		f2fs_i_size_write(inode, 0);
+		isize = 0;
+	}
+	f2fs_i_size_write(fi->cow_inode, isize);
+
 	f2fs_update_time(sbi, REQ_TIME);
 	fi->atomic_write_task = current;
 	stat_update_max_atomic_write(inode);
@@ -4089,7 +4095,9 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GETVERSION:
 		return f2fs_ioc_getversion(filp, arg);
 	case F2FS_IOC_START_ATOMIC_WRITE:
-		return f2fs_ioc_start_atomic_write(filp);
+		return f2fs_ioc_start_atomic_write(filp, false);
+	case F2FS_IOC_START_ATOMIC_REPLACE:
+		return f2fs_ioc_start_atomic_write(filp, true);
 	case F2FS_IOC_COMMIT_ATOMIC_WRITE:
 		return f2fs_ioc_commit_atomic_write(filp);
 	case F2FS_IOC_ABORT_ATOMIC_WRITE:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 264b4e352319..edf7d063e20a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -261,14 +261,26 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
 	struct revoke_entry *cur, *tmp;
+	pgoff_t start_index = 0;
+	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
 
 	list_for_each_entry_safe(cur, tmp, head, list) {
-		if (revoke)
+		if (revoke) {
 			__replace_atomic_write_block(inode, cur->index,
 						cur->old_addr, NULL, true);
+		} else if (truncate) {
+			f2fs_truncate_hole(inode, start_index, cur->index);
+			start_index = cur->index + 1;
+		}
+
 		list_del(&cur->list);
 		kmem_cache_free(revoke_entry_slab, cur);
 	}
+
+	if (!revoke && truncate) {
+		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		clear_inode_flag(inode, FI_ATOMIC_REPLACE);
+	}
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 3121d127d5aa..955d440be104 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -42,6 +42,7 @@
 						struct f2fs_comp_option)
 #define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
+#define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.38.0.413.g74048e4d9e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
