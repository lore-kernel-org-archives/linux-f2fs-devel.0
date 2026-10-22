Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E48A606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bb6um1b5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TLvEhEvb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ILP3ZkWh;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IrRbeS1n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4J22RcEAUPvupAGa5L0dhNnchuVQQxWbPVy/n4M2XfE=; b=bb6um1b5/kXUeuX5UL1o/lo5rI
	0QUPMtq91tebReL+9JTcLyyQy0M3HjwgqI2nDr96KmcJMM1TM+TrMbi19cRZj+miWplFBqcR6tyS6
	b0Z6eX/eHsEaRFz4ZR8nJi+pC1LueA2d2ptsyfiF5ruVbcy7XfFWB18GQYmEvjq5Yz9c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndZ-000000008DW-3Zbb;
	Thu, 22 Oct 2026 07:54:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndY-000000008DN-1if9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m7Q7KrqKTgzsyXWYTLXb+HgkSh3Yf95tMI/2ie5hxYU=; b=TLvEhEvb+0klgEznPX4Bvzns1I
 ZdGhHy7NrpIqYIZHew1aTlydIcDA/O1+sX8Vi78HrlB4Z5tI2MPFvB4FL/DowPeDZ5GePC2r3rdHj
 do/YlKbHl4Skej1MfN2/uKnNvk7J28uz5bZKfD764m3AF9InREec2I+D4PFf2oxJ3zx0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m7Q7KrqKTgzsyXWYTLXb+HgkSh3Yf95tMI/2ie5hxYU=; b=ILP3ZkWhaGKJFqX1vXf5XakUrD
 /I1BAMiv7Pl7tl8hEx+9Uz0c0mveJX031T689H/E2MouwigdV74vlMpIS1fkvqUaNNYBvzlYaNKrZ
 N3s0AMP/fzcOEwEPBPoV366lE565PZWLRibZBdX56iR39ov2nBavuYyGu5Z4jxfXefuU=;
Received: from mail-pj2-f7.google.com ([74.125.227.135])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndX-0000000051j-0fSL
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:56 +0000
Received: by mail-pj2-f7.google.com with SMTP id
 98e67ed59e1d1-3ac5f801d7cso424770a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655689; x=1793260489; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7Q7KrqKTgzsyXWYTLXb+HgkSh3Yf95tMI/2ie5hxYU=;
 b=IrRbeS1n4WqW01PrKh1EQLWBVz+8tc3Dzoz+Kpq4sEZ/yYLYWjM0Zb48mgiw8NYqST
 6UYFp8jD9uNh4/xtQ8HXahDPwvbNCyi3GVOLtisXleqh+338bSG5IHYbS8JKCHhSWUwx
 O5I1FigMHSL1wkFhTFXCDwI793WrPuvlVLix+CcQqG7KlExSFO7Z2KFb95ySmzkmWYtl
 snKub/jHUBYNVpULpnA+1UfQB1puw1I5wHb4BPGhLJ3+j50CR3HryLaywvm5Mkm7A0t0
 J99AATdMOKONrfL5mXJDXWHO22zxYye37+xSRb54gAYrSikCQrbzdLwdGoj0+Hz62Mwm
 dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655689; x=1793260489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m7Q7KrqKTgzsyXWYTLXb+HgkSh3Yf95tMI/2ie5hxYU=;
 b=OqXR9BcCZYrrHdc4aY3GwiVLud3/Hu6DsF3D7e/WVSpC8979OHq7cF0PM153sxIFll
 tD3Fa8mfZEwTMKZ9VkzfnOK9cUWFHL6jIa3Z/R+2ZEzX33IBS93FnrfV3PZW/avLgj7B
 kOWL2ZvArNC85msPyZAQYeVcPm7YQOk05voOIAJaPlVi1YvD5KBvXHZecdah30/QVx85
 tu2zw1KmiFn5ew7/9KEzjfvJt7ipq7t1GgmCQOBnFqMJsMCO8pnWOWX9ZKKbLGXYHQZN
 Cqor5hHO2a5vpLLILYUg5ZP/okjyGg7YDAc/SvQrZJku5PVvRY0xXwseOXhag2IAm/0n
 j9oQ==
X-Gm-Message-State: AFq9FYJubHrNUgHq45dfWCnF+AtC/HSZF5ASvZgN538ICLMFhgD6mJIG
 rWI8fLOKpSCc1LMc3+qZi1/1n/QurIbACPExOiuhuNQLby8++aEPoKaPdezsPKLV6WU=
