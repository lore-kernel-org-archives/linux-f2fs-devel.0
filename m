Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FBC624D2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2vsAaIyEm9PgtoZWpZ8vo60t7gXAKvItX4Ck5dr7bw=; b=MkOme6XGj+ObPPNWg+4/iOFAz0
	3/7IVTp1XigD1KeEyLNnJDTXXV4kKR3qCd98KxUnIGcHypf1ttVlF4G2PJT/raGjJrIKXyhk8ylhI
	MHcvo5B30XKLlub0kaTOXSedq7HMdZ2AHGWSreOT/OR7tYtJP24JzFb70nErtWgfZLgw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ov-0007zM-SH;
	Mon, 31 Aug 2026 17:02:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Os-0007yf-QD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vBZz0FHk3hbElOsJDIqL5UVlyjBmQ/JI/HbefNK6tE=; b=EiakE6HipRGIWqWw+MFb8dXXWp
 +BGaQlQ97f+3zWH7BDF7li8xnZnqyrNikwb3oXCFxj92YoMPpF1b5pEqQqleDuGjaQ4XUtMcYctoW
 aMwfI2CB/h6Ns2dqXj0tNRFOMZBSbnjMgv9wMpHsapF0aJvmFNEh7HWkcbeiQlxjm+EI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1vBZz0FHk3hbElOsJDIqL5UVlyjBmQ/JI/HbefNK6tE=; b=iars8tuZkV5PCOt/ZXS0waib4h
 DTeUS7vIXrR6lMGaM8ZTjJT+RNSTUe4TCR37PziDkpTLdHpnluHrMcLsiDwyxkEDRsQeAQaD2UQUH
 0WJ74c89mlRUPOhTxrWQVqr/VgKw/ZFPIG8IxMadbsU00ookLRl28hsB9CogD+wO4kuU=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Or-00014i-AF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:26 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a65e66555cso1070523a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195739; cv=none;
 d=google.com; s=arc-20260327;
 b=cb6wU3xcTYTAEaYWpj/zn8LtOzf4L39Yl5vYtw5o91rHJYRFvgoKJ0nhhHTVM+Cyek
 y+Ru3A4mmqZZ8H04QuYbGCxy5S18+Y1KHpcAqr7jgzcrtRVSUe8sqWBL0jlpwB95Br7r
 /YJ3wdn55xOBWyI6P27YDHUhUatScavidTnQS5t3wfwaedlGdm/1JHA6gWPEw4DjZ7mX
 nGBAQ6egAW03wqY6cc+6qEPK4hbYmqTFX3DJse+uwDZBDCEhkqI8RTs+W2w63090V7r2
 BQ0p5dD4YHB5JFhr3yuIe3AK5bmc0vjTBlAJ7tjvfXeNVPYtmNGH3B4esT7cfQcZhgqo
 PHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=1vBZz0FHk3hbElOsJDIqL5UVlyjBmQ/JI/HbefNK6tE=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=Lz+bRpRdAoZS/W5rRxSiYWs7mFkXYdMY3YNXTCwp060mNtC24KVNCmPJG2Ymsi8XXp
 C4CfMe1mY0mNBwMe2xUxcGwEwdiRsLkBrZSoB/DT2N6zfzit4djLn5QpIQ2tZ+zpp1nb
 5XCJ38kQO2ROW3a1JnOMCUB7JhF2cpGbWgqiaY2mN4z8QvhLVuu3/JOlpcZKw/t0KRav
 +pEzRgPVH2J8mWD/Vf8fCS8qjkYYT22Xt1mmHlGaeOWMa8f34ifsAf48Ezzkg744LbmX
 lhOnt7BgDNtjJRXWJhnNJQqGZDCTUdL7XYY51qC69f3j/DF40XIjudpIzsLIA5LOPJJw
 zEqg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195739; x=1788800539; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1vBZz0FHk3hbElOsJDIqL5UVlyjBmQ/JI/HbefNK6tE=;
 b=SIqM6XXyYvTxnac71ZdG3CdXPeAga/UIpwayamU4Z/HYauZBCqWoCnX67lNUlq8ulM
 AAXtjnSFB1D1oVS1z0M9suJKYI19qGXTW8mepLuNptJVPyF7CRMpeeLl1z5/7kqnZbyP
 m5ZEcvLGRCBdJN3FgFfqVrL1JGxzlTHQ4Irz58iUilfZgg4aojh0yo2ZgoHaZ18Thi3G
 NPf4A1Yk2O1bvIajoyqIZcHuGQe6eX0Bvi3ri3fuWHTL6szzlZwTtpd1sSW9Da+xW8/s
 Wmc0GhmNYFdRmfomYq49da6NitQjzGqEfox765eCnA9LJyrk8fpxs7kxiSPaNGp4WSvf
 Nipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195739; x=1788800539;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1vBZz0FHk3hbElOsJDIqL5UVlyjBmQ/JI/HbefNK6tE=;
 b=cgZ00GuHo+KiRWRaitTGfpLhEFuW7JX75e1D6d4YiqFKMz4RS3MsyUcPT+bSGkX70b
 0uHlIX1V5U84XpMInaf1FSuqcRDY6PO0QpXyNQ1ig1mON3tejXAleh94yYvWbet4kh7Y
 857P0EMh1zVnkaOajFqOxcY7G1jJcUKOXUAaccIadLvAKyoMy1Ll8CH9TtFQNQK3WI33
 n7mtLltkAQX+MG/Ko2/Gd032JagrFUsv7yfNST/iBDD3IOwiRN1pTHmEIoWVsUlVzEdS
 Cofkqnxo4MDuwP+ZP9WfdJqsbr8SVm/066g3vCjvCSRZA7ngZMpZAPbhH4PwLTp6sqdJ
 vsbA==
