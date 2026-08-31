Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905C0C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:MIME-Version:References:In-Reply-To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NSNX4lG3/Z05qubj5ZQ3j/XuzKfIGKIof04t3zIVklw=; b=T/a9OwZGHkEugv50ja1nEVIa8C
	Qluqam1qdrZ7koabMug2DMNPFQxwEP4nu40liYoBX32FuTDGTzIby4GAvn8KGrFQPLjWGdMHchK7i
	AQ3FGunby+wIhU8YHxoDotaoFld+9ClO/4UKNvb0Sj8EBD1nbhnAD9rA0mxZb2EL2vJE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x15Ox-0004cn-FU;
	Mon, 31 Aug 2026 17:02:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x15Ow-0004cO-EU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:References:In-Reply-To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WvhIM3bw4Fo4g8EM6EjhZk/faYLf6d+8ugMbi89OSKo=; b=KOFiM2YzgdpXbNXscA+yLDlvSQ
 8SLGQ4zUfoabUt7nLpITpCCQnE6T6PyU0dEdawP8SvL0Mim8BJLyfMSqiggYuCKE81JzeGEzsZwZ5
 YAHSwaS/zAGnHtLVCI2oMMOiE8bmw933N5RmwuFk1Vvw5yDUWer/vsz4AddhQ43b24lY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:References:
 In-Reply-To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WvhIM3bw4Fo4g8EM6EjhZk/faYLf6d+8ugMbi89OSKo=; b=b+wQPdWnWRn4fq5ajKK4kT9OjN
 u0VjjfseQl/l7hkgn97QK+esBOkpBKm7TaQWye48gxSJBAxzPqTzA1b9e3FSji6MU6qFv8fnnUJ/E
 +rx5OOHoZ7Od7Nfd7qjRnRNV/T2W5+Nja1nTY0nysunv3HBhYu1WGzvRflnaGzhAeN70=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15Ov-0001PH-7I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:02:31 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c25344a8c6cso500515766b.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788195743; cv=none;
 d=google.com; s=arc-20260327;
 b=PE8ZyBLM/HkD4krmn1xOVax+CQb6Nm5NTILdZ+VB8cy4+uQ4/5wdU/PY6OhmZ18iAy
 iKxtTR9jdkHzVohMNXB6rdDKf5nffUTDGxK9CFQQA9iRc9INi+ns5fw8Z2FaaG1Eg+zO
 JMPdq8gaUzT+Eq4s3I+z78q/JZX1WThokGgGd/MGYD8YjK709pMCf3CRlQJNPjh8wQ4c
 N5S+LD88cIS7S5d275oAT+dctprk+k7nKZowDay8FqeULQnYMf/+sTNRTWc0Gl9/KaOv
 DTAX6e+uxz0yDTDXvpl/wkoksUHX8gauPyknrvf9C2VGjwq4pgcooJyhmHApkFP40gOS
 bdNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=WvhIM3bw4Fo4g8EM6EjhZk/faYLf6d+8ugMbi89OSKo=;
 fh=xQlrTCtbZS9AeHiZIznQSf0O/ILYiLS8eBp4kjanibk=;
 b=HRFCzhqK2G7nfDZFV30mHF/IfP5ErvP9L/V2yLDGvDgSRpBirhGaEzPsCDOjaZSITj
 Vgz6zhQDN5ANWcrngYSzLhq9NdX0PS96J6pbDef/pVDyyetDC6uOVL6TQoPDnwzTGsmq
 pCt1jRUd9t2fi07dfIzG20OQQgJcGIGAmDZOaD+j701LEi9/e91MDJypvQwbm3ufLKaQ
 HuNuwZdBdH5o6Snw4gyf9PXh7+rzmU36I/HlifMbv/vqJNtSEm5mNr52VCiC/DvopJmX
 /enjYsWlJElOlmyTu0RiGpypXjFDDd7kT9eq3Gd49OkpPCPh2CFzCOOIQ4rxtYRvhW87
 y78Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788195743; x=1788800543; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WvhIM3bw4Fo4g8EM6EjhZk/faYLf6d+8ugMbi89OSKo=;
 b=SRU0lei7rItc0SylX8OKO8qYv3oW3882rBeyQJQMVPm8N7qiIAG1hYrElmjXvzsDO9
 RXR+9Bq3losfaudsu1ov8zOvj+NmEMvH+2eUfACQ2isVL9BhvYq5VgQh6ng50Ad9MRjY
 mHoYUIG2pVXqEG0lU458S4bXlgZcc0+fXpJXK0Um+VPWHSZi/YV1w4uLqVcqo8glqlXs
 Jb+Obbhm1ZxBUUG0B37zIlgqP4ahSXfJnez5G57+sZ1eE0S5SXxmZjuvpfxo+PK3kimM
 dlrZidre7ZhKHevhvO+yWv5HKWjfHIMj/WG6jS1HHDukj3wu8IGaWmMuUJnnIfyelmXb
 5C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788195743; x=1788800543;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WvhIM3bw4Fo4g8EM6EjhZk/faYLf6d+8ugMbi89OSKo=;
 b=CFI3dBRlkPxLYtfASNJ0hT/MiwwcNkwpZjK+IYZzConUqyzz1JwURcyrYyrcewogW4
 gxfdJVUhAZpZkoAAwscRDYmpvZyzj+XHjJNLiAaucaoZ7JSWsLAgLmGd9PWidUtFRdrO
 UuCpgdUPdssJmTo6Hy5fZYAP+Ko+86GGe6q4lm7PPeOoXZGKJqVA0fO1dlV9sT5t40UZ
 rcaxF6RUavzT/HeJEbLCa9grfGl5OnFLF8IMDfAuG96f3XMfnFpk96c/xBsysD0M/z61
 KX72ZxcHxOTziRHEUurxAWoV0CYCLIkVjFMdmxfRUNFRwgLwj+o2//tX+MumJBYTfPT0
 loog==
