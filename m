Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C829FC61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20kUttnnwL1Ywy/FZka9MKFVTCkkQmGa9KBBT4Bqw9Y=; b=M8sauJpHwCaPCGrRmlgDzcyoPG
	b2PpbWtC8P4XATP0mFi5GdwE5I9wO7g5eSPYxeMTkeWgj6UnmcNONty5RvFsSlwjx4Z70HeM+5Bgj
	vyDGZHnk24t2p0FmEtH6Mvj/rEFEwyjgoa3jf4zvdckewRXEypStCr8NW1K5Si/AfjiM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzF9S-0007Ua-JO;
	Wed, 26 Aug 2026 15:02:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wzF9R-0007TY-Cb
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6vN/j7vfxBIgKWR2Ht5PrFZDmAgFaU/24vLDpliFyBE=; b=l8dSpmzD753wjUiur28sS2jqQs
 HRrklpXn0PzA5X6qy10dmN73DxkvKz1uP4PxJq4hvm6l0X2wT3DufbE0tPjaAyfeC7NYtdJnzA9+F
 7/Lyosz2Wo/+OTOPbhWsMs3ThlvftS4pFnobV9xb9OVoojGDLclpHk9jk9BcxbhYnzOE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6vN/j7vfxBIgKWR2Ht5PrFZDmAgFaU/24vLDpliFyBE=; b=c9sYVwxg8wfZJSTMknIf60Su1R
 eYYvulwpUd+wxWluL8JAUwlqRrm4wDM/jzPovmiLF1eAvGJql8aMru5I6o1Uo+mBDF2DsZ6MKYIP4
 qKMBJAdyuvpLy43Q9Z88jHWate4TAntBGeJr5pIw28kc6XIwxRu5JpOrd2FRSLs+Yhkw=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzF9A-00079d-Cs for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6v
 N/j7vfxBIgKWR2Ht5PrFZDmAgFaU/24vLDpliFyBE=; b=PWbAbtyFNE3RE+mBP0
 TrCRuCrH0fI387IjXxD8Y/KvYAnQnlAxNF/uNbCFLjVPvGaFt0YzAo3MlLIUKiSm
 +CIsqtH+xPOXSHSZXgFMG6do1883xEoTs6StL8XJa7Wl+lkbt6FNQa2sdgM43BD7
 3OvIha1Z9FKfI5nL3bfDN2exw=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3P5N85Y5qx4G3Gg--.15517S3; 
 Wed, 26 Aug 2026 21:09:18 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 21:09:13 +0800
Message-ID: <20260826130916.2231342-2-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wB3P5N85Y5qx4G3Gg--.15517S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4UWFyUAry7AF4UtFW5Wrg_yoW5tFWkpF
 y5GrZ8Z3ykCFyxXr1ftF47ZryrKrZ7Ww4UJFs7u3s3C3W5X3Z3Kw4Iqw4j9F1F9rWUA3y8
 XryUJFy8uF1UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjmhwUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsB7WpmqO5X5UMQAA3E
X-Headers-End: 1wzF9A-00079d-Cs
Subject: [f2fs-dev] [PATCH 12/14] f2fs: handle block cloning within the same
 large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

With large folios, the source and destination block in __clone_blkaddrs()
can belong to the same folio during same-inode operations such as
collapse range and insert range.

In that case, locking the source folio and then looking up the
destination folio can try to lock the same folio again.  It also copies
from and to offset 0, which is only correct for order-0 folios.

Detect the same-inode, same-folio case before looking up the destination
folio.  Then in this case,we reserve the destination block explicitly.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/file.c | 76 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4272013dbe38..b82acbc3240f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1581,25 +1581,77 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			f2fs_put_dnode(&dn);
 		} else {
 			struct folio *fsrc, *fdst;
+			size_t src_off, dst_off;
 
 			fsrc = f2fs_get_lock_data_folio(src_inode,
 							src + i, true);
 			if (IS_ERR(fsrc))
 				return PTR_ERR(fsrc);
-			fdst = f2fs_get_new_data_folio(dst_inode, NULL, dst + i,
-								true);
-			if (IS_ERR(fdst)) {
-				f2fs_folio_put(fsrc, true);
-				return PTR_ERR(fdst);
-			}
 
-			f2fs_folio_wait_writeback(fdst, DATA, true, true);
+			src_off = offset_in_folio(fsrc,
+						(loff_t)(src + i) << PAGE_SHIFT);
+
+			/*
+			 * For same-inode operations (collapse/insert), src and
+			 * dst may fall within the same large folio. Detect this
+			 * to avoid self-deadlock on folio lock.
+			 */
+			if (src_inode == dst_inode &&
+			    folio_contains(fsrc, dst + i)) {
+				struct dnode_of_data dn;
+
+				/* Reserve block for dst before copying */
+				set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
+				ret = f2fs_reserve_block(&dn, dst + i);
+				if (ret) {
+					f2fs_folio_put(fsrc, true);
+					return ret;
+				}
+
+				dst_off = offset_in_folio(fsrc,
+						(loff_t)(dst + i) << PAGE_SHIFT);
+				f2fs_folio_wait_writeback(fsrc, DATA, true, true);
+				memcpy_folio(fsrc, dst_off, fsrc, src_off,
+					    PAGE_SIZE);
+				if (folio_test_large(fsrc)) {
+					f2fs_ffs_find_or_alloc(fsrc);
+					f2fs_ffs_mark_subrange_uptodate(fsrc,
+								dst_off, PAGE_SIZE);
+					f2fs_ffs_mark_subrange_dirty(fsrc, dst_off,
+								    PAGE_SIZE);
+				}
+				folio_mark_dirty(fsrc);
+				if (i_size_read(dst_inode) <
+				    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
+					f2fs_i_size_write(dst_inode,
+						((loff_t)(dst + i + 1) << PAGE_SHIFT));
+				folio_set_f2fs_gcing(fsrc);
+				f2fs_folio_put(fsrc, true);
+			} else {
+				fdst = f2fs_get_new_data_folio(dst_inode, NULL,
+							      dst + i, true);
+				if (IS_ERR(fdst)) {
+					f2fs_folio_put(fsrc, true);
+					return PTR_ERR(fdst);
+				}
 
-			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
-			folio_mark_dirty(fdst);
-			folio_set_f2fs_gcing(fdst);
-			f2fs_folio_put(fdst, true);
-			f2fs_folio_put(fsrc, true);
+				dst_off = offset_in_folio(fdst,
+						(loff_t)(dst + i) << PAGE_SHIFT);
+				f2fs_folio_wait_writeback(fdst, DATA, true, true);
+				memcpy_folio(fdst, dst_off, fsrc, src_off,
+					    PAGE_SIZE);
+				if (folio_test_large(fdst)) {
+					f2fs_ffs_find_or_alloc(fdst);
+					f2fs_ffs_mark_subrange_uptodate(fdst,
+								dst_off, PAGE_SIZE);
+					f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
+								    PAGE_SIZE);
+				}
+				folio_mark_dirty(fdst);
+				folio_set_f2fs_gcing(fdst);
+				f2fs_folio_put(fdst, true);
+				f2fs_folio_put(fsrc, true);
+			}
 
 			ret = f2fs_truncate_hole(src_inode,
 						src + i, src + i + 1);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