X-Gm-Message-State: AFuF++niHmCAbRpwFJ/3gU5lTcqRTIhB/qjASAbPN6WHi7fRxkKkDB2l
 b0UVaILZ4ZNde7ASNbwD1hG7Lur1uwJPwPY431ACQRqTDq3FS1IgmPpcbQxQZIPYmNEKUHY7uiP
 qwXf5O9CJMUwkACG0cuEN1qSg/bkMkciLWJ9sbKo=
X-Gm-Gg: AYBFou0rk5L2f/nlaIJncNbg9BTKqMsJMDoljxSQK+HY9uFQVQBRfpdr+F1l2GXuytE
 2foC99fbjaTu+XQABhK/hIZ30fm7nIGUwgmL7/7hn2JyCwC/giiEtGCUjqj+Ahp5nyUrS6YwwBB
 Ag50b74/l5PoIyKd/xP3Szaq//naUBQFqYwOS2wzH8I1Pgvgk6A5tpj3sz8iKwKIsNgLhjG2zGz
 7j6auqWFcWKCgDnpAlODBWy779sllnpvF7b3axKN/4OeERh6RYknH49zWankzodZJ28nptenLD7
 RIY0YwbKJsZFCPrkbKmchD/wac/9ilxsLaP0NzAQcO08qJ4S/1vb/0NkwDMqcla4cZKuC2Zqjcq
 Vvw==
X-Received: by 2002:a05:6402:350d:b0:69f:b347:a681 with SMTP id
 4fb4d7f45d1cf-6a60d35184amr16511199a12.4.1788195738449; Mon, 31 Aug 2026
 10:02:18 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:17 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:17 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:02:17 +0200
X-Gm-Features: AcwNN1VjDsFZO9BfkBAApQVp9XP-_e-SD7zWpD2MNlBPN4_1esM_xtQfZjKM9wA
Message-ID: <CAH=xXfG56_NWR88ZfYEyB86FFz5Py5A=kTFHsJ-vMDpw8Ou1WA@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Or-00014i-AF
Subject: [f2fs-dev] [PATCH v4 06/11] f2fs: describe {i, d,
 id}node block layout dynamically
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

