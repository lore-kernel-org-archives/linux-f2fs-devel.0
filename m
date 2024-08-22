Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72AC5472C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:29:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgweA-0003YB-Fh;
	Thu, 22 Aug 2024 01:29:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lizetao1@huawei.com>) id 1sgwe8-0003Xi-Ex
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PY/r2VqZDCuKPaoLpsLGdNilQ5okyoMPdY8nPWD7wOI=; b=HCiBbugwQnnr906WvpQexbEGnf
 1O/P3qV6OOjBKWpbtUQLlyy9TjBlBSLp73c4aO1r2GiUA20kpjfH0TUAxyzR1j7hpJTfCGZDOJeKd
 Fr5I4mQ29jsyl1u9mDOIA0X35XMTJ1xsZXlbdjSrdEHBYjLzHEY95BNb0RKTRwLlbB/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PY/r2VqZDCuKPaoLpsLGdNilQ5okyoMPdY8nPWD7wOI=; b=YvgABhopAni7UIDbCneIJPv1kk
 n2pkEvtEX3eWG9eWfmc6n3h8ks3jbOiVFpA0gqqmwFi1t6CxynFfP2biv9+5HGpf5VpvndJhOreSG
 sxDUsPYXnX6qnlJo74mRsBDmdcCNKqg8yQO8r7jH9ND+eKsaIsEHGyMwXZWd4Od4sZh4=;
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgwe7-0006bz-Ev for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:52 +0000
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wq5946nWxz69Lc;
 Thu, 22 Aug 2024 09:24:56 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id B05A21800FF;
 Thu, 22 Aug 2024 09:29:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:39 +0800
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <terrelln@fb.com>
Date: Thu, 22 Aug 2024 09:37:02 +0800
Message-ID: <20240822013714.3278193-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Headers-End: 1sgwe7-0006bz-Ev
Subject: [f2fs-dev] [PATCH 02/14] btrfs: convert get_next_extent_buffer() to
 take a folio
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
From: Li Zetao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Li Zetao <lizetao1@huawei.com>
Cc: linux-btrfs@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio. And use folio_pos instend of page_offset, which is more
consistent with folio usage.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3c2ad5c9990d..b9d159fcbbc5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4135,17 +4135,17 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 
 #define GANG_LOOKUP_SIZE	16
 static struct extent_buffer *get_next_extent_buffer(
-		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
+		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
 {
 	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
 	struct extent_buffer *found = NULL;
-	u64 page_start = page_offset(page);
-	u64 cur = page_start;
+	u64 folio_start = folio_pos(folio);
+	u64 cur = folio_start;
 
-	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
+	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
 	lockdep_assert_held(&fs_info->buffer_lock);
 
-	while (cur < page_start + PAGE_SIZE) {
+	while (cur < folio_start + PAGE_SIZE) {
 		int ret;
 		int i;
 
@@ -4157,7 +4157,7 @@ static struct extent_buffer *get_next_extent_buffer(
 			goto out;
 		for (i = 0; i < ret; i++) {
 			/* Already beyond page end */
-			if (gang[i]->start >= page_start + PAGE_SIZE)
+			if (gang[i]->start >= folio_start + PAGE_SIZE)
 				goto out;
 			/* Found one */
 			if (gang[i]->start >= bytenr) {
@@ -4190,7 +4190,7 @@ static int try_release_subpage_extent_buffer(struct page *page)
 		 * with spinlock rather than RCU.
 		 */
 		spin_lock(&fs_info->buffer_lock);
-		eb = get_next_extent_buffer(fs_info, page, cur);
+		eb = get_next_extent_buffer(fs_info, page_folio(page), cur);
 		if (!eb) {
 			/* No more eb in the page range after or at cur */
 			spin_unlock(&fs_info->buffer_lock);
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
