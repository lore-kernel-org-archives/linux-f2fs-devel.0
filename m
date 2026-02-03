Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B37E8306E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WBqyFtk8BqNtDXRZnKqDndJturuQQn09fqAO4fyjgI=; b=TNNXAPjtbNeI+LsO5RVEO1veDi
	BdepPncxbsUlqT1mn4PZkZHtndOW6Sf/REW1tYvZt1oTXISN3TdhBiRlg15lybfEKoEN5At9XK5Cn
	MU1cGMx5A3cgXdNPhSX8zYpCudmkb5tGNM4DK2gpiv8dPuddAx38UjbKBMzN5bEuu+Vc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnCqi-00086W-Th;
	Tue, 03 Feb 2026 09:37:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vnCqh-00086P-LH
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+w+XoHUqXBUb0hGxPU7zTASvD8KrWSlf6FCVV1oeFnE=; b=lBs+BwOgqXuwsoLln6UoXS+hjz
 8ySZ8h8XE6RaCd/GuLI/Ot85NkOXwcE7CKXUKY+n3Lmfl7iD0qy+39IgGuS7ndTSWdjl3s02UR7uD
 bXeUtvKNkZ2fkw7WBP4Nj7aZ0dmOCstD9BwOISR0HDpAiclFeIlwq9a8r98D8WxBuKDI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+w+XoHUqXBUb0hGxPU7zTASvD8KrWSlf6FCVV1oeFnE=; b=JR5IT5AGIGEVXTRuBidCjeEtB8
 elgysEVr2rb20XwK1dMz7++WRZxyRQcY0PJ9ni7RrvKbTCW4LAy9JyZc+q3swuLjp7UQ0j8nKfhDo
 0Fs1WvYKTGFTssmQ3O7fKxqL+IBl2CCD7mtTnH16LGfHwRTnb0yir4mxEFCuR9GDeAgg=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vnCqf-00069y-LH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Feb 2026 09:37:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+w
 +XoHUqXBUb0hGxPU7zTASvD8KrWSlf6FCVV1oeFnE=; b=MYnObjTkFHXKNCgWUF
 2cPUHCIMGu/7oj2z5YXpJfLFsaINTLVquGFKD1EfOR9OS0hE+B2APsegfgIv+kzv
 trnXCIv0igh/iHP0V/+qi8rUQLjpJAp0y/jvvyzD34OQ9OqrY0TQHA+68CGW92gO
 WD5NCJM7i16MkqCKExWAPw7Ec=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3z5OjwYFpjYYQAA--.45631S4; 
 Tue, 03 Feb 2026 17:37:11 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  3 Feb 2026 17:36:14 +0800
Message-Id: <20260203093614.857390-6-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203091256.854842-1-nzzhao@126.com>
References: <20260203091256.854842-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3z5OjwYFpjYYQAA--.45631S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWDXry3tw1rKw47KrWruFg_yoW5uF45pr
 Z5K3ZYyr4fGryag3W3JF1Svr1ay3s7Wa1UAa97Gw17JF12v3W5uF1kJ34UuF4xJrW8AF1f
 Aay5CF1rWFWYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXOUUUUU=
X-Originating-IP: [58.240.165.118]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogdcLGmBwccvlAAA3A
X-Headers-End: 1vnCqf-00069y-LH
Subject: [f2fs-dev] [RFC PATCH v1 5/5] f2fs: Make folio->private flags work
 with folio state
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
Cc: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Large folios store a f2fs_folio_state pointer in folio->private,
so page-private bits must be stored separately.
Route page-private flags to a extra private_flags in f2fs_folio_state
for large folios while preserving the existing encoding for order-0
folios.We also make PAGE_PRIVATE funcs aware of f2fs_folio_state.

Note there's and edge case when folio_set_f2fs_#name is called on a
large folio before any f2fs_folio_state is attached. We may should alloc
a f2fs_folio_state in that case, but it requires to move ffs_find_or_alloc
to f2fs.h. For now I just let this case sliently return.
Need more disscusion here.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/f2fs.h | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 04a6310145c4..91f6d5fb9d20 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2045,6 +2045,7 @@ struct f2fs_sb_info {
 struct f2fs_folio_state {
 	spinlock_t		state_lock;
 	unsigned int		read_pages_pending;
+	unsigned long		private_flags;
 	unsigned long		state[];
 };
 
@@ -2618,9 +2619,15 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
 {									\
-	unsigned long priv = (unsigned long)folio->private;		\
+	unsigned long priv;						\
 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
 			     (1UL << PAGE_PRIVATE_##flagname);		\
+	if (folio_test_large(folio) && folio->private) {		\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		priv = ffs->private_flags;				\
+	} else {							\
+		priv = (unsigned long)folio->private;			\
+	}								\
 	return (priv & v) == v;						\
 }									\
 static inline bool page_private_##name(struct page *page) \
@@ -2635,9 +2642,14 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
 {									\
 	unsigned long v = (1UL << PAGE_PRIVATE_NOT_POINTER) |		\
 			     (1UL << PAGE_PRIVATE_##flagname);		\
-	if (!folio->private)						\
+	if (!folio->private && !folio_test_large(folio))		\
 		folio_attach_private(folio, (void *)v);			\
-	else {								\
+	else if (folio_test_large(folio)) {				\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		if (!ffs)						\
+			return;						\
+		ffs->private_flags |= v;				\
+	} else {							\
 		v |= (unsigned long)folio->private;			\
 		folio->private = (void *)v;				\
 	}								\
@@ -2653,13 +2665,17 @@ static inline void set_page_private_##name(struct page *page) \
 #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
 static inline void folio_clear_f2fs_##name(struct folio *folio)		\
 {									\
-	unsigned long v = (unsigned long)folio->private;		\
-									\
-	v &= ~(1UL << PAGE_PRIVATE_##flagname);				\
-	if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))			\
-		folio_detach_private(folio);				\
-	else								\
-		folio->private = (void *)v;				\
+	if (folio_test_large(folio) && folio->private) {		\
+		struct f2fs_folio_state *ffs = folio->private;		\
+		ffs->private_flags &= ~(1UL << PAGE_PRIVATE_##flagname); \
+	} else {							\
+		unsigned long v = (unsigned long)folio->private;	\
+		v &= ~(1UL << PAGE_PRIVATE_##flagname);			\
+		if (v == (1UL << PAGE_PRIVATE_NOT_POINTER))		\
+			folio_detach_private(folio);			\
+		else							\
+			folio->private = (void *)v;			\
+	}								\
 }									\
 static inline void clear_page_private_##name(struct page *page) \
 { \
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
