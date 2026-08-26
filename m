Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2465AC61DC7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Y2OlSog756ulvLG0nZzm6q1Rkxhc8yCCKZGy4nkHHM=; b=HBAGB43pXbKzAnheWBZIwJJs5d
	glmupORVSqPLRtLTODKyYNVx7lQuMfQvG22wqo+RIgcZJlpwGZCr75Bmi7A4kYqO5v0r/QGJat6Ka
	bmjcCvsiQGdyclMccrZjbMTsn+ArLuOLiQbweFIEGrcF3IvUDySkIN8VTAt9ljvMB5fs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz8yj-00081e-0C;
	Wed, 26 Aug 2026 08:27:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wz8yd-00081J-Rs
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R5VhOkEDRJp/Z+fhFGqawuZ5o6XlbmqLabVb2kU3S+g=; b=S7UkZ4FrH0yF1cpCDP3hUtSTIs
 ewzxIavQlov2UeHPfRNdQFY2FOoy5Dk3WJhB6I6EcEXEd8dluZqQ5hwW4jOmelV9h1xX70L7jJJro
 A6T9B+H1T25KI9XJOS1eAvR6NVTl6kJtxm1kH9UZheBxmIvAzx1vSWAew5djxHVsjKww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R5VhOkEDRJp/Z+fhFGqawuZ5o6XlbmqLabVb2kU3S+g=; b=EgeQAE9VjXlZcEyJKldpg69jF9
 ZoTGrZfUyTEE5/slMiGXdsdxcEyL0go/CzjO6zH7cU0fRQKu+g0fwKA6kIiwEUBp2MqJIxjQ6FWlp
 hLC2lWhCHRHglJGDIiWSY94FoonmC1Eq4qzl/Kx3jsx3p+J6PBKQSCBcV9Ot3ZVqLogM=;
Received: from [220.197.31.7] (helo=m16.mail.126.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz8yb-0002gw-4A for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=R5
 VhOkEDRJp/Z+fhFGqawuZ5o6XlbmqLabVb2kU3S+g=; b=TmSX8Zi7yh0NsN8sZK
 XgOYkKqXN58yIMVpEy+dFBQx92Ze6FYH1QrsXKc+SNSmO2wpDQDki7LABbKRx0mZ
 u2zQ8XlwioLzVUYUlaTnSF+zQKELgsmjmDGxhdCNPwvUsZ9aX5jyAZt5IAw48oDP
 Ksx34ejEnIZW0GzIeICDpXSK8=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3F29Bo45qLzIoGQ--.14929S6; 
 Wed, 26 Aug 2026 16:26:45 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 16:26:31 +0800
Message-ID: <20260826082641.2007658-5-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F29Bo45qLzIoGQ--.14929S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF1fuFyDJFWDWF4kCrW8Crg_yoW7GF1fpF
 WUKwn5GrWrJa4furn3XF1jvr1Y934Iqw47GayfGw1fZ3W5J3sxK3Wvyw1YkF1YqrZ7A3W8
 Xa17tFWrW3WkJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUNVkUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQY4CGqOo0ZikAAA30
X-Headers-End: 1wz8yb-0002gw-4A
Subject: [f2fs-dev] [PATCH 04/14] f2fs: support atomic file large folios
 buffered write
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

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7ce96ae02cfc..dff802725544 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4211,6 +4211,117 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	return 0;
 }
 
+static int prepare_large_folio_atomic_write_begin(struct inode *inode,
+		struct address_space *mapping, struct folio *folio, loff_t pos,
+		unsigned int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
+	size_t ori_off = offset_in_folio(folio, pos);
+	size_t need_off = ori_off;
+	pgoff_t index;
+	int err = 0;
+	unsigned int orig_order;
+	bool need_balance = false;
+
+	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
+
+	f2fs_ffs_find_or_alloc(folio);
+
+	/* Inline data must have been converted before reaching here. */
+	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+
+	/* Reserve COW blocks for all covered 4K subpages first. */
+	pgoff_t start_index = folio->index + (ori_off >> PAGE_SHIFT);
+	pgoff_t end_index = folio->index +
+		((ori_off + len - 1) >> PAGE_SHIFT);
+
+	for (index = start_index; index <= end_index; index++) {
+		block_t cow_blkaddr = NULL_ADDR;
+		bool node_changed = false;
+		int ret;
+
+		ret = __find_data_block(cow_inode, index, &cow_blkaddr);
+		if (ret)
+			return ret;
+		if (cow_blkaddr != NULL_ADDR)
+			continue;
+
+		ret = __reserve_data_block(cow_inode, index, &cow_blkaddr,
+					   &node_changed);
+		if (ret)
+			return ret;
+
+		inc_atomic_write_cnt(inode);
+		need_balance |= node_changed;
+	}
+
+	if (need_balance && !IS_NOQUOTA(inode) &&
+				       has_not_enough_free_secs(sbi, 0, 0)) {
+		orig_order = folio_order(folio);
+		folio_unlock(folio);
+		f2fs_balance_fs(sbi, true);
+		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping ||
+			     folio_order(folio) != orig_order))
+			return -EAGAIN;
+	}
+
+	if (folio_test_uptodate(folio) || len == folio_size(folio))
+		return 0;
+
+	/* Then read partial 4K subpages. */
+	while (find_next_valid_block(folio, ori_off, &need_off, len)) {
+		size_t off;
+		block_t cow_blkaddr = NULL_ADDR;
+		block_t ori_blkaddr = NULL_ADDR;
+		struct inode *read_inode = NULL;
+		block_t read_blkaddr = NULL_ADDR;
+
+		index = folio->index + (need_off >> PAGE_SHIFT);
+		off = offset_in_folio(folio, index << PAGE_SHIFT);
+
+		err = __find_data_block(cow_inode, index, &cow_blkaddr);
+		if (err)
+			return err;
+
+		if (__is_valid_data_blkaddr(cow_blkaddr)) {
+			if (!f2fs_is_valid_blkaddr(sbi, cow_blkaddr,
+						  DATA_GENERIC_ENHANCE_READ))
+				return -EFSCORRUPTED;
+			read_inode = cow_inode;
+			read_blkaddr = cow_blkaddr;
+		} else if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE)) {
+			folio_zero_segment(folio, off, off + PAGE_SIZE);
+			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+			continue;
+		} else {
+			err = __find_data_block(inode, index, &ori_blkaddr);
+			if (err)
+				return err;
+
+			if (!__is_valid_data_blkaddr(ori_blkaddr)) {
+				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+				continue;
+			}
+
+			if (!f2fs_is_valid_blkaddr(sbi, ori_blkaddr,
+						  DATA_GENERIC_ENHANCE_READ))
+				return -EFSCORRUPTED;
+			read_inode = inode;
+			read_blkaddr = ori_blkaddr;
+		}
+
+		err = f2fs_submit_page_read_sync(read_inode, folio,
+						 index, read_blkaddr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4282,7 +4393,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 	*foliop = folio;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
 		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
 	else if (!folio_test_large(folio))
@@ -4307,10 +4418,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	f2fs_folio_wait_writeback(folio, DATA, false, true);
 
 	if (folio_test_large(folio)) {
-		err = prepare_large_folio_write_begin(inode,
+		if (f2fs_is_atomic_file(inode))
+			err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len);
+		else
+			err = prepare_large_folio_write_begin(inode,
 					folio, pos, len);
 		if (!err)
 			return 0;
+		if (err == -EAGAIN) {
+			f2fs_folio_put(folio, true);
+			goto repeat;
+		}
 		goto put_folio;
 	}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
