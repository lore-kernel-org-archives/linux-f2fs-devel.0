Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282ADC3DA42
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:59:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sU0VG-0001fI-Tk;
	Wed, 17 Jul 2024 08:59:15 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sU0VF-0001f9-4P
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jul 2024 08:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tLyP0tCp4GYoOfqNAEQVyvUhiJMRjmuQcfTLOf9zsns=; b=VFepv2mTm9z8Z5GtWAt6fwDlmC
 K6+20Qx3daJv/lCNF7gwFT7paKSC8MEiqtR4MLDKoND0DxySo38mg5CUfWaJUlXUsAY4ixmbER/18
 fNGRRY28U4mIHMqbhdIeP8KVIzMD+jw5Zf3um7yuNobXOFa+YtpfAmrHdwof01y9/QUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tLyP0tCp4GYoOfqNAEQVyvUhiJMRjmuQcfTLOf9zsns=; b=B
 y77pon7rhuyfWpbyvNMZMhJ8UO72jl117Uc6/97tg8Gvmf6xn0E4CQYB7/xlJk25BkSPsDzGJVrDa
 HhtoDzdABit5APg7VjF4PBoRCKjR7jMWznRDzPdokT6O1Kd9UzNp9okyjdXMRxR1smm5WWG23T4PJ
 abu6rddi4Hs4VZvw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sU0VF-0007bK-K2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jul 2024 08:59:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 32563CE125A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Jul 2024 08:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80085C32782;
 Wed, 17 Jul 2024 08:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721206740;
 bh=WWC9EF7z6Oz54asjcN97PiFyIwYbjDfrJklXcdrqfVo=;
 h=From:To:Cc:Subject:Date:From;
 b=j/uCYmOvqMohsIPglqiX2nVvbGEcXJf4NAVQszFjPqx3O2oPTRQ0nFzRre9x5FUre
 /p30fb/5gVX1rhwnFHHOQ2sPXkllfdDIq7yhGhjc6i7xaa93hXqjf31R5XCCBhCgYC
 RikHaHXnlnva0eYA9METQkzgvlnjbs7HW5VyrbHrlmkRIursMqghUEX6YirIziggsn
 sauS/naJv39RyIB9IPFKU5nqXrQH62d+gvkwcvRLmIa1fYjhZXOPnY2qgc5AhwzBcx
 w13KUsOKSQfq+Q1bpTLXcysS3QtoC2y5OPGJPrTNLI8XaZmbv1ujLFqw2+zKs2DbE5
 vgn1kraZ6Lnjw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 17 Jul 2024 16:58:56 +0800
Message-Id: <20240717085856.2154901-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sU0VF-0007bK-K2
Subject: [f2fs-dev] [PATCH] f2fs-tools: clean up addrs_per_{inode,block}()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introduce a new help addrs_per_page() to wrap common code
from addrs_per_inode() and addrs_per_block() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 include/f2fs_fs.h |  7 +++----
 lib/libf2fs.c     | 13 +++----------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 75cbf22..d71a2d7 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -927,10 +927,10 @@ static_assert(sizeof(struct node_footer) == 24, "");
 				- sizeof(struct node_footer)) / sizeof(__le32))
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					__get_extra_isize(inode))
-#define ADDRS_PER_INODE(i)	addrs_per_inode(i)
+#define ADDRS_PER_INODE(i)	addrs_per_page(i, true)
 /* Address Pointers in a Direct Block */
 #define DEF_ADDRS_PER_BLOCK ((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
-#define ADDRS_PER_BLOCK(i)	addrs_per_block(i)
+#define ADDRS_PER_BLOCK(i)	addrs_per_page(i, false)
 /* Node IDs in an Indirect Block */
 #define NIDS_PER_BLOCK    ((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
 
@@ -1565,8 +1565,7 @@ struct f2fs_configuration {
 extern int utf8_to_utf16(char *, const char *, size_t, size_t);
 extern int utf16_to_utf8(char *, const char *, size_t, size_t);
 extern int log_base_2(uint32_t);
-extern unsigned int addrs_per_inode(struct f2fs_inode *);
-extern unsigned int addrs_per_block(struct f2fs_inode *);
+extern unsigned int addrs_per_page(struct f2fs_inode *, bool);
 extern unsigned int f2fs_max_file_offset(struct f2fs_inode *);
 extern __u32 f2fs_inode_chksum(struct f2fs_node *);
 extern __u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 03d900e..d179c3c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -516,9 +516,10 @@ opaque_seq:
 	return __f2fs_dentry_hash(name, len);
 }
 
-unsigned int addrs_per_inode(struct f2fs_inode *i)
+unsigned int addrs_per_page(struct f2fs_inode *i, bool is_inode)
 {
-	unsigned int addrs = CUR_ADDRS_PER_INODE(i) - get_inline_xattr_addrs(i);
+	unsigned int addrs = is_inode ? CUR_ADDRS_PER_INODE(i) -
+		get_inline_xattr_addrs(i) : DEF_ADDRS_PER_BLOCK;
 
 	if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
 			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
@@ -526,14 +527,6 @@ unsigned int addrs_per_inode(struct f2fs_inode *i)
 	return ALIGN_DOWN(addrs, 1 << i->i_log_cluster_size);
 }
 
-unsigned int addrs_per_block(struct f2fs_inode *i)
-{
-	if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
-			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
-		return DEF_ADDRS_PER_BLOCK;
-	return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, 1 << i->i_log_cluster_size);
-}
-
 unsigned int f2fs_max_file_offset(struct f2fs_inode *i)
 {
 	if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