An inode block ends with five i_nid entries followed by a node footer.
Data block address pointers (i_addr[]) precede them. Similarly, direct and
indirect node blocks contain data addresses or node IDs followed by a node
footer at the end of the block.

Describe struct f2fs_inode, struct direct_node, and
struct indirect_node using flexible array members. Compute the locations
of i_nid and node footers dynamically from the filesystem block size.
Introduce F2FS_INODE_NIDS() and F2FS_NODE_FOOTER() helpers to access these
tail fields.

Compute sbi->addrs_per_inode, sbi->addrs_per_block, and
sbi->nids_per_block in init_sb_info(), and update node management, file
mapping, and recovery paths accordingly.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/f2fs.h          | 32 ++++++++++++++++++-------
 fs/f2fs/gc.c            |  2 +-
 fs/f2fs/inline.c        |  3 +--
 fs/f2fs/inode.c         |  5 ++--
 fs/f2fs/node.c          |  4 +---
 fs/f2fs/node.h          | 53 +++++++++++++++++++----------------------
 fs/f2fs/super.c         |  5 ++++
 include/linux/f2fs_fs.h | 26 +++++++++++++++-----
 9 files changed, 79 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6ae0eb37d20f..751b7a457d9a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2027,7 +2027,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,

 		phys = F2FS_BLK_TO_BYTES(ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
-					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
+					sizeof(__le32) * (DEF_ADDRS_PER_INODE_SBI(sbi) -
 					get_inline_xattr_addrs(inode));

 		phys += offset;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d2e54573ed34..247e56522441 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1853,6 +1853,9 @@ struct f2fs_sb_info {
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
 	unsigned int nat_entries_per_block;	/* NAT entries in a block */
+	unsigned int addrs_per_inode;		/* addresses in an inode block */
+	unsigned int addrs_per_block;		/* addresses in a direct node block */
+	unsigned int nids_per_block;		/* node IDs in an indirect node block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int orphans_per_block;	/* orphan inodes in a block */
 	unsigned int dentries_per_block;	/* dentries in a block */
@@ -2248,6 +2251,7 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)

 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
 #define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
+#define DEF_ADDRS_PER_INODE_SBI(sbi)	((sbi)->addrs_per_inode)
 #define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
 #define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
 					F2FS_ORPHANS_PER_BLOCK(sbi))
@@ -2297,6 +2301,12 @@ static inline struct f2fs_checkpoint
*F2FS_CKPT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_checkpoint *)(sbi->ckpt);
 }

+static inline struct node_footer *F2FS_NODE_FOOTER(const struct folio *folio)
+{
+	return folio_address(folio) + F2FS_BLKSIZE -
+		sizeof(struct node_footer);
+}
+
 static inline struct f2fs_node *F2FS_NODE(const struct folio *folio)
 {
 	return (struct f2fs_node *)folio_address(folio);
@@ -2307,6 +2317,12 @@ static inline struct f2fs_inode
*F2FS_INODE(const struct folio *folio)
 	return &((struct f2fs_node *)folio_address(folio))->i;
 }

+static inline __le32 *F2FS_INODE_NIDS(const struct folio *folio)
+{
+	return folio_address(folio) + F2FS_BLKSIZE - sizeof(struct node_footer) -
+		SIZE_OF_I_NID;
+}
+
 static inline struct f2fs_nm_info *NM_I(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_nm_info *)(sbi->nm_info);
@@ -3277,13 +3293,11 @@ static inline void
f2fs_radix_tree_insert(struct radix_tree_root *root,
 		cond_resched();
 }

-#define RAW_IS_INODE(p)	((p)->footer.nid == (p)->footer.ino)
-
 static inline bool IS_INODE(const struct folio *folio)
 {
-	struct f2fs_node *p = F2FS_NODE(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(folio);

-	return RAW_IS_INODE(p);
+	return footer->nid == footer->ino;
 }

 static inline int offset_in_addr(struct f2fs_inode *i)
@@ -3292,9 +3306,11 @@ static inline int offset_in_addr(struct f2fs_inode *i)
 			(le16_to_cpu(i->i_extra_isize) / sizeof(__le32)) : 0;
 }

