Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55046606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TAfuqmI9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dzhkEoOY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W4qvTJoz;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Prdad+ff
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=jLHqMPHqM00Biplx1GcEQxsw3EWV9OCqmND+W+b3oK0=; b=TAfuqmI9q0m4gX/fhzwJdW4T/w
	10jHiZYKGjcIZRtvuO/FruMLBPpxhiFE+Ox2ZM9Oe52rzhQ34N8qsfeSQIWJ22y1kbN3OYfaCo5Bj
	VsldZxeE0YRxg0LVkf4Q1AfN70OJWN5Rn3J5Cbm8spR6PH/J3akNuLjmDQj/mw370xfk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTPyY-000000002xy-3Z8A;
	Tue, 17 Nov 2026 20:40:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xTPyY-000000002xo-0ETw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 20:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kq3gYAeKi+2MlDRtqxzklMdRJ3gSx3YIPGqwyIvmiBI=; b=dzhkEoOY6OijWZ6/CQjZao9nKW
 iLeocKXF8Csu9epy4qM9Iz4JXk30np9gAourdLid2qqgC63TK0Q1ddM1cOFcOC4I3bZPimBystS+s
 4WI/NSNW01q1JEeBQC+5qtXkJdnuhAmeiiZcmgRYih1VJDYaqApwPQZNnnuyre+JrXPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kq3gYAeKi+2MlDRtqxzklMdRJ3gSx3YIPGqwyIvmiBI=; b=W4qvTJozTYC2O3i/Wy0mkKgCq1
 gw4AcRtPjmGRkmUUry44C4zY1aIDlzeBHbNQUzl/kVNvjAgHAG2JPrrTKsJC7v74bm5V3LJrwDOjO
 rLh7AHTKL1+RhQty0H8JSeiXbdSx2V9daOju/8IKfrA/yiUolZoig7DkOMLr3l06MUXs=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTPyX-0000000016U-1R91
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 20:40:21 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso65678a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794948015; x=1795552815; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kq3gYAeKi+2MlDRtqxzklMdRJ3gSx3YIPGqwyIvmiBI=;
 b=Prdad+ffFOd+U3qt/tw9AAk+Qpem9FACdGewRWqePwGhG9U6pgjPv2Ynh/zE23Dg2c
 PyVvVuSFqg7UwIWL7JEfkJff2c7dakkpm976UdSstWFUNbyIR6B3sbAJLP4ujw/po5CH
 68KXON7rSUz8iWl8QNBoZN6tx8+yVY5KDzchRE207apmvMmKgXB0jahXY7D4E2Ir6FqS
 pibtp+Ybnb5ZA81PnZF7IGp5jlNKcFW3SdcGQMoQwzp1a+jVqO0u3yO0u7HMCaMh7gFx
 0GBaKE+i9wAVipmEL8r5QMYYVsKdVEbvPCB6/pAFEoC5rLojRpLDkAbLOkSkFo30D0o2
 HRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948015; x=1795552815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kq3gYAeKi+2MlDRtqxzklMdRJ3gSx3YIPGqwyIvmiBI=;
 b=TK+sZrXWTgSRm4Rusr4sYD5MJe0Zm+kTAnvtz2K6oP5aqwwMa3dBR8uZVJx3qQtBqC
 br2jouBQy+4CDE5U/duCkbKpLG7YWQXLPEzhqXAs7qTQjDOT7DJk1Irz9ukSiJUaKH2X
 +H8SIGAx/VkRoj3tLgWYFjjdPGkjUmjsPgSJit3zUlhvr7GP1iqvlS8a49r0ZGgCjeHc
 Ue8DeqLd8eJZU9flN0zFU8UV3ltqIJAA8Kb/uPBOBsfzELLk9sCFoTfq7dF8l68vT+A/
 FOiDtZoT+3GNFGSZ4Hk0GCVlcalYKEXXIylDLxhjGMgrM06w2f4ry68uNpHgRQADTZUQ
 HRKA==
