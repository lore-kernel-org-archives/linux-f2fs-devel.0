Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20D4C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:References:In-Reply-To:MIME-Version:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqW6/iML0WP/cKc5o1RQKDbdv2RGri2Uriqta8/KfRk=; b=FzLqZ+BhCgzOMQwzkB6tKKF5Rt
	V6UyWkmbzXZhFNsTr6qKqBdtm1c4Og3t19oJEWEyVsau7o352mIXLSF6PArUMw5T939VPos+z9cT4
	H0S77TnvDkO6yb7DxDBrJMON9S6wkrTfamGyzDprRcpYXyrw42qsqMc03Go1xjZ4Nm8I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzLLn-00021V-Rc;
	Wed, 26 Aug 2026 21:40:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1wzLLl-00020V-Sf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 References:In-Reply-To:MIME-Version:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OdE2tE4SZovbK921ryjtFVs/TiWS2M8qf75lm4EcWdQ=; b=lt4RrMgJ5CGz6qQ31DwpADmYlt
 SS/6vHavfvIxpR6Hr04KAlKVUP82TNBRkALA3Qn0hQ3NHpNKJ9PbntZmUzCkp5f8FVeAu3lS7cUKU
 td0VNJs3zbqSU8R0CUpQhv9PwRxZEgozifrioc3ueEhtCyVhxE/NLqgLgvUCct0ybHdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:References:In-Reply-To:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OdE2tE4SZovbK921ryjtFVs/TiWS2M8qf75lm4EcWdQ=; b=WKli8UU28Be+N6jKb3VzhPP76u
 x0TXovtjR3ytdFK3hb0z47MGWa5fWFv9Etob2sawguHum7gm9239ciWr4kQreHrR5cYUnJs5r9qXU
 CdtVkf+efcUoRavNfugl1QkIYyVNtzR0Hq2ozdFqMSCvvr4zJVitHFN3N/a5sVjSG6ws=;