-static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
+static inline __le32 *blkaddr_in_node(const struct folio *folio)
 {
-	return RAW_IS_INODE(node) ? node->i.i_addr : node->dn.addr;
+	struct f2fs_node *node = F2FS_NODE(folio);
+
+	return IS_INODE(folio) ? node->i.i_addr : node->dn.addr;
 }

 static inline int f2fs_has_extra_attr(struct inode *inode);
@@ -3311,7 +3327,7 @@ static inline unsigned int get_dnode_base(struct
inode *inode,
 static inline __le32 *get_dnode_addr(struct inode *inode,
 					struct folio *node_folio)
 {
-	return blkaddr_in_node(F2FS_NODE(node_folio)) +
+	return blkaddr_in_node(node_folio) +
 			get_dnode_base(inode, node_folio);
 }

@@ -3639,7 +3655,7 @@ void *inline_xattr_addr(struct inode *inode,
const struct folio *folio)
 {
 	struct f2fs_inode *ri = F2FS_INODE(folio);

-	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
+	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE_SBI(F2FS_I_SB(inode)) -
 					get_inline_xattr_addrs(inode)]);
 }

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c15c6ba91597..f15ab07a7347 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1176,7 +1176,7 @@ static bool is_alive(struct f2fs_sb_info *sbi,
struct f2fs_summary *sum,

 	if (IS_INODE(node_folio)) {
 		base = offset_in_addr(F2FS_INODE(node_folio));
-		max_addrs = DEF_ADDRS_PER_INODE;
+		max_addrs = DEF_ADDRS_PER_INODE_SBI(sbi);
 	} else {
 		base = 0;
 		max_addrs = DEF_ADDRS_PER_BLOCK;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 718dd785865a..73cd9b6ddcc5 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -36,14 +36,13 @@ bool f2fs_may_inline_data(struct inode *inode)

 static bool inode_has_blocks(struct inode *inode, struct folio *ifolio)
 {
-	struct f2fs_inode *ri = F2FS_INODE(ifolio);
 	int i;

 	if (F2FS_HAS_BLOCKS(inode))
 		return true;

 	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
-		if (ri->i_nid[i])
+		if (F2FS_INODE_NIDS(ifolio)[i])
 			return true;
 	}
 	return false;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 96cc0e777567..fda9ee3bfc61 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -150,9 +150,8 @@ bool f2fs_enable_inode_chksum(struct f2fs_sb_info
*sbi, struct folio *folio)

 static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	struct f2fs_node *node = F2FS_NODE(folio);
-	struct f2fs_inode *ri = &node->i;
-	__le32 ino = node->footer.ino;
+	struct f2fs_inode *ri = F2FS_INODE(folio);
+	__le32 ino = F2FS_NODE_FOOTER(folio)->ino;
 	__le32 gen = ri->i_generation;
 	__u32 chksum, chksum_seed;
 	__u32 dummy_cs = 0;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 960c6657d0d6..e3f594f7bcce 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -3001,7 +3001,6 @@ int f2fs_recover_inode_page(struct f2fs_sb_info
*sbi, struct folio *folio)
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
-	struct f2fs_node *rn;
 	struct f2fs_summary *sum_entry;
 	block_t addr;
 	int i, idx, last_offset, nrpages;
@@ -3023,8 +3022,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			if (IS_ERR(folio))
 				return PTR_ERR(folio);

-			rn = F2FS_NODE(folio);
-			sum_entry->nid = rn->footer.nid;
+			sum_entry->nid = F2FS_NODE_FOOTER(folio)->nid;
 			sum_entry->version = 0;
 			sum_entry->ofs_in_node = 0;
 			sum_entry++;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 0dce97aac5fc..6a2b7c63f4a3 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -252,73 +252,68 @@ static inline void set_to_next_nat(struct
f2fs_sb_info *sbi,

 static inline nid_t ino_of_node(const struct folio *node_folio)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_folio);
-	return le32_to_cpu(rn->footer.ino);
+	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->ino);
 }

 static inline nid_t nid_of_node(const struct folio *node_folio)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_folio);