X-Forwarded-Encrypted: i=1;
 AL+hErGGbpeuVkgNxLm9az3HO69e78eY2y1yz+sHEXN+NQjL0upUUViFFwH7Jx1lkTho4QoDFjveAhGML0AVSWtxqEgF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8QF8gGVPyvK3z5vLjjqoTVSDPFm7ndOOR3Wwy8cp86117SRjZl
 wqMekVVd45IcIYCkHuOxVmQzhfKrckeXpYsRC/n8J2Kjcy5cxqYso/aEoeTQow==
X-Gm-Gg: AZFdTZczv4nNWVZs5GV2OAip/JUhW75SoSjPwkSJ3s7XXWOfSUmeJFR1ui9wMpiQGjm
 /IdW1OmyZNN6mYblpKKECz0OB0w35Blaia3d8UTiXfL3Ua2aE2Jrl2zaLz7zsGJrHViDjVSWvg6
 eVrnYTW+wQFhh1ww7tsELaz5ZhDm6iMwP3K0MovzSTTR39FZGexM3A9gsor4+i4CRvXv5q38n78
 AstjiqNDfZypoDDVrsUfi01a2tt8n/8l0AuY/U2n/fJdAsawi3tIblCLSNrMLEry/s98EsaSoj+
 eIOs7usMPvRg3N0P4A9FnsgamTlZ+sjsJqpw7YYFAx4TnsvgoM4+kb+q0PZYxEd+kqWM6Kk3sPu
 e/AelW6nh0pnAKrbgZPrW+Rxtj8IKk8aCb4Dnnrub9vxycOqZinj6Ki4PwePJZfvKoWbsMpTQc7
 5QgFYud0/jvlhQaADPmVhdsNvHCkIXXHwW+hPWZT/H7zjKqSn2IvEMrm140Uh0SMcnoI2FOH0QL
 1nMRBWWhCtoRilSAJgCtyMA38QcNkOfDbkITenHIjo/9onyE77JNY/8XVBeweYkzxbfdz9FBymm
 kLl0raA3Bv1xrTsL3RUT1wlLdoykZ3wYcNQNTXsdb10HasRsUCuEWN1i+7lW8FKlobKYEZiSnAq
 s+JEZNG8kcRmPxbAW/zTdy9c9ehXYDXjogN0Owj8513PwbwA=
X-Received: by 2002:a17:90b:5390:b0:3ac:929e:691 with SMTP id
 98e67ed59e1d1-3b3d0759d78mr560936a91.17.1794948015486; 
 Tue, 17 Nov 2026 12:40:15 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d1acde45sm547366a91.11.2026.11.17.12.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:40:14 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 17 Nov 2026 12:40:10 -0800
Message-ID: <20261117204010.1742691-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTPyX-0000000016U-1R91
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix calloc() calls with transposed
 arguments
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

GCC 14 and later warn about a calloc() call that has sizeof() in the
first argument and not in the second one, and the CI builds with
-Wextra -Werror:

  libf2fs.c: In function 'utf8_to_utf16':
  libf2fs.c:127:47: error: 'calloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
    127 |         uint16_t *volume_name = calloc(sizeof(uint16_t), MAX_VOLUME_NAME);
        |                                               ^~~~~~~~
  libf2fs.c:127:47: note: earlier argument should specify number of elements, later size of each element

Pass the number of elements first and the size of an element second in
all the calls that the compiler reports. No functional change.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c        | 8 ++++----
 fsck/mount.c       | 6 +++---
 lib/libf2fs.c      | 4 ++--
 mkfs/f2fs_format.c | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a56c16b..56d4744 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -95,7 +95,7 @@ static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct hard_link_node *node = NULL, *tmp = NULL, *prev = NULL;
 
-	node = calloc(sizeof(struct hard_link_node), 1);
+	node = calloc(1, sizeof(struct hard_link_node));
 	ASSERT(node != NULL);
 
 	node->nid = nid;
@@ -2119,7 +2119,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 	make_dentry_ptr(&d, node_blk, inline_dentry, 2);
 
 	fsck->dentry_depth++;
-	new_dentry = calloc(sizeof(struct f2fs_dentry), 1);
+	new_dentry = calloc(1, sizeof(struct f2fs_dentry));
 	ASSERT(new_dentry != NULL);
 
 	new_dentry->depth = fsck->dentry_depth;
