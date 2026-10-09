Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A693CA601D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Y3Fv+r34KEL8OqzrGTMURgTMNQakxX0ZNU9U1OFp4s=; b=Smbrq4u3zwR28OeV4aQh+XB2yc
	VtpiAj81UiHboSNMh1F9JG8PBGCwKnzWYjNv0r9YNgx2O+0Iram/M6BKctyadCaRONHQ8///ic7RA
	mc/9fLM6kOZRMXAcr23+hTSM5gWgcvJcxy5htHd5+2/0EAdeaPP90OfKN+KmEdz8YbVU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDTh-0002ux-0w;
	Fri, 09 Oct 2026 16:29:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDTf-0002u2-Jq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1cQk51XlykcZdSe2t0RhAhWZuNMJRxECXtGiWzf02L4=; b=HscG1pEIpRfJnQ9XMkC2TP+63s
 gwB8jMpNypBnVdtaFxDVM0pCXvGRyWDe1xFx5C6NMUr2gDatyuHkQ4N0o/sNe5wyxpLZJEvR0F6OM
 /csgBkG5Wike2RLi7SpD43FtrKNK0shTQrmojxKz2DXRxFEc2kybcekY5LU2slVM/7zQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1cQk51XlykcZdSe2t0RhAhWZuNMJRxECXtGiWzf02L4=; b=F/YAV7XPp1ZmsHHfVNkXHbdd1S
 /6IAVgplreNWMxxeLlp8bOPZiequKQ+6H+4oR8TRhW/ocpYaw3prWcxyKqGhZD3gxcpejLd1+JmAI
 tlWVLl69IMLcszYgU/BrVZMD3CzEPoHXRxwMcb1fT5QWBQt6qnasMJjlBSHfQ0wQ06qs=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDTG-0005ST-VZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1c
 Qk51XlykcZdSe2t0RhAhWZuNMJRxECXtGiWzf02L4=; b=T/P+foUZ4FinYEV80K
 CkUvzHYfv7Zt5q8NqtszQkie1BO+VW3vVtNEgga2IxMP5A3Oaz6JNkWbUKYQRV+D
 AK3v1VbMXeDrQnAYQ4KBsGz5KRKg++yKR2Ve1TmP3VduE6z93DZjF/R94tHpS8GB
 UvdJlAA/tl7gpNoyj2Gf/9Xsg=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgDH3_w0FslqWTz5BA--.13078S4;
 Sat, 10 Oct 2026 00:28:42 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:28:24 +0800
Message-ID: <20261009162828.4188050-3-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: PikvCgDH3_w0FslqWTz5BA--.13078S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryUAFW5tw4kKrykJF45GFg_yoW8Cry3pr
 WDKwnrWFWkur17WrnrWF4Sqr1rK3y5WFW7Ca97C3WxXFn8Xr1kKF1kt3sYgFW5trykJr9a
 qw4kAFy8XFy5JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5yCJUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRugcGrJFjtJjAAA3x
X-Headers-End: 1xFDTG-0005ST-VZ
Subject: [f2fs-dev] [PATCH v3 13/17] f2fs: wait for folio writeback before
 ffs_detach_free
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
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 kernel test robot <yi1.lai@intel.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

truncate_inode_pages_range() can invalidate a large folio that is still
under writeback, which can result in the following use-after-free:

 CPU0 (writeback)             CPU1 (truncate)
 ----                         ----
f2fs_write_cache_folios()
folio_start_writeback(folio)
/* submit bios */

retry_out:
folio_unlock(folio)
/* all bios submitted; folio lock released */

                              truncate_inode_pages_range()
                              find_lock_entries() /* locks the folio */
                              truncate_cleanup_folio(folio)
                              folio_invalidate(folio, 0, folio_size(folio))
                              -> f2fs_invalidate_folio(folio, 0,
                                                        folio_size(folio))

f2fs_write_end_bio(bio)
ffs = folio->private          ffs_detach_free(folio)
                              folio_detach_private(folio)
                              kfree(ffs)
atomic_sub_and_test(nr_pages,
    &ffs->write_pages_pending) <-- use-after-free

Wait for folio writeback in invalidate_folio, then we can free the
folio state without any other remaining user.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 138a77044e95..19072fe7dbe5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5347,6 +5347,14 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	}
 
 	if (f2fs_folio_has_ffs(folio)) {
+		/*
+		 * The folio may still be under writeback with bios in
+		 * completion that need to access f2fs_folio_state.  Wait
+		 * for the writeback to complete before freeing the state,
+		 * otherwise it will result in use-after-free.
+		 */
+		folio_wait_writeback(folio);
+
 		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 							folio_size(folio));
 	} else if (folio_test_dirty(folio)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