-	return le32_to_cpu(rn->footer.nid);
+	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->nid);
 }

 static inline unsigned int ofs_of_node(const struct folio *node_folio)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_folio);
-	unsigned flag = le32_to_cpu(rn->footer.flag);
+	unsigned int flag = le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->flag);
 	return flag >> OFFSET_BIT_SHIFT;
 }

 static inline __u64 cpver_of_node(const struct folio *node_folio)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_folio);
-	return le64_to_cpu(rn->footer.cp_ver);
+	return le64_to_cpu(F2FS_NODE_FOOTER(node_folio)->cp_ver);
 }

 static inline block_t next_blkaddr_of_node(const struct folio *node_folio)
 {
-	struct f2fs_node *rn = F2FS_NODE(node_folio);
-	return le32_to_cpu(rn->footer.next_blkaddr);
+	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->next_blkaddr);
 }

 static inline void fill_node_footer(const struct folio *folio, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
 	unsigned int old_flag = 0;

 	if (reset)
-		memset(rn, 0, sizeof(*rn));
+		memset(rn, 0, F2FS_BLKSIZE);
 	else
-		old_flag = le32_to_cpu(rn->footer.flag);
+		old_flag = le32_to_cpu(footer->flag);

-	rn->footer.nid = cpu_to_le32(nid);
-	rn->footer.ino = cpu_to_le32(ino);
+	footer->nid = cpu_to_le32(nid);
+	footer->ino = cpu_to_le32(ino);

 	/* should remain old flag bits such as COLD_BIT_SHIFT */
-	rn->footer.flag = cpu_to_le32((ofs << OFFSET_BIT_SHIFT) |
+	footer->flag = cpu_to_le32((ofs << OFFSET_BIT_SHIFT) |
 					(old_flag & OFFSET_BIT_MASK));
 }

 static inline void copy_node_footer(const struct folio *dst,
 		const struct folio *src)
 {
-	struct f2fs_node *src_rn = F2FS_NODE(src);
-	struct f2fs_node *dst_rn = F2FS_NODE(dst);
-	memcpy(&dst_rn->footer, &src_rn->footer, sizeof(struct node_footer));
+	memcpy(F2FS_NODE_FOOTER(dst), F2FS_NODE_FOOTER(src),
+	       sizeof(struct node_footer));
 }

 static inline void fill_node_footer_blkaddr(struct folio *folio,
block_t blkaddr)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_F_SB(folio));
-	struct f2fs_node *rn = F2FS_NODE(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
 	__u64 cp_ver = cur_cp_version(ckpt);

 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);

-	rn->footer.cp_ver = cpu_to_le64(cp_ver);
-	rn->footer.next_blkaddr = cpu_to_le32(blkaddr);
+	footer->cp_ver = cpu_to_le64(cp_ver);
+	footer->next_blkaddr = cpu_to_le32(blkaddr);
 }

 static inline bool is_recoverable_dnode(const struct folio *folio)
