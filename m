Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ABCC61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NraL8vzTVxDqfHGHotMEJdP2uGOuroZi9DTO1lFazbo=; b=fAd6YhK15Ztv97QObrkNFXDq2C
	UBcZwLiV3rmPUUISg2DTzkasIGtAUDqGLjhUVo/2UtyqsP1hLhn7osVQqspXXYt+evyy4VmqDFUcU
	KvBMl9s7B2AhNRFC2SiOGbjPtgZQcTJegxOPxVScJVUpwdxxKGJDBVbGR1LMIZ/f20Gk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz8yt-0000Hx-9u;
	Wed, 26 Aug 2026 08:27:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wz8yj-0000DI-DI
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=87l8UBIwU+CaPrhamZWH2XD9LKTJw4XDkrfKsS5634Y=; b=jPzkU5UbFZQc8Osg9pVYAjqZWH
 IMsIEp11GdM1hb5weYctB41RM4qTivajaGcWVK83GQ7i3OW7zWjULgdPnOqKKSoCi+/mzQa5YUntR
 D2CTDwWUlLimE+cZQv86HdbX32GtTDzvY5no2qGM+AQOe3obtuggjC9M7l1Wp66Ityg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=87l8UBIwU+CaPrhamZWH2XD9LKTJw4XDkrfKsS5634Y=; b=hBgrP5h3Zx3F6sWTEXnnAMMQ2W
 hhHQ6+AGusbP7BJXdraVJt2J+5BjN576YM7M/yhcetJSHDAfSgM2nQmTe6sD8iwdMyxbdbJudN6q8
 iQ0VM7WUGeLgfh3CihnJ4mrge/3Waij++RnEjP2tFHo9QfR07dn3RI+7cPKA2dJ99tzU=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz8ye-0002cR-60 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=87
 l8UBIwU+CaPrhamZWH2XD9LKTJw4XDkrfKsS5634Y=; b=fjsBuWTKPuASpZceNf
 5qF/THWNGxhVg3C2KD7hG7JRXqzK5Aik3xkVkUYoDPQpp3DzUVHBLeDroKrm89Bx
 ONejDGPetG2sNFh4kKVWbfghc9WLajiJx46w136zYrDY3jD8jxY1t7d6uV4e/xy1
 JkK0Pk88mseVJpGXWAjO3NSNM=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3F29Bo45qLzIoGQ--.14929S11; 
 Wed, 26 Aug 2026 16:26:49 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 16:26:36 +0800
Message-ID: <20260826082641.2007658-10-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F29Bo45qLzIoGQ--.14929S11
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF43KrWrJr15WFW5ZFWfGrg_yoW5ZF43pF
 y8KrZ5Kr45Kr43WF1ftFn3Zr1SqryxXa1xGFZ3G3s3A3WYqa4fCFykt34Ykr4rtrykCFna
 vF45GryUWF4UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUZ2-UUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogo5CWqOo0pS3AAA3b
X-Headers-End: 1wz8ye-0002cR-60
Subject: [f2fs-dev] [PATCH 09/14] f2fs: support partial uptodate large folio
 read
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

Buffered write can have write bytes smaller than folio
size for cases when folio minimum order is not zero.
This can left partially uptodate folio in page cache.
So we skip uptodate subpage read in read_data_large_folio.
Also mark hole subpage uptodate in uptodate bitmap.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 48c1bb6c02e3..59b07b83b216 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2855,6 +2855,56 @@ static bool find_next_valid_block(const struct folio *folio,
 	return false;
 }
 
+static unsigned int ffs_next_uptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_bit(ffs->state, end + 1, start);
+}
+
+static unsigned int ffs_next_nonuptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_zero_bit(ffs->state, end + 1, start);
+}
+
+static void f2fs_skip_fully_uptodate_front(struct folio *folio,
+			pgoff_t *index, pgoff_t *offset, unsigned int *nrpages,
+			unsigned int *max_nr_pages)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int next, skipped;
+
+	if (!f2fs_folio_has_ffs(folio) || !*nrpages)
+		return;
+
+	ffs = folio->private;
+	next = ffs_next_nonuptodate_subpage(ffs, *offset,
+					    *offset + *nrpages - 1);
+	skipped = next - *offset;
+	if (!skipped)
+		return;
+
+	*index += skipped;
+	*offset += skipped;
+	*nrpages -= skipped;
+	*max_nr_pages -= skipped;
+}
+
+static void f2fs_truncate_read_extent(struct folio *folio, pgoff_t offset,
+				     unsigned int *len_blks)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int next, end;
+
+	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
+		return;
+
+	ffs = folio->private;
+	end = offset + *len_blks - 1;
+	next = ffs_next_uptodate_subpage(ffs, offset + 1, end);
+	if (next <= end)
+		*len_blks = next - offset;
+}
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
@@ -2901,6 +2951,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -2933,6 +2988,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(folio, offset, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -2959,6 +3015,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				ret = -EIO;
 				goto err_out;
 			}
+			if (folio_test_large(folio)) {
+				ffs = f2fs_ffs_find_or_alloc(folio);
+				spin_lock_irq(&ffs->state_lock);
+				__ffs_mark_subrange_uptodate(folio, ffs,
+						page_offset, PAGE_SIZE);
+				spin_unlock_irq(&ffs->state_lock);
+			}
 			continue;
 		}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