@@ -2164,7 +2164,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, int casefolded, u32 blk_addr,
 	ASSERT(ret >= 0);
 
 	fsck->dentry_depth++;
-	new_dentry = calloc(sizeof(struct f2fs_dentry), 1);
+	new_dentry = calloc(1, sizeof(struct f2fs_dentry));
 	ASSERT(new_dentry != NULL);
 	new_dentry->depth = fsck->dentry_depth;
 	memcpy(new_dentry->name, child->p_name, F2FS_NAME_LEN);
@@ -2637,7 +2637,7 @@ void fsck_init(struct f2fs_sb_info *sbi)
 	ASSERT(tree_mark_size != 0);
 	tree_mark = calloc(tree_mark_size, 1);
 	ASSERT(tree_mark != NULL);
-	fsck->dentry = calloc(sizeof(struct f2fs_dentry), 1);
+	fsck->dentry = calloc(1, sizeof(struct f2fs_dentry));
 	ASSERT(fsck->dentry != NULL);
 	memcpy(fsck->dentry->name, "/", 1);
 	fsck->dentry_end = fsck->dentry;
diff --git a/fsck/mount.c b/fsck/mount.c
index 98d797e..f4d1363 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3587,8 +3587,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->nat_area_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
 	ASSERT(fsck->nat_area_bitmap);
 
-	fsck->entries = calloc(sizeof(struct f2fs_nat_entry),
-					fsck->nr_nat_entries);
+	fsck->entries = calloc(fsck->nr_nat_entries,
+					sizeof(struct f2fs_nat_entry));
 	ASSERT(fsck->entries);
 
 	for (block_off = 0; block_off < nr_nat_blks; block_off++) {
@@ -3763,7 +3763,7 @@ static struct fsync_inode_entry *add_fsync_inode(struct list_head *head,
 {
 	struct fsync_inode_entry *entry;
 
-	entry = calloc(sizeof(struct fsync_inode_entry), 1);
+	entry = calloc(1, sizeof(struct fsync_inode_entry));
 	if (!entry)
 		return NULL;
 	entry->ino = ino;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index b23d9c7..307cfcb 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -124,7 +124,7 @@ int utf8_to_utf16(char *output, const char *input, size_t outsize,
 	const char *inp = input;
 	uint16_t *outp;
 	wchar_t wc;
-	uint16_t *volume_name = calloc(sizeof(uint16_t), MAX_VOLUME_NAME);
+	uint16_t *volume_name = calloc(MAX_VOLUME_NAME, sizeof(uint16_t));
 
 	if (!volume_name)
 		return -ENOMEM;
@@ -219,7 +219,7 @@ int utf16_to_utf8(char *output, const char *input, size_t outsize,
 	char *outp = output;
 	wchar_t wc;
 	uint16_t *inp;
-	uint16_t *volume_name = calloc(sizeof(uint16_t), MAX_VOLUME_NAME);
+	uint16_t *volume_name = calloc(MAX_VOLUME_NAME, sizeof(uint16_t));
 
 	if (!volume_name)
 		return -ENOMEM;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 33d3da9..d4a02ee 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -757,7 +757,7 @@ static int f2fs_init_sit_area(void)
 	blk_size = 1 << get_sb(log_blocksize);
 	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
 
-	zero_buf = calloc(sizeof(uint8_t), seg_size);
+	zero_buf = calloc(seg_size, sizeof(uint8_t));
 	if(zero_buf == NULL) {
 		MSG(1, "\tError: Calloc Failed for sit_zero_buf!!!\n");
 		return -1;
@@ -791,7 +791,7 @@ static int f2fs_init_nat_area(void)
 	blk_size = 1 << get_sb(log_blocksize);
 	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
 
-	nat_buf = calloc(sizeof(uint8_t), seg_size);
+	nat_buf = calloc(seg_size, sizeof(uint8_t));
 	if (nat_buf == NULL) {
 		MSG(1, "\tError: Calloc Failed for nat_zero_blk!!!\n");
 		return -1;
-- 
2.56.1.703.gf848ed807c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