Received: from mail-ed1-f54.google.com ([209.85.208.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzLLk-00026C-C6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 21:40:01 +0000
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso3485205a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 14:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787780394; cv=none;
 d=google.com; s=arc-20260327;
 b=PTu7qCSWSZZthqN1FCOcO0xJyMQ1v9s58K2sylTtyTym1vbhX9sFt6eIb2Gs2AY1qD
 /bmdyV2Ei1hVbmk3mFNO05mCxFk4FAzdZQ2PMScl8mNe3Vmx+E3iN/NqS9mbZn3C9gwE
 2VRI0Ypctt25zEiekeXFd280TWASYYcUVGJ7kkEWmNdQ14/xJQY0rG/CrqnVrxCV6Dz1
 xJ+6ncRQVQDNTFlQ5yfS6pQUEy0Xw5DmWUAhSWUYiyyPFyL6zA/+crKBRs9o9VtJWdzN
 XSKBbZ0JUTpsxRoTB12LeT/pXw1kQz6GW6uiNRIZssDeI0LwWInlI1C+U6qAZPBkgPss
 Tz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:mime-version
 :from:dkim-signature;
 bh=OdE2tE4SZovbK921ryjtFVs/TiWS2M8qf75lm4EcWdQ=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=O6BaIFmK3x6kwHuYyING3KQG7n9RRkaqoX3ITgJ/qoRUkS7htZmBdc2KQrd8P739hI
 6fdMMOLCyZhhrqu/w2PjJfrg1EL9aa5bVzRAZ1oUXc3m5XgjqjorlnR6D6h8TEVRqySE
 y5HdqtRUDl1c7p1E5YRVPIrk0ognh7ot/Vm7NB7pSFuGgNeQPqqC5CCtQuoOFb5ewh7u
 WlG+TUqhhM/UAcvH+QABjix2shx6i1UXSMUTlvUQOWfqGlfniIbeOKbNlJXB9ujo6Bdw
 6htj7Ew+jhjLIX+unv88XNGPx18d/wGxKhYcKSUKsJKt/IhC8LpTG/hdBFzIuwoP2Nq3
 gcrw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787780394; x=1788385194; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OdE2tE4SZovbK921ryjtFVs/TiWS2M8qf75lm4EcWdQ=;
 b=FdmX4AMiRbVq1eLm95nOtvcRpZm0VmS7DJVKF/Jh9K43vVe5VKxp3KZwLjisBdgpoI
 wsXEgeJGxzdXxT994grYuxjqE3oSD9S1OUwuJanOUZUyeKiFaMxHdXuNGjCgQ4JbH3/4
 Mc/GnP8arNwVUXRMQMgVpVtnaq9RUi4iubgd+ePqUFuOq0l6aWHRnktjCzprRrlKCk2G
 ZmA2H09SUlbbU3adowE/hrzYBOaAiS0FV0iyQW+hbZyJQMdEOGNFrIyDAw2Ds0CsmuIc
 abDbhoV2Y/MzNJ+u0uVfo3I04DHaJUurVk/JDGpi+nAVSySP3UTbBZjysBvKejAIH3Eo
 WnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787780394; x=1788385194;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OdE2tE4SZovbK921ryjtFVs/TiWS2M8qf75lm4EcWdQ=;
 b=TtXuR6u2qLnCjX819Gkmdr/AHObOtjndyy6gcAPxYPZYI9HpYTGfmA1OxB2afhKB/d
 dbKMXFcY2J3k2v+fZFWpsYKQFlMK9GvCKJe3Z1XE1x4nDLrXdpLCCkDJngl/6WP3syAy
 OLc3R8J9/KSfBVE8yPZ37GXE8xrlb0+aouhJ7ZiaAh0X4X1xFzEEzqM6VET0kXnEksi5
 /upQgV7zbEIBlBc2tpMvz3xuZzVzAqxth3sigv/Son78IpN91jfGBn8pBaMb4ZqIXa/J
 fxo/V8/TccQRl+Rc3Y9U9/nkON9flHCGWHBJXbzi6W0zr/XFn7+hhBmontgDd0U2qBEK
 GEog==
X-Gm-Message-State: AFuF++lTm3VFWz2EFg24TbufPlPKWqSACg42WyE5tf6FXzLMFlfq0M+G
 GNuhVJrP4khWBYaF9A0mFv82uxMmP86vYONlBMuZ6q4N6+SDuwxzTkG0bLm12wmTB/dtl0h4ajZ
 JE81Ax4AbK+JONk65+jLI0boHfazsQdJwoI45gKo=
X-Gm-Gg: AR+sD12pwAIMVCfls7s7756x0OGwXriGfKX+Gsw8zbs3ZGiold18a7wKd5fSMgvMmrY
 2cGGwzBwHMPeDjroIyeYRBKSNrlLxXIvTJWxn6Eu96ctzpoOmqPJhpsUrfO1RdGvTHHSIrORzoU
 1p+OaGkzdoENYnzoWERnhqp59G4mM6A/CRY+zet1Fxb4gw0cwKUtpzDLNgnCK2ikVUxKytaaLP+
 nOZHufdCPFDn68FFqAGvHVOTFbh461FXF+JHQNrFN07VxnuMhi7mwGmmHTmWIxb3DwgIHPNmXGN
 IZYoorpFBqUYWlkoDAKJzBL6zj5TUpzoxrLBWER33apg9RcjqEGmcy04BVkQ1lAsD60cNnxPWbn
 8
X-Received: by 2002:a05:6402:504d:b0:6a5:d6b5:cf80 with SMTP id
 4fb4d7f45d1cf-6a5df62099amr12557395a12.11.1787780393640; Wed, 26 Aug 2026
 14:39:53 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:52 -0500
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 16:39:52 -0500
From: Xinping Zhang <zhangxp1998@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
Date: Wed, 26 Aug 2026 16:39:52 -0500
X-Gm-Features: AcwNN1UjKRqo2AqQlvvf01g0D71uwgUFZX0PGdW4Pee1BMpqjid7-3LsLlmYLs4
Message-ID: <CAH=xXfHJvJ+GCgBDa33DpTXcanSW+DFwYh3NWq6EvfvH=fPEoA@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wzLLk-00026C-C6
Subject: [f2fs-dev] [PATCH 5/5] f2fs: describe inode node layout dynamically
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

An inode node block ends with its five i_nid entries followed by the node
footer. Because the i_addr array spans all preceding space, the offset of
i_nid depends on the filesystem block size.

Describe f2fs_inode and the direct and indirect node types with
maximum-size arrays, then calculate the locations of i_nid and the node
footer from the actual filesystem block size. Replace all direct accesses
to those tail fields with F2FS_INODE_NIDS() and F2FS_NODE_FOOTER().

Keep the former i_nid and footer declarations as comments documenting the
exact on-disk layout. This is a layout-only cleanup while the filesystem
block size is still fixed; the following change makes the helpers use the
runtime geometry.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/f2fs.h          | 30 ++++++++++++++++-------
 fs/f2fs/gc.c            |  2 +-
 fs/f2fs/inline.c        |  3 +--
 fs/f2fs/inode.c         |  5 ++--
 fs/f2fs/node.c          |  4 +---
 fs/f2fs/node.h          | 53 +++++++++++++++++++----------------------
 fs/f2fs/super.c         |  2 ++
 include/linux/f2fs_fs.h | 26 +++++++++++++++-----
 9 files changed, 74 insertions(+), 53 deletions(-)

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
index 026419aed2e9..1413aa7acc09 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1851,6 +1851,7 @@ struct f2fs_sb_info {
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
+	unsigned int addrs_per_inode;		/* addresses in an inode block */
 	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int orphans_per_block;	/* orphan inodes in a block */
 	unsigned int dentries_per_block;	/* dentries in a block */
@@ -2244,6 +2245,7 @@ static inline struct f2fs_sb_info
*F2FS_F_SB(const struct folio *folio)
 }

 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
+#define DEF_ADDRS_PER_INODE_SBI(sbi)	((sbi)->addrs_per_inode)
 #define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
 #define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
 					F2FS_ORPHANS_PER_BLOCK(sbi))
@@ -2293,6 +2295,12 @@ static inline struct f2fs_checkpoint
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
@@ -2303,6 +2311,12 @@ static inline struct f2fs_inode
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
@@ -3273,13 +3287,11 @@ static inline void
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
@@ -3288,9 +3300,11 @@ static inline int offset_in_addr(struct f2fs_inode *i)
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
@@ -3307,7 +3321,7 @@ static inline unsigned int get_dnode_base(struct
inode *inode,
 static inline __le32 *get_dnode_addr(struct inode *inode,
 					struct folio *node_folio)
 {
-	return blkaddr_in_node(F2FS_NODE(node_folio)) +
+	return blkaddr_in_node(node_folio) +
 			get_dnode_base(inode, node_folio);
 }

@@ -3635,7 +3649,7 @@ void *inline_xattr_addr(struct inode *inode,
const struct folio *folio)
 {
 	struct f2fs_inode *ri = F2FS_INODE(folio);

-	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
+	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE_SBI(F2FS_I_SB(inode)) -
 					get_inline_xattr_addrs(inode)]);
 }

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0c17038fcfd7..666acf9d528a 100644
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
index bac1e360d966..046cc21547eb 100644
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
index 968e5ed38816..3c8bb24e68b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2993,7 +2993,6 @@ int f2fs_recover_inode_page(struct f2fs_sb_info
*sbi, struct folio *folio)
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
-	struct f2fs_node *rn;
 	struct f2fs_summary *sum_entry;
 	block_t addr;
 	int i, idx, last_offset, nrpages;
