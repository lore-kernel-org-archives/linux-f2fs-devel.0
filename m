Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A50CC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R0nglDOufJHdDa/Kk1AtgyYsElJu/9guV2kTvxvuvMQ=; b=KV0ruWOerFxyICytU1osQ9hLkM
	ehuryLiM0qKXnDtHb/PuFgk+Xxdjegdd8A2GExQuU618rOQfwPcjmHjOr81M8jsOyXbgLC50HI404
	WgT6N9GBZS9eAsruZflw+IOy4FLaL6qgikutOCVMrL73i/5AUvW8Uhsqvi+Fr3j66Bfc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGaBt-0002Ya-TR;
	Tue, 13 Oct 2026 10:57:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xGaBp-0002YO-OK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lt5ewSSKVzWK4j0y3jnQChKbSYVDLFqRFfBCIyCb35E=; b=H4XQFfsLyCtDK0VG3f5lUYVHkO
 R330VrHwNwIgfijycUZFQLBkRPUJYhgkeKlQYYNPaPS5yj9O+WNgbLMYavO0MdyLmlnVjEi8WQIK3
 KPFmG1/iO7NTJhgP8fUGTzyjEJQLX8s/1gqP/sSNuQBw7mnodGHAufrFMKfeLVx/Dm48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lt5ewSSKVzWK4j0y3jnQChKbSYVDLFqRFfBCIyCb35E=; b=Q
 vZHPkeyNwVBDJpZOK20+kbYL/8OUi3rYRELZICO8gWfHjevTDXl6nkUTMrc0UEXNy/y+zw15SMMH4
 75J6o9db1R7uIHugTWNiY7JLwhDFDGSZ/eFTXzLi6TcwPWcU2irNsiePK1ABySsOmWmzgE2MnssI4
 XpI0+UCQbUK31caU=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGaBn-0003nH-3o for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 10:57:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lt
 5ewSSKVzWK4j0y3jnQChKbSYVDLFqRFfBCIyCb35E=; b=loMR8PaSlN2MNmZpZb
 QRa8tyFx06b+JQQ7sPIxV0uH9IApPeFF7717Wgu+YHIIGor9SLPhFeg/LQdrxO2N
 vrJ/b3PrGcaqwT+m+d8z8BwqIpLNZKqo2GJxa/LcYQHkXlMHFPwJTM6T15zp8Gvy
 zFifzKP+uJEyOx2odeTSWEMuI=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgBXx+xdDs5qMT3bBQ--.29131S2;
 Tue, 13 Oct 2026 18:56:30 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Daeho Jeong <daehojeong@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 13 Oct 2026 18:56:28 +0800
Message-ID: <20261013105628.869156-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: PikvCgBXx+xdDs5qMT3bBQ--.29131S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy3Cry3ZFW5tw4rCw4rZrb_yoW5Xw47pr
 WYkrn8Ar4fWry3uws3WFn0v3WrK3s7WF47WFnrGw43Z3Wqqrn3Kay8ta48WF4Yqry3Ar1I
 qFWDtFyfZ3WUJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1KZXUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoh7ouGrODl55PAAA3d
X-Headers-End: 1xGaBn-0003nH-3o
Subject: [f2fs-dev] [PATCH v2] f2fs: read i_size once in f2fs_vm_page_mkwrite
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
folio is partially beyond EOF, and once to calculate the offset for
folio_zero_segment(). But a concurrent buffered write can extend isize
and cause the following race condition to corrupt data:

buffered write writes [0,3500)

CPU0 (write fault)                        CPU1 (buffered write)
 ----                                     ----
 f2fs_vm_page_mkwrite()
 folio_lock(folio)
 if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 i_size_read(inode))
 /* i_size_read() = 3500 */
                                           write(fd, buf, 200, 4096)
                                           /* writes into page1, does not
                                              wait for folio lock */
                                           i_size_write(inode, 4296)
 offset = i_size_read(inode) & ~PAGE_MASK
 /* i_size_read() = 4296, offset = 200 */
 folio_zero_segment(folio, offset, folio_size(folio))
 /* valid data [200, 3500) is zeroed */

Fix this by reading i_size once and using the same value for both the
EOF check and the zeroing offset.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
v2: move the isize read earlier (right after folio_lock).

 fs/f2fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..a0e09cea64d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -124,6 +124,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -187,8 +188,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
+			folio_pos(folio) > isize ||
 			!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		err = -EFAULT;
@@ -224,11 +231,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
 
-		offset = i_size_read(inode) & ~PAGE_MASK;
+		offset = isize & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
 	folio_mark_dirty(folio);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
