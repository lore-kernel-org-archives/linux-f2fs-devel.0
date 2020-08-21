Return-Path: <SRS0=Tg9B=B7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC0C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:17:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8602F22B40;
	Fri, 21 Aug 2020 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZmGF2aLS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GS4b9py/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ+KQXD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8602F22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k99je-0003Uf-FX; Fri, 21 Aug 2020 16:17:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1k99jc-0003U8-84
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 16:17:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4H5KZpR8KU1W16OFNK9aZ+NET4wL0fNf3IX8Z57Lzdg=; b=ZmGF2aLSx8OLxE8jqTkQ3ONlJZ
 SY6zKRCreGISXrqoNVCzMDJ096HGIqwF02PYnGEJRas8QALO11uCRBLY0BEFsBct42Sk91cQIL6W8
 tXTNPClN98z9PaVBzQnnsOBlct/7CMX0K9czbC+UafEaiVoK6vObJImloBUD17u1laZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4H5KZpR8KU1W16OFNK9aZ+NET4wL0fNf3IX8Z57Lzdg=; b=GS4b9py/b5FWrRfkRSyYmiBGD5
 55mS+CRWrEPBAnGkBDG0GkbhN/U/PTxyGNHGC/H2RnfZhbE+MGGmM7UJVgGolPLm6MXDMrMuu3Yw8
 P1oOdQskOI925qmpc+tG+dfo3EBftRxdapX9MatFmgshwSjsrLggDJzyXTu3YYcwgQ8Y=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k99ja-003Hzc-TN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 16:17:44 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CBD0022CBB;
 Fri, 21 Aug 2020 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598026657;
 bh=bkRavVFpTPtA7mxRw6h58U2ccbQ4OPkXmakbbWJKE7Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jZ+KQXD/hlA67u6+noox3eQhN/6zwKlEnqgyTy662A/xWdDEOmmeW0lK8sKh3qKDn
 dc2nh5Pv5/4G1yc3TD00HY9kyqYWm7kdcaZEX1OOdZIRTMaCeYmEqYkBQIlinkiS4M
 MsY6U8ghNB84lvw3mxzPqKcF+T5ADPAzS2cB2ufM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 21 Aug 2020 12:16:42 -0400
Message-Id: <20200821161704.348164-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161704.348164-1-sashal@kernel.org>
References: <20200821161704.348164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1k99ja-003Hzc-TN
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 26/48] f2fs: fix error path in
 do_recover_data()
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 9627a7b31f3c4ff8bc8f3be3683983ffe6eaebe6 ]

- don't panic kernel if f2fs_get_node_page() fails in
f2fs_recover_inline_data() or f2fs_recover_inline_xattr();
- return error number of f2fs_truncate_blocks() to
f2fs_recover_inline_data()'s caller;

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h     |  4 ++--
 fs/f2fs/inline.c   | 19 ++++++++++++-------
 fs/f2fs/node.c     |  6 ++++--
 fs/f2fs/recovery.c | 10 ++++++++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 03693d6b1c104..b3b7e63394be7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3061,7 +3061,7 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
 void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
-void f2fs_recover_inline_xattr(struct inode *inode, struct page *page);
+int f2fs_recover_inline_xattr(struct inode *inode, struct page *page);
 int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
@@ -3487,7 +3487,7 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
-bool f2fs_recover_inline_data(struct inode *inode, struct page *npage);
+int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 			struct fscrypt_name *fname, struct page **res_page);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 896db0416f0e6..183388393c6a8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -252,7 +252,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	return 0;
 }
 
-bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
+int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode *ri = NULL;
@@ -274,7 +274,8 @@ bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 			ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 process_inline:
 		ipage = f2fs_get_node_page(sbi, inode->i_ino);
-		f2fs_bug_on(sbi, IS_ERR(ipage));
+		if (IS_ERR(ipage))
+			return PTR_ERR(ipage);
 
 		f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
@@ -287,21 +288,25 @@ bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 
 		set_page_dirty(ipage);
 		f2fs_put_page(ipage, 1);
-		return true;
+		return 1;
 	}
 
 	if (f2fs_has_inline_data(inode)) {
 		ipage = f2fs_get_node_page(sbi, inode->i_ino);
-		f2fs_bug_on(sbi, IS_ERR(ipage));
+		if (IS_ERR(ipage))
+			return PTR_ERR(ipage);
 		f2fs_truncate_inline_inode(inode, ipage, 0);
 		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
-		if (f2fs_truncate_blocks(inode, 0, false))
-			return false;
+		int ret;
+
+		ret = f2fs_truncate_blocks(inode, 0, false);
+		if (ret)
+			return ret;
 		goto process_inline;
 	}
-	return false;
+	return 0;
 }
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 90a20bd129614..daeac4268c1ab 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2512,7 +2512,7 @@ int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	return nr - nr_shrink;
 }
 
-void f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
+int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	size_t inline_size;
@@ -2520,7 +2520,8 @@ void f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 	struct f2fs_inode *ri;
 
 	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
-	f2fs_bug_on(F2FS_I_SB(inode), IS_ERR(ipage));
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
 
 	ri = F2FS_INODE(page);
 	if (ri->i_inline & F2FS_INLINE_XATTR) {
@@ -2539,6 +2540,7 @@ void f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 update_inode:
 	f2fs_update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
+	return 0;
 }
 
 int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 783773e4560de..5f230e981c483 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -514,7 +514,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 	/* step 1: recover xattr */
 	if (IS_INODE(page)) {
-		f2fs_recover_inline_xattr(inode, page);
+		err = f2fs_recover_inline_xattr(inode, page);
+		if (err)
+			goto out;
 	} else if (f2fs_has_xattr_block(ofs_of_node(page))) {
 		err = f2fs_recover_xattr_data(inode, page);
 		if (!err)
@@ -523,8 +525,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 
 	/* step 2: recover inline data */
-	if (f2fs_recover_inline_data(inode, page))
+	err = f2fs_recover_inline_data(inode, page);
+	if (err) {
+		if (err == 1)
+			err = 0;
 		goto out;
+	}
 
 	/* step 3: recover data indices */
 	start = f2fs_start_bidx_of_node(ofs_of_node(page), inode);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
