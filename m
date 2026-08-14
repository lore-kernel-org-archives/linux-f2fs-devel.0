Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C876C5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRo24zcjyznim0nNYLQqyWbZn66dueYs85+TwimkoSk=; b=g5Rhm8F7nzW3wW+ocYw3GL/jtr
	T1ej6i3+FpUrjHlzlpNMYImDh7JQ3FF5F1ytePcrSmc6s0luq43JvhtfnDh61fqL/OfTpdpl1msvD
	/yGtevtAdblhGkwbEtigf1AGrQH99W89nrUpvP3XKc/L0uMq7rkV7WlH4JstxcjQTwuA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuv6g-0002do-Gp;
	Fri, 14 Aug 2026 16:50:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wuv6f-0002dh-0E
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cNL7v7GZnT9mWfD7XEFWr83ILnsjWusW1EcmZcHwsvs=; b=Wi3oZL8oTlzsk/pE/LHq9DehMD
 YedIBOrUcm2d/IXrHXlc4KZlrsnqkHIQU0rKv+JjPkPPsHhX15G53yCpD1JjjCHqX0LpvP0g2YazE
 u54JGKVzdBy11S6pvVuzR9g/26aKJ68yI90tQkdVdLKhBLXw7/lqKHPFP/pPF0NLZ1o8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cNL7v7GZnT9mWfD7XEFWr83ILnsjWusW1EcmZcHwsvs=; b=Iy8mwJm2CZ8OP9UR7dQk3y55on
 +FppdVcYrhiugbtKPNxLoTCajjw8QCFfiJkxxvHekyYIj4zQA88svnNWfC7DIMDEqYGE+xHoeZjrh
 gBMFrv0AIRd3pTKp0MLHLECKytFXz7jiULUThdzxydauGfJLVQXwNtDz34q4T3Ao9X9k=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuv6Z-0007DR-Tr for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:50:06 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso9090565e9.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786726197; x=1787330997; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cNL7v7GZnT9mWfD7XEFWr83ILnsjWusW1EcmZcHwsvs=;
 b=p/nB2PmFRWdjXHGhAG0wjQD+Rms4eYJFK2vqO/lBP20Xa5/59+K8f+sBOqygG2NLJv
 d1DV0WqiEG2nKdbD5jrnQDoaDITHv5LYfhC1T+fSvo3MhI2k/9WnmnUwq2UEp3wxZDWI
 dmgcCg2AXx6svbpqdVXJZQcNcrMAEFu+dQqAhFULBtIzizEbSnGJ0QAVSBUGjQBQxJ9U
 2pd4QW1DXXCPjQKVYRs/XS3UlmlAZXqsGUOvJVf9gnsKDE3hnxpBE9Kz1kYtxzYn4/1g
 xklvAnmQ13ZNXkrVBDg8QjWbeyul/Nyb55ppjjU7P/zX7P6Wc+nQdUbZG2XsmsGACEcb
 iEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786726197; x=1787330997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cNL7v7GZnT9mWfD7XEFWr83ILnsjWusW1EcmZcHwsvs=;
 b=nxWxWcu9ffndDJjugUaJlDZlciVXuQ8HHku1ISmE8+GZvZNw/Pj2VuqpjEDl87GPql
 PoU+/aOEGk+QpH2vbkcausbR16MiwYyiDcZSZLI/aI6ORdV1gH7IpG0GsyFAZGCjtyAX
 9tRlZKa0wchaw3cQijxotTFaW4ATKxjq3JMj/DZ5QLaCp7Od7z336yX+ZRhrfrs9Yl5u
 J4l2hWLpS6lK60jiai1MZfjsSn/lIu4lsMFegHJ9GDHqBCY6wb5Cdm2U4uWSQioFDHHn
 Jo/4qIjRAl0ONMeBYSHfByb932+8MJAg0yCgw0oU+XgJV2sdkwaCq7AeBGUzFPUQjgey
 GOpg==
X-Gm-Message-State: AOJu0YzACmc4W1D4L9Y83HiOwkKNLyMDAMewBUrsj6tpYoZrpPnSYdKB
 /LxNwwnwOFtckPJ7xt3wlOssOOaY73ch3H0Vv5GjShNFD/EHNXVoxlHa
X-Gm-Gg: AR+sD11O8iIAoOvhdetAoTbIXV4r+okPmRAP2DrH/jrllRUNZ+ot7yy0WxI4kLXcc1Z
 IGj5AKZ5G7exdmBtDAbT+Ea0AYEhO91lXeVWa9ifF63y84D7Qec3broBSZtrtVfMIme5N4b5Nd+
 8r8ZgOAHfS+sfsoigUrsULAFrjlR16hjU9LVPnwQyEDqdxAubcnZf7Ivvvj1HKUV9U2uE3+vTUl
 G8nfk8WJrwjm0fPL3f5p9oUJ2uY/4lbjbbpNP6vclM2tSL4GEmyCGahlh9uGYkYdozvqLUbUOUM
 IcsMVB+ySa20q5HDkqklk9rAvqfKhn0Q1m8HZ6tHCqJh3sYFf7cAuTmpW6LgCMikAVIzhCC09mv
 BFOfYw1PCfdvFgNymT57Quy3Kx2yVCEz+zwgp+0B+fCGsnibzogGFvLWRhmZgtysfKO+4xhVCKZ
 Rn3RXMxWBk6omTIUBU+FMaB57vil/BpO7vWP0K5IsXv3FiFwtCmIlYScE2kfkhGm4TpdjMfy7j+
 5pYdxrHTiIALy5eucjaKplQvhW6rjoNjFw=