X-Gm-Message-State: AFuF++ntXU6N9GpfhgqU5/CKZtx+9H0VCS4g65Qo7YC2s7YnXuf1hBAD
 tEdxktuOcrC8/MfKOryoHEr685Ygl8t/pe8KqwgLOV4gvNaZbj92Napr038eiH7hawwz8FiHWvU
 vxRjkeka1RW8NpJBCkK9sa3MaGEQDXFzpoqsNigs=
X-Gm-Gg: AR+sD1230jMULnXnw+4AcuWGHYJ06fcqTx02UES/ccqH49M1I/pSdKUuobFfqDfIYa/
 70jz03nOUoYc3MPtfM+PJCgcmS/0IpNnz0/dpJ58t7BkcZP0EAhQd/2b6xxAXVdojvV2LE9A+5s
 /ppkxnce5HeLeTvGuRDVBK5WrNRTEx2hKqY/mnRKqqHUYQ7Yp6f2Jt7Pla3aB5DN3yH7ZGtQmZJ
 AZpd2/stYasrjYlJALVm8OvVuo3WkeSUB5s1YPX0iA2HyqPa9xaz1CLgD9EhZqcebfrFG2lVDTu
 cqQvn+xQMvW5FcKIOR+vQ0NlDWtSikc6VTTi4U8FjwF6osvviQHvRyAvUyZY7AOfAqZ9+MaLM4S
 xCA==
X-Received: by 2002:a17:907:980e:b0:c20:f529:2d6a with SMTP id
 a640c23a62f3a-c255721317amr1693587066b.22.1788195742453; Mon, 31 Aug 2026
 10:02:22 -0700 (PDT)
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:21 +0200
Received: from 637551599889 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 19:02:21 +0200
From: Kelvin Zhang <zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
References: <CAH=xXfHWPg6qRwW+N2ziH1cvG3OD3wJc1z_Tm04MtFCpqYmQFg@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 19:02:21 +0200
X-Gm-Features: AcwNN1VKnWhuzGOv7GbMx63Dwu2Rj8xebPxCeY1ePVbxGZYUkMWDcykRGNNEDUI
Message-ID: <CAH=xXfFmvEg+Gy1aV_2136EAE+60X46j-wupbh5aY9eoyYF2PQ@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x15Ov-0001PH-7I
Subject: [f2fs-dev] [PATCH v4 11/11] f2fs: describe node tree geometry
 dynamically
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