X-Gm-Gg: AYBFou1gTfZ9GJiLN8RSOa8Gk5AsSi8szztMtYFne7MViZmkf76+VVGpOGoAGWmf3Mg
 iNstKCUKiOz4vZSX0ddU4JMQXMNXPDOd1UfEcM27vRbieEGyFdOekRRmWUyC+OAwkMM8I3n57cY
 scExFGc2Bsqh68KwEZWs+Q2hrFg7rQOqJTPT3WqivmAvdTX2qPXuFMXaW05L6jBsL9HvlCtf2jo
 5b9uOVbEjxuy+RikiQwcFAJS3NnteZNqaDAIxrcxANE4X5i2mnB2dENe0okXCY/UvfVohqX/r73
 oldkNCYFDmqtHesb0HDxtabPSuJE5ZR79jHmLGGUErxl87/TGjxo4xTng4nP8KvOo0I99gZ3Skb
 TJjiSFYqXZqL4XoAloGRRrsv4hJYMfogWgM1bh1HC+NcyPWZhbT+aH78+fbWkDs0u/mQhgbSwyv
 2tnlYig+IpsIE6lrjwi1Mnv9wEh57nH1Wv0VOthUK5kV4OsD0n8P7tQIw75kA+VDDz8++WHF49m
 Q3D1CqagX9haAmIQXYJxCHpzpbfX00LyWiyrCYvNrUpmQBKDzShp7oplsLHOgxUpVsMTVPKRdBl
 e2la7fSJX7FENNtYzw==
X-Received: by 2002:a17:90b:1d43:b0:3ab:2737:3392 with SMTP id
 98e67ed59e1d1-3ad86d4e4d1mr3616837a91.53.1792655689458; 
 Thu, 22 Oct 2026 00:54:49 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:49 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:41 +0800
Message-ID: <20261022075343.3043003-15-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndX-0000000051j-0fSL
Subject: [f2fs-dev] [PATCH v6 14/15] f2fs: allow large folio support to
 writeable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Now we make all write path support large folios,
so we open permission to let writeable file set
large folio mapping.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   | 17 +++++++++++++++++
 fs/f2fs/file.c   | 16 +---------------
 fs/f2fs/inline.c |  6 ++++++
 fs/f2fs/inode.c  |  4 +---
 fs/f2fs/namei.c  |  1 +
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f71fb7c993ef..2338450ce031 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3266,7 +3266,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode)) {
 		if (folio)
 			folio_unlock(folio);
 		return -EOPNOTSUPP;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c9343eb6b5e..53914629c604 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5348,6 +5348,23 @@ static inline bool f2fs_quota_file(struct f2fs_sb_info *sbi, nid_t ino)
 	return false;
 }
 
+static inline void f2fs_mapping_set_large_folio(struct inode *inode)
+{
+	if (!S_ISREG(inode->i_mode) ||
+	    f2fs_compressed_file(inode) ||
+	    f2fs_quota_file(F2FS_I_SB(inode), inode->i_ino))
+		return;
+
+	/*
+	 * Keep the folio order range at 0 as a transitional step; large
+	 * folios will be enabled once the whole write path is audited.
+	 */
+	if (IS_IMMUTABLE(inode))
+		mapping_set_folio_min_order(inode->i_mapping, 0);
+	else
+		mapping_set_folio_order_range(inode->i_mapping, 0, 0);
+}
+
 static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 {
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f621d5e65023..3d621a20766d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -163,17 +163,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	int err = 0;
 	vm_fault_t ret;
 
-	/*
-	 * We only support large folio on the read case.
-	 * Don't make any dirty pages.
-	 */
-	if (unlikely(IS_IMMUTABLE(inode)) ||
-	    mapping_large_folio_support(inode->i_mapping)) {
-		f2fs_err(sbi, "Not expected: immutable: %d large_folio: %d",
-				IS_IMMUTABLE(inode),
-				mapping_large_folio_support(inode->i_mapping));
+	if (unlikely(IS_IMMUTABLE(inode)))
 		return VM_FAULT_SIGBUS;
-	}
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
@@ -720,9 +711,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
@@ -1194,8 +1182,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return -EPERM;
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
-		if (mapping_large_folio_support(inode->i_mapping))
-			return -EOPNOTSUPP;
 		if (IS_DEVICE_ALIASING(inode))
 			return -EPERM;
 		if (!f2fs_is_compress_backend_ready(inode))
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 49905aa08418..0dca6c3d58fb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -239,6 +239,12 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	/*
+	 * Inline data is only supported in an order-0 index #0 folio; the
+	 * inline write and mmap fault paths never request a larger order.
+	 */
+	f2fs_bug_on(sbi, folio_test_large(folio));
+
 	f2fs_lock_op(sbi, &lc);
 
 	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9164a2b5d9f0..f5a4dac98ef2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -599,9 +599,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &f2fs_file_inode_operations;
 		inode->i_fop = &f2fs_file_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		if (IS_IMMUTABLE(inode) && !f2fs_compressed_file(inode) &&
-		    !f2fs_quota_file(sbi, inode->i_ino))
-			mapping_set_folio_min_order(inode->i_mapping, 0);
+		f2fs_mapping_set_large_folio(inode);
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 38fcea8b72bf..6a1ff631393c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -341,6 +341,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 	f2fs_set_inode_flags(inode);
 
 	f2fs_init_extent_tree(inode);
+	f2fs_mapping_set_large_folio(inode);
 
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