@@ -3015,8 +3014,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			if (IS_ERR(folio))
 				return PTR_ERR(folio);

-			rn = F2FS_NODE(folio);
-			sum_entry->nid = rn->footer.nid;
+			sum_entry->nid = F2FS_NODE_FOOTER(folio)->nid;
 			sum_entry->version = 0;
 			sum_entry->ofs_in_node = 0;
 			sum_entry++;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5e114f352099..6e0097486e9b 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -242,73 +242,68 @@ static inline void set_to_next_nat(struct
f2fs_nm_info *nm_i, nid_t start_nid)

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
@@ -368,11 +363,12 @@ static inline bool IS_DNODE(const struct folio
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
@@ -381,9 +377,10 @@ static inline int set_nid(struct folio *folio,
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

@@ -396,8 +393,7 @@ static inline nid_t get_nid(const struct folio
*folio, int off, bool i)

 static inline int is_node(const struct folio *folio, int type)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	return le32_to_cpu(rn->footer.flag) & BIT(type);
+	return le32_to_cpu(F2FS_NODE_FOOTER(folio)->flag) & BIT(type);
 }

 #define is_cold_node(folio)	is_node(folio, COLD_BIT_SHIFT)
@@ -406,14 +402,13 @@ static inline int is_node(const struct folio
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
index 133c279b9931..1f6dcb890eab 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4348,6 +4348,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		le32_to_cpu(raw_super->log_sectors_per_block);
 	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
 	sbi->blocksize = BIT(sbi->log_blocksize);
+	sbi->addrs_per_inode = (sbi->blocksize - OFFSET_OF_END_OF_I_EXT -
+		SIZE_OF_I_NID - sizeof(struct node_footer)) / sizeof(__le32);
 	sbi->sit_entries_per_block = sbi->blocksize /
 		sizeof(struct f2fs_sit_entry);
 	sbi->orphans_per_block = (sbi->blocksize -
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index b4bb4e2f99b3..34c19bcd50e3 100644
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
+		__le32 i_addr[];		/* data block pointers */
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
+	__le32 addr[(F2FS_MAX_BLKSIZE - sizeof(struct node_footer)) /
+			sizeof(__le32)];	/* array of data block address */
 } __packed;

 struct indirect_node {
-	__le32 nid[NIDS_PER_BLOCK];	/* array of data block address */
+	__le32 nid[(F2FS_MAX_BLKSIZE - sizeof(struct node_footer)) /
+			sizeof(__le32)];	/* array of data block address */
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