The file indexing tree boundaries separating direct, indirect, and
double-indirect node blocks depend on the number of data block addresses
and node IDs contained in each node block.

Parameterize index boundary macros (NODE_DIR1_BLOCK,
NODE_DIR2_BLOCK, NODE_IND1_BLOCK, NODE_IND2_BLOCK, and NODE_DIND_BLOCK) and
address capacity helpers (DEF_ADDRS_PER_BLOCK, NIDS_PER_BLOCK,
cur_addrs_per_inode, addrs_per_page, and addrs_per_folio) with
struct f2fs_sb_info *sbi.

Update file mapping, block allocation, truncate, garbage collection,
and recovery paths to compute indexing tree offsets from the runtime
geometry.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/f2fs.h          | 19 +++++++++--
 fs/f2fs/gc.c            | 10 +++---
 fs/f2fs/node.c          | 74 +++++++++++++++++++++--------------------
 fs/f2fs/node.h          | 18 ++++++----
 fs/f2fs/super.c         |  6 ++--
 include/linux/f2fs_fs.h | 18 ++--------
 6 files changed, 77 insertions(+), 68 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f83cdab66f54..e1f33ac24c6e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -602,8 +602,12 @@ static inline int update_sits_in_cursum(struct
f2fs_journal *journal, int i)
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
+static inline unsigned int cur_addrs_per_inode(struct inode *inode)
+{
+	return DEF_ADDRS_PER_INODE(inode) - get_extra_isize(inode);
+}
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
-				(CUR_ADDRS_PER_INODE(inode) -		\
+				(cur_addrs_per_inode(inode) -		\
 				get_inline_xattr_addrs(inode) -	\
 				DEF_INLINE_RESERVED_SIZE))

@@ -2257,11 +2261,19 @@ static inline struct f2fs_sb_info
*F2FS_P_SB(struct page *page)
 #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
 #define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
 #define DEF_ADDRS_PER_INODE_SBI(sbi)	((sbi)->addrs_per_inode)
+#define DEF_ADDRS_PER_BLOCK(sbi)	((sbi)->addrs_per_block)
+#define NIDS_PER_BLOCK(sbi)		((sbi)->nids_per_block)
 #define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
 #define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
 					F2FS_ORPHANS_PER_BLOCK(sbi))
 #define CP_CHKSUM_OFFSET(sbi)		(F2FS_BLKSIZE(sbi) - sizeof(__le32))