X-Received: by 2002:a05:600c:4fcb:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-49987928d0cmr115168195e9.3.1786726197293; 
 Fri, 14 Aug 2026 09:49:57 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm9021223f8f.21.2026.08.14.09.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:49:56 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 15 Aug 2026 00:49:28 +0800
Message-ID: <20260814164929.693412-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wuv6Z-0007DR-Tr
Subject: [f2fs-dev] [PATCH 3/3] f2fs: dump read extent cache via sysfs for
 debugging
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Add a write-only per-sb sysfs entry "extent_cache_debug": writing a file
descriptor resolves the inode in the writer's context, dumps the largest
extent and every rbtree node (fofs/blk/len) to the kernel log via
f2fs_info(). A matching f2fs_io "extent_cache" subcommand is added in
f2fs-tools.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/sysfs.c        | 18 +++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index aaad72fa1553..d5d57bc642c8 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/file.h>
 #include <linux/f2fs_fs.h>
 
 #include "f2fs.h"
@@ -1268,6 +1269,50 @@ static void __init_extent_tree_info(struct extent_tree_info *eti)
 	atomic_set(&eti->total_ext_node, 0);
 }
 
+/* Dump the read extent cache of the inode behind @fd to the kernel log. */
+int f2fs_dump_read_extent_cache(struct f2fs_sb_info *sbi, int fd)
+{
+	struct fd f = fdget(fd);
+	struct inode *inode;
+	struct extent_tree *et;
+	struct rb_node *node;
+	struct extent_node *en;
+	unsigned int count = 0;
+	int ret = 0;
+
+	if (fd_empty(f))
+		return -EBADF;
+
+	inode = file_inode(fd_file(f));
+	if (inode->i_sb != sbi->sb) {
+		fdput(f);
+		return -EINVAL;
+	}
+
+	et = F2FS_I(inode)->extent_tree[EX_READ];
+	if (!et) {
+		f2fs_info(sbi, "ino=%llu: read extent cache disabled",
+			  (unsigned long long)inode->i_ino);
+		goto out;
+	}
+
+	read_lock(&et->lock);
+	f2fs_info(sbi, "ino=%llu largest: fofs=%u blk=%u len=%u node_count=%u",
+		  (unsigned long long)inode->i_ino, et->largest.fofs,
+		  et->largest.blk, et->largest.len,
+		  atomic_read(&et->node_cnt));
+	for (node = rb_first_cached(&et->root); node; node = rb_next(node)) {
+		en = rb_entry(node, struct extent_node, rb_node);
+		f2fs_info(sbi, "  [%u] fofs=%u blk=%u len=%u",
+			  count, en->ei.fofs, en->ei.blk, en->ei.len);
+		count++;
+	}
+	read_unlock(&et->lock);
+out:
+	fdput(f);
+	return ret;
+}
+
 void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 {
 	__init_extent_tree_info(&sbi->extent_tree[EX_READ]);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b96d8718c5c..be2bd6e2a2bd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4648,6 +4648,7 @@ void f2fs_update_read_extent_cache_range(struct dnode_of_data *dn,
 			pgoff_t fofs, block_t blkaddr, unsigned int len);
 unsigned int f2fs_shrink_read_extent_tree(struct f2fs_sb_info *sbi,
 			int nr_shrink);
+int f2fs_dump_read_extent_cache(struct f2fs_sb_info *sbi, int fd);
 
 /* block age extent cache ops */
 void f2fs_init_age_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3201e2185fea..046d68962d18 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1368,6 +1368,23 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 F2FS_GENERAL_RO_ATTR(defrag_blocks);
 #endif
 
+static ssize_t extent_cache_debug_store(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, const char *buf, size_t count)
+{
+	int fd, ret;
+
+	ret = kstrtoint(buf, 0, &fd);
+	if (ret < 0)
+		return ret;
+	ret = f2fs_dump_read_extent_cache(sbi, fd);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+static struct f2fs_attr f2fs_attr_extent_cache_debug = __ATTR(
+		extent_cache_debug, 0200, NULL, extent_cache_debug_store);
+
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2);
@@ -1491,6 +1508,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(avg_vblocks),
 	ATTR_LIST(defrag_blocks),
 #endif
+	ATTR_LIST(extent_cache_debug),
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(unusable_blocks_per_sec),
 	ATTR_LIST(max_open_zones),
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