@@ -378,11 +373,12 @@ static inline bool IS_DNODE(const struct folio
*node_folio)
 static inline int set_nid(struct folio *folio, int off, nid_t nid, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
+	__le32 *inode_nids = F2FS_INODE_NIDS(folio);

 	f2fs_folio_wait_writeback(folio, NODE, true, true);

 	if (i)
-		rn->i.i_nid[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
+		inode_nids[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
 	else
 		rn->in.nid[off] = cpu_to_le32(nid);
 	return folio_mark_dirty(folio);
@@ -391,9 +387,10 @@ static inline int set_nid(struct folio *folio,
int off, nid_t nid, bool i)
 static inline nid_t get_nid(const struct folio *folio, int off, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
+	const __le32 *inode_nids = F2FS_INODE_NIDS(folio);

 	if (i)
-		return le32_to_cpu(rn->i.i_nid[off - NODE_DIR1_BLOCK]);
+		return le32_to_cpu(inode_nids[off - NODE_DIR1_BLOCK]);
 	return le32_to_cpu(rn->in.nid[off]);
 }

@@ -406,8 +403,7 @@ static inline nid_t get_nid(const struct folio
*folio, int off, bool i)

 static inline int is_node(const struct folio *folio, int type)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	return le32_to_cpu(rn->footer.flag) & BIT(type);
+	return le32_to_cpu(F2FS_NODE_FOOTER(folio)->flag) & BIT(type);
 }

 #define is_cold_node(folio)	is_node(folio, COLD_BIT_SHIFT)
@@ -416,14 +412,13 @@ static inline int is_node(const struct folio
*folio, int type)

 static inline void __set_mark(const struct folio *folio, bool mark, int type)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	unsigned int flag = le32_to_cpu(rn->footer.flag);
-
+	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
+	unsigned int flag = le32_to_cpu(footer->flag);
 	if (mark)
 		flag |= BIT(type);
 	else
 		flag &= ~BIT(type);
-	rn->footer.flag = cpu_to_le32(flag);
+	footer->flag = cpu_to_le32(flag);
 }

 static inline void set_cold_node(const struct folio *folio, bool is_dir)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8d2224e585d3..fcaeaacaab33 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4384,6 +4384,11 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->blocksize = BIT(sbi->log_blocksize);
 	sbi->nat_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_nat_entry);
+	sbi->addrs_per_inode = (sbi->blocksize - OFFSET_OF_END_OF_I_EXT -
+		SIZE_OF_I_NID - sizeof(struct node_footer)) / sizeof(__le32);
+	sbi->addrs_per_block = (sbi->blocksize -
+		sizeof(struct node_footer)) / sizeof(__le32);
+	sbi->nids_per_block = sbi->addrs_per_block;
 	sbi->sit_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_sit_entry);
 	sbi->orphans_per_block = (sbi->blocksize -
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d1059a27e1b9..3d0fe2c78e12 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -16,6 +16,7 @@
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
 #define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for
sector/blk */
 #define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
+#define F2FS_MAX_BLKSIZE		PAGE_SIZE
 #define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
@@ -343,18 +344,25 @@ struct f2fs_inode {
 						 */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		} __packed;
-		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
+		DECLARE_FLEX_ARRAY(__le32, i_addr); /* data block pointers */
 	};
-	__le32 i_nid[DEF_NIDS_PER_INODE];	/* direct(2), indirect(2),
-						double_indirect(1) node id */
+	/*
+	 * __le32 i_nid[DEF_NIDS_PER_INODE];
+	 *
+	 * It is stored immediately before the node footer at the end of the
+	 * filesystem block. Its offset depends on the filesystem block size, so
+	 * locate it dynamically with F2FS_INODE_NIDS().
+	 */
 } __packed;

 struct direct_node {
-	__le32 addr[DEF_ADDRS_PER_BLOCK];	/* array of data block address */
+	/* The address count depends on the filesystem block size. */
+	DECLARE_FLEX_ARRAY(__le32, addr); /* array of data block address */
 } __packed;

 struct indirect_node {
-	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
+	/* The node ID count depends on the filesystem block size. */
+	DECLARE_FLEX_ARRAY(__le32, nid); /* array of data block address */
 } __packed;

 enum {
@@ -373,7 +381,13 @@ struct f2fs_node {
 		struct direct_node dn;
 		struct indirect_node in;
 	};
-	struct node_footer footer;
+	/*
+	 * struct node_footer footer;
+	 *
+	 * It is stored at the end of the filesystem block, after the inode or
+	 * direct/indirect node data. Its offset depends on the filesystem block
+	 * size, so locate it dynamically with F2FS_NODE_FOOTER().
+	 */
 } __packed;

 /*
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