+#define NODE_DIR1_BLOCK(sbi)		(DEF_ADDRS_PER_INODE_SBI(sbi) + 1)
+#define NODE_DIR2_BLOCK(sbi)		(DEF_ADDRS_PER_INODE_SBI(sbi) + 2)
+#define NODE_IND1_BLOCK(sbi)		(DEF_ADDRS_PER_INODE_SBI(sbi) + 3)
+#define NODE_IND2_BLOCK(sbi)		(DEF_ADDRS_PER_INODE_SBI(sbi) + 4)
+#define NODE_DIND_BLOCK(sbi)		(DEF_ADDRS_PER_INODE_SBI(sbi) + 5)
+
 static inline struct f2fs_orphan_footer *
 f2fs_orphan_footer(void *orphan_block, struct f2fs_sb_info *sbi)
 {
@@ -3650,8 +3662,9 @@ static inline bool
f2fs_need_compress_data(struct inode *inode)
 static inline unsigned int addrs_per_page(struct inode *inode,
 							bool is_inode)
 {
-	unsigned int addrs = is_inode ? (CUR_ADDRS_PER_INODE(inode) -
-			get_inline_xattr_addrs(inode)) : DEF_ADDRS_PER_BLOCK;
+	unsigned int addrs = is_inode ? (cur_addrs_per_inode(inode) -
+			get_inline_xattr_addrs(inode)) :
+			DEF_ADDRS_PER_BLOCK(F2FS_I_SB(inode));

 	if (f2fs_compressed_file(inode))
 		return ALIGN_DOWN(addrs, F2FS_I(inode)->i_cluster_size);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 299d5310e597..b17e7ce58f2c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1123,7 +1123,8 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
  */
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 {
-	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK(sbi) + 4;
 	unsigned int bidx;

 	if (node_ofs == 0)
@@ -1132,11 +1133,12 @@ block_t f2fs_start_bidx_of_node(unsigned int
node_ofs, struct inode *inode)
 	if (node_ofs <= 2) {
 		bidx = node_ofs - 1;
 	} else if (node_ofs <= indirect_blks) {
-		int dec = (node_ofs - 4) / (NIDS_PER_BLOCK + 1);
+		int dec = (node_ofs - 4) / (NIDS_PER_BLOCK(sbi) + 1);

 		bidx = node_ofs - 2 - dec;
 	} else {
-		int dec = (node_ofs - indirect_blks - 3) / (NIDS_PER_BLOCK + 1);
+		int dec = (node_ofs - indirect_blks - 3) /
+			(NIDS_PER_BLOCK(sbi) + 1);

 		bidx = node_ofs - 5 - dec;
 	}
@@ -1179,7 +1181,7 @@ static bool is_alive(struct f2fs_sb_info *sbi,
struct f2fs_summary *sum,
 		max_addrs = DEF_ADDRS_PER_INODE_SBI(sbi);
 	} else {
 		base = 0;
-		max_addrs = DEF_ADDRS_PER_BLOCK;
+		max_addrs = DEF_ADDRS_PER_BLOCK(sbi);
 	}

 	if (base + ofs_in_node >= max_addrs) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8d16715a3aae..68a95d703c4a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -691,7 +691,7 @@ static void f2fs_ra_node_pages(struct folio
*parent, int start, int n)

 	/* Then, try readahead for siblings of the desired node */
 	end = start + n;
-	end = min(end, (int)NIDS_PER_BLOCK);
+	end = min_t(int, end, NIDS_PER_BLOCK(sbi));
 	for (i = start; i < end; i++) {
 		nid = get_nid(parent, i, false);
 		f2fs_ra_node_page(sbi, nid);
@@ -702,9 +702,11 @@ static void f2fs_ra_node_pages(struct folio
*parent, int start, int n)

 pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	const long direct_index = ADDRS_PER_INODE(dn->inode);
 	const long direct_blks = ADDRS_PER_BLOCK(dn->inode);
-	const long indirect_blks = ADDRS_PER_BLOCK(dn->inode) * NIDS_PER_BLOCK;
+	const long indirect_blks = ADDRS_PER_BLOCK(dn->inode) *
+		NIDS_PER_BLOCK(sbi);
 	unsigned int skipped_unit = ADDRS_PER_BLOCK(dn->inode);
 	int cur_level = dn->cur_level;
 	int max_level = dn->max_level;
@@ -714,7 +716,7 @@ pgoff_t f2fs_get_next_page_offset(struct
dnode_of_data *dn, pgoff_t pgofs)
 		return pgofs + 1;

 	while (max_level-- > cur_level)
-		skipped_unit *= NIDS_PER_BLOCK;
+		skipped_unit *= NIDS_PER_BLOCK(sbi);

 	switch (dn->max_level) {
 	case 3:
@@ -740,11 +742,13 @@ pgoff_t f2fs_get_next_page_offset(struct
dnode_of_data *dn, pgoff_t pgofs)
 static int get_node_path(struct inode *inode, long block,
 				int offset[4], unsigned int noffset[4])
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const long direct_index = ADDRS_PER_INODE(inode);
 	const long direct_blks = ADDRS_PER_BLOCK(inode);
-	const long dptrs_per_blk = NIDS_PER_BLOCK;
-	const long indirect_blks = ADDRS_PER_BLOCK(inode) * NIDS_PER_BLOCK;
-	const long dindirect_blks = indirect_blks * NIDS_PER_BLOCK;
+	const long dptrs_per_blk = NIDS_PER_BLOCK(sbi);
+	const long indirect_blks = ADDRS_PER_BLOCK(inode) *
+		NIDS_PER_BLOCK(sbi);
+	const long dindirect_blks = indirect_blks * NIDS_PER_BLOCK(sbi);
 	int n = 0;
 	int level = 0;

@@ -756,7 +760,7 @@ static int get_node_path(struct inode *inode, long block,
 	}
 	block -= direct_index;
 	if (block < direct_blks) {
-		offset[n++] = NODE_DIR1_BLOCK;
+		offset[n++] = NODE_DIR1_BLOCK(sbi);
 		noffset[n] = 1;
 		offset[n] = block;
 		level = 1;
@@ -764,7 +768,7 @@ static int get_node_path(struct inode *inode, long block,
 	}
 	block -= direct_blks;
 	if (block < direct_blks) {
-		offset[n++] = NODE_DIR2_BLOCK;
+		offset[n++] = NODE_DIR2_BLOCK(sbi);
 		noffset[n] = 2;
 		offset[n] = block;
 		level = 1;
@@ -772,7 +776,7 @@ static int get_node_path(struct inode *inode, long block,
 	}
 	block -= direct_blks;
 	if (block < indirect_blks) {
-		offset[n++] = NODE_IND1_BLOCK;
+		offset[n++] = NODE_IND1_BLOCK(sbi);
 		noffset[n] = 3;
 		offset[n++] = block / direct_blks;
 		noffset[n] = 4 + offset[n - 1];
@@ -782,7 +786,7 @@ static int get_node_path(struct inode *inode, long block,
 	}
 	block -= indirect_blks;
 	if (block < indirect_blks) {
-		offset[n++] = NODE_IND2_BLOCK;
+		offset[n++] = NODE_IND2_BLOCK(sbi);
 		noffset[n] = 4 + dptrs_per_blk;
 		offset[n++] = block / direct_blks;
 		noffset[n] = 5 + dptrs_per_blk + offset[n - 1];
@@ -792,7 +796,7 @@ static int get_node_path(struct inode *inode, long block,
 	}
 	block -= indirect_blks;
 	if (block < dindirect_blks) {
-		offset[n++] = NODE_DIND_BLOCK;
+		offset[n++] = NODE_DIND_BLOCK(sbi);
 		noffset[n] = 5 + (dptrs_per_blk * 2);
 		offset[n++] = block / indirect_blks;
 		noffset[n] = 6 + (dptrs_per_blk * 2) +
@@ -1054,6 +1058,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 						int ofs, int depth)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct dnode_of_data rdn = *dn;
 	struct folio *folio;
 	struct f2fs_node *rn;
@@ -1063,7 +1068,7 @@ static int truncate_nodes(struct dnode_of_data
*dn, unsigned int nofs,
 	int i, ret;

 	if (dn->nid == 0)
-		return NIDS_PER_BLOCK + 1;
+		return NIDS_PER_BLOCK(sbi) + 1;

 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);

@@ -1074,11 +1079,11 @@ static int truncate_nodes(struct dnode_of_data
*dn, unsigned int nofs,
 		return PTR_ERR(folio);
 	}

-	f2fs_ra_node_pages(folio, ofs, NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(folio, ofs, NIDS_PER_BLOCK(sbi));

 	rn = F2FS_NODE(folio);
 	if (depth < 3) {
-		for (i = ofs; i < NIDS_PER_BLOCK; i++, freed++) {
+		for (i = ofs; i < NIDS_PER_BLOCK(sbi); i++, freed++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
 			if (child_nid == 0)
 				continue;
@@ -1090,16 +1095,16 @@ static int truncate_nodes(struct dnode_of_data
*dn, unsigned int nofs,
 				dn->node_changed = true;
 		}
 	} else {
-		child_nofs = nofs + ofs * (NIDS_PER_BLOCK + 1) + 1;
-		for (i = ofs; i < NIDS_PER_BLOCK; i++) {
+		child_nofs = nofs + ofs * (NIDS_PER_BLOCK(sbi) + 1) + 1;
+		for (i = ofs; i < NIDS_PER_BLOCK(sbi); i++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
 			if (child_nid == 0) {
-				child_nofs += NIDS_PER_BLOCK + 1;
+				child_nofs += NIDS_PER_BLOCK(sbi) + 1;
 				continue;
 			}
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
-			if (ret == (NIDS_PER_BLOCK + 1)) {
+			if (ret == (NIDS_PER_BLOCK(sbi) + 1)) {
 				if (set_nid(folio, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
@@ -1156,10 +1161,12 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
 		nid[i + 1] = get_nid(folios[i], offset[i + 1], false);
 	}

-	f2fs_ra_node_pages(folios[idx], offset[idx + 1], NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(folios[idx], offset[idx + 1],
+			   NIDS_PER_BLOCK(F2FS_I_SB(dn->inode)));

 	/* free direct nodes linked to a partial indirect node */
-	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
+	for (i = offset[idx + 1];
+			i < NIDS_PER_BLOCK(F2FS_I_SB(dn->inode)); i++) {
 		child_nid = get_nid(folios[idx], i, false);
 		if (!child_nid)
 			continue;
@@ -1193,7 +1200,9 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
 }

 /*
- * All the block addresses of data and nodes should be nullified.
+ * All the node blocks actually belong to the inode will be released.
+ * If the level is 0, we will simply truncate the dnode,
+ * or else we should do dynamic truncate for the node pointers with the depth.
  */
 int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 {
@@ -1240,10 +1249,10 @@ int f2fs_truncate_inode_blocks(struct inode
*inode, pgoff_t from)
 		err = truncate_partial_nodes(&dn, offset, level);
 		if (err < 0 && err != -ENOENT)
 			goto fail;
-		nofs += 1 + NIDS_PER_BLOCK;
+		nofs += 1 + NIDS_PER_BLOCK(sbi);
 		break;
 	case 3:
-		nofs = 5 + 2 * NIDS_PER_BLOCK;
+		nofs = 5 + 2 * NIDS_PER_BLOCK(sbi);
 		if (!offset[level - 1])
 			goto skip_partial;
 		err = truncate_partial_nodes(&dn, offset, level);
@@ -1257,23 +1266,16 @@ int f2fs_truncate_inode_blocks(struct inode
*inode, pgoff_t from)
 skip_partial:
 	while (cont) {
 		dn.nid = get_nid(folio, offset[0], true);
-		switch (offset[0]) {
-		case NODE_DIR1_BLOCK:
-		case NODE_DIR2_BLOCK:
+		if (offset[0] == NODE_DIR1_BLOCK(sbi) ||
+		    offset[0] == NODE_DIR2_BLOCK(sbi)) {
 			err = truncate_dnode(&dn);
-			break;
-
-		case NODE_IND1_BLOCK:
-		case NODE_IND2_BLOCK:
+		} else if (offset[0] == NODE_IND1_BLOCK(sbi) ||
+				offset[0] == NODE_IND2_BLOCK(sbi)) {
 			err = truncate_nodes(&dn, nofs, offset[1], 2);
-			break;
-
-		case NODE_DIND_BLOCK:
+		} else if (offset[0] == NODE_DIND_BLOCK(sbi)) {
 			err = truncate_nodes(&dn, nofs, offset[1], 3);
 			cont = 0;
-			break;
-
-		default:
+		} else {
 			BUG();
 		}
 		if (err == -ENOENT) {
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 32125f8fc753..66898288b961 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -354,17 +354,18 @@ static inline bool is_recoverable_dnode(const
struct folio *folio)
  */
 static inline bool IS_DNODE(const struct folio *node_folio)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(node_folio);
 	unsigned int ofs = ofs_of_node(node_folio);

 	if (f2fs_has_xattr_block(ofs))
 		return true;

-	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
-			ofs == 5 + 2 * NIDS_PER_BLOCK)
+	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK(sbi) ||
+	    ofs == 5 + 2 * NIDS_PER_BLOCK(sbi))
 		return false;
-	if (ofs >= 6 + 2 * NIDS_PER_BLOCK) {
-		ofs -= 6 + 2 * NIDS_PER_BLOCK;
-		if (!((long int)ofs % (NIDS_PER_BLOCK + 1)))
+	if (ofs >= 6 + 2 * NIDS_PER_BLOCK(sbi)) {
+		ofs -= 6 + 2 * NIDS_PER_BLOCK(sbi);
+		if (!((long)ofs % (NIDS_PER_BLOCK(sbi) + 1)))
 			return false;
 	}
 	return true;
@@ -372,13 +373,15 @@ static inline bool IS_DNODE(const struct folio
*node_folio)

 static inline int set_nid(struct folio *folio, int off, nid_t nid, bool i)
 {
+	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_node *rn = F2FS_NODE(folio);
 	__le32 *inode_nids = F2FS_INODE_NIDS(folio);

 	f2fs_folio_wait_writeback(folio, NODE, true, true);

 	if (i)
-		inode_nids[off - NODE_DIR1_BLOCK] = cpu_to_le32(nid);
+		inode_nids[off - NODE_DIR1_BLOCK(sbi)] =
+			cpu_to_le32(nid);
 	else
 		rn->in.nid[off] = cpu_to_le32(nid);
 	return folio_mark_dirty(folio);
@@ -388,9 +391,10 @@ static inline nid_t get_nid(const struct folio
*folio, int off, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
 	const __le32 *inode_nids = F2FS_INODE_NIDS(folio);
+	int nid_index = off - NODE_DIR1_BLOCK(F2FS_F_SB(folio));

 	if (i)
-		return le32_to_cpu(inode_nids[off - NODE_DIR1_BLOCK]);
+		return le32_to_cpu(inode_nids[nid_index]);
 	return le32_to_cpu(rn->in.nid[off]);
 }

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ca6403a0ed88..f6c492f76f0c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3899,17 +3899,17 @@ loff_t max_file_blocks(struct f2fs_sb_info
*sbi, struct inode *inode)
 	if (inode && f2fs_compressed_file(inode))
 		leaf_count = ADDRS_PER_BLOCK(inode);
 	else
-		leaf_count = DEF_ADDRS_PER_BLOCK;
+		leaf_count = DEF_ADDRS_PER_BLOCK(sbi);

 	/* two direct node blocks */
 	result += (leaf_count * 2);

 	/* two indirect node blocks */
-	leaf_count *= NIDS_PER_BLOCK;
+	leaf_count *= NIDS_PER_BLOCK(sbi);
 	result += (leaf_count * 2);

 	/* one double indirect node block */
-	leaf_count *= NIDS_PER_BLOCK;
+	leaf_count *= NIDS_PER_BLOCK(sbi);
 	result += leaf_count;

 	/*
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 957bb713ff24..e43ac6509550 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -271,27 +271,15 @@ struct node_footer {
 } __packed;

 /* Address Pointers in an Inode */
-#define DEF_ADDRS_PER_INODE	((PAGE_SIZE - OFFSET_OF_END_OF_I_EXT	\
-					- SIZE_OF_I_NID	\
-					- sizeof(struct node_footer)) / sizeof(__le32))
-#define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
-					get_extra_isize(inode))
+#define DEF_ADDRS_PER_INODE(inode) \
+	((i_blocksize(inode) - OFFSET_OF_END_OF_I_EXT - SIZE_OF_I_NID - \
+	  sizeof(struct node_footer)) / sizeof(__le32))
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define ADDRS_PER_INODE(inode)	addrs_per_page(inode, true)
 /* Address Pointers in a Direct Block */
-#define DEF_ADDRS_PER_BLOCK	((PAGE_SIZE - sizeof(struct node_footer))
/ sizeof(__le32))
 #define ADDRS_PER_BLOCK(inode)	addrs_per_page(inode, false)
-/* Node IDs in an Indirect Block */
-#define NIDS_PER_BLOCK		((PAGE_SIZE - sizeof(struct node_footer)) /
sizeof(__le32))
-
 #define ADDRS_PER_PAGE(folio, inode)	(addrs_per_page(inode, IS_INODE(folio)))

-#define	NODE_DIR1_BLOCK		(DEF_ADDRS_PER_INODE + 1)
-#define	NODE_DIR2_BLOCK		(DEF_ADDRS_PER_INODE + 2)
-#define	NODE_IND1_BLOCK		(DEF_ADDRS_PER_INODE + 3)
-#define	NODE_IND2_BLOCK		(DEF_ADDRS_PER_INODE + 4)
-#define	NODE_DIND_BLOCK		(DEF_ADDRS_PER_INODE + 5)
-
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
 #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
