Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72157CC6B08
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D+y6S2mbKfQnaUSkg3/6QvBwy70VG2LbJVp+E6HCfnk=; b=fU/vdbseEI7elCkZlDkKic7SWr
	knPuK+uEMLoVhVuhxCqHpp73IVr4ZZ1ZDjQYv/q9/k/3A5W1EDSNBkjhn/DrvUhg+SOL7s2hnXXaD
	7jIlAhhvP2u8kJHG34HDy/wB18jtNgtlPX9fGjSaf1TNNbN6joKaTVBGYqBhpUzTar/I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGZCx-0001GY-SS;
	Tue, 13 Oct 2026 09:54:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xGZCv-0001GR-SH
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 09:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0okxf7ehqUJ0LZKPerGNiv4PTPkPmQEewfHfZJI5Fug=; b=Jhs6mlptIiHcjfaSsftmt09hCD
 WNDBdWCeG5LYyS5jjJCB1+i4tq9IfPfyyX/yziHnZeecjFW9/NETgHrlvNG5jLu1yrbnoaT187kwm
 upvohx9sF5YUoG+BAK44oCuc9ZZEjrISewDE3orh0QBApW6DQnPvLVM4eyqUBMcl5jv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0okxf7ehqUJ0LZKPerGNiv4PTPkPmQEewfHfZJI5Fug=; b=X
 hSSb0CZdLTGkemP0KO38Ha704pzyuv/MeRVnnLCzCw027bSbu5kwgM7d0Io8u3GOH1fpKrqwkS70I
 Epoyx/5GXcGEO9BhQeY/0nnT0otinJFgKs63h3fwe47/JoCyQxUja6+Tpez5s0E7bcR/NKF5YD+o/
 PfgjTAEQUYLPPp8c=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGZCu-00029t-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 09:54:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0o
 kxf7ehqUJ0LZKPerGNiv4PTPkPmQEewfHfZJI5Fug=; b=RvXJqo5ff5IkC2yayF
 LpL8/U938JxHydCuP7FrIuUxgHrxGEs6/egcPvy1OXQSbVSahfx65+rgKFvcnVBh
 bcGpB5Rsh8tPGmgJBUPSFgOqNmVPFYMmReSelWoMU393Wb/saKMCVV3RGRJ/Fb1d
 3FJNF2BHX2lJ1JL+FGLPvXwTc=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3P9Oe_81qEuNLBA--.35692S2; 
 Tue, 13 Oct 2026 17:53:35 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
 Daeho Jeong <daehojeong@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 13 Oct 2026 17:52:34 +0800
Message-ID: <20261013095235.731331-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: _____wD3P9Oe_81qEuNLBA--.35692S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1rtr17ZF43ArykWF4UArb_yoW8KFyxpr
 Z0krn8Cr4fWr15uwsagFn0v3WrK3s7WF47WFnrGw1fX3Wjgrn5K3Wrta48WF4YqrW3Ar1I
 qFWDKFyfX3WUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1MKZUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsR81BWrN-58VXQAA3R
X-Headers-End: 1xGZCu-00029t-I6
Subject: [f2fs-dev] [PATCH] f2fs: read i_size once in f2fs_vm_page_mkwrite
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
 fs/f2fs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..672182300991 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -124,6 +124,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -223,12 +224,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (folio_test_mappedtodisk(folio))
 		goto out_sem;
 
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
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
