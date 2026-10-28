Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE606A753
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eOmbXiex;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TYhC7trt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bVrVxJG/;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yi2kDhPw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Y97es4tqXM+cvkesvVBggq1ii+OH3fehn6p7d+pkulM=; b=eOmbXiexTuNqUkyJlD56koI6TL
	LT1xjCSyylQHtQrbXQo3oW9iqX9FVebXeZplxn1KCdgTF0Cm522zLCfFLQ13Yv8zSkxS1ftEKMNO2
	TZAsJsnqTuFd5AWpYgRmuLgFzppdpwtbZCVNdHNz1SwkKgxqQxYVV6W6H2U3AFILBI0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pw-000000001ut-3Rsu;
	Wed, 28 Oct 2026 15:45:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pu-000000001uQ-4AiR
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XM0jR06s6rdLGcgQm5ZLC/fvjjLeMmVO4kpVbVF/Sgo=; b=TYhC7trtY4MTOUlNfBVCoikQCT
 Hps81z/TxLnS/lQMP6XvOVt2Q8eEwaCS4XtuYecgIql0XWRZXHIvhrFMmsPmkJnNXGnShvXnGLwSx
 GPYfooCxBhBltK2UW8ILYrFktkoVQQlfleevpscHfD+TXOVVXAbsQDVevwl8+prftj0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XM0jR06s6rdLGcgQm5ZLC/fvjjLeMmVO4kpVbVF/Sgo=; b=bVrVxJG//K9KLBhZFQV4vCftI1
 5/sQtMzMEDhd9wbHXtKmjjBbYzeC3j+okKhkB4xa91Uu2QwB5hYk9gZKU4u5NJOQG3EnD/yEDPqXB
 7SwAMGzM8kNP0qAM1/Ki+3GiHPGKw2XZTbE2lapKwxdrhQS7gN49n56Hp6F/FK4uSfTA=;
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pr-000000003aI-42y1
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:10 +0000
Received: by mail-pl1-f193.google.com with SMTP id
 d9443c01a7336-2e987b4a710so11069315ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202302; x=1793807102; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XM0jR06s6rdLGcgQm5ZLC/fvjjLeMmVO4kpVbVF/Sgo=;
 b=yi2kDhPwUthCI8kBm0G8kN7s3qyc0VvJ5x3+hRRa6XjC0+kCc1QX536lZjGjzQpRT0
 ZIZn1B/DwZvFjNk+QfFW35rc+80A324CDsbwSD/xOR4F9cG6WZoXnFw9Yd7tZ2xBrRil
 EkEFq+pJ/zt8ZUMwVJwDwXz3UBEbaLAY2D5UEj7mKBiu96alAz0pMhyu/900UByahrmh
 K1ojEqUQXDHAOGu/vzdvgp6e5qPZ1aw8UWTituSESD+81rAn6TIoT90y3xwuwwq+XE4v
 2KKckPsns4SIM3puXO4bRU68TQxSxoq/y/IlBUnMVVJFyOGyyDWZWLJp2hqtokpWktOL
 g7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202302; x=1793807102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XM0jR06s6rdLGcgQm5ZLC/fvjjLeMmVO4kpVbVF/Sgo=;
 b=SNUOwjRDFPTv6COySPQqms/QRq51nYfGe6AIpbiknW61cJsvX0PZgaTLmQHXKoOg6x
 2zzOxxoDssQ4wpuSyjGwiL5Gy3K++gZKSizP+QtO7dkvAPEUXdnBmXx4EKIOBaOXYDha
 LN60mfVg4jma13C+YOqCWrmiyKQc5UjenbXaQT61eXA+n0DrWhFTvls8pDW6X/Gc1qmK
 VYLwlRFJEefZtzFD8yUfArs4uzKQu4t1DZz0Dulzn3dNYIvXUJS7btuV2anbpU893ZSh
 J82U4b4AoR2HDiW/8Dggh3f2wET8WFAm6P3WLdX8QtdP6EwvH+8noK+p1ovM940/XdTG
 r0Ig==
X-Gm-Message-State: AFq9FYJu8dM47ll0OiG36kuA1ak6gAT45rvfefY1g0G6HOlCSEvdmM4G
 LziR/KjJ3u5tybvSyaOBOQetH+c+sAUNQM4c9GeHsjn4fOeYSUk33MznELPzu9/BtSs=
X-Gm-Gg: AYBFou3Vp3pUINJVHtfKj8CZUfXcc/uqJfMhMNPGFRB6xKmbjVqhpPVl7WixF5Bs/+l
 MCiLnRrMnkqng0n1+SpY4GyDhsQOz+cErkSGN+LWo+ZvDPYuR/nax+lc6p7yYzLG7p/ARMKLZON
 3pnW14gm48MOOMZ5VgWrX3MymFvXjXXWXfxgvPB+m8awBXr23PiUxBC74uKlFy52oX4ldp4AsNt
 ShUNkuQN/0uZImiCsWs8D1yWKnimvHs1l5qDLMdt04WbL+Nn113N99I+iXdrum8iYb+OVwf+IXY
 K+ilArxTfjTit5FlFL3/cFam6E5M6xB/Ha0tlhm5N1HOY8cjh7HuaEUierRoOiwnElOdSFmJiUM
 l2ad/iReIcIpfN6tbqCudnOK5W0dTllbkTJTFhMGpGmz+QDoCyhbNaMjvCPNnmTMWobwOZLzk/W
 HdJp2ef6aWzsYI1b6qdwchhWi0H/h0urrrM1QhS64adjWalMTFZT9QKR/Sw9DqxmdxR5QRH45li
 FlW2VWPfPzEr1WoKiqWVZAyeU8QRXHKxB/MK0ttqoW6FU4BTV9Qz2f9KnL4+ZN0xCPoNWS5g0h4
 3EBjvQB3wI4pcUzVU7RvIiZZVggSeQeJ2NSlXTRkYGfkbbEaiTe0h4gxWbRyI0qXzkhjIJWiyjH
 jBNZqFuCVV6Vf
X-Received: by 2002:a17:903:2446:b0:2ea:238c:4cfd with SMTP id
 d9443c01a7336-2eae3f4f44bmr37405825ad.25.1793202302121; 
 Wed, 28 Oct 2026 08:45:02 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:01 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:00 +0800
Message-ID: <20261028154407.1601430-10-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pr-000000003aI-42y1
Subject: [f2fs-dev] [PATCH v8 09/15] f2fs: optimize small block size large
 folio read
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

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 039916bad57b..d2c9e9d2eb9c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -164,7 +164,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (f2fs_folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
@@ -3173,7 +3173,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3197,11 +3197,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	folio_in_bio = false;
 	index = folio->index;
 	offset = 0;
-	ffs = NULL;
 	nrpages = folio_nr_pages(folio);
 
-	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
+	for (; nrpages;
+	     nrpages -= len_blks, max_nr_pages -= len_blks,
+	     index += len_blks, offset += len_blks) {
 		sector_t block_nr;
+		unsigned int i;
+
+		len_blks = 1;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3230,13 +3235,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 got_it:
 		if ((map.m_flags & F2FS_MAP_MAPPED)) {
 			block_nr = map.m_pblk + index - map.m_lblk;
-			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
+
+			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
+			len_blks = min_t(unsigned int, len_blks,
+					(unsigned int)(map.m_lblk + map.m_len - index));
+
+			for (i = 0; i < len_blks; i++) {
+				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
+						block_nr + i,
 						DATA_GENERIC_ENHANCE_READ)) {
-				ret = -EFSCORRUPTED;
-				goto err_out;
+					ret = -EFSCORRUPTED;
+					goto err_out;
+				}
 			}
+
 		} else {
 			size_t page_offset = offset << PAGE_SHIFT;
+
 			folio_zero_range(folio, page_offset, PAGE_SIZE);
 			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
 				ret = -EIO;
@@ -3256,9 +3271,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 
 			/* set the bitmap to wait */
-			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
-			spin_unlock_irq(&ffs->state_lock);
+			f2fs_update_read_folio_pending(folio, len_blks);
 		}
 
 		/*
@@ -3282,17 +3295,20 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * If the page is under writeback, we need to wait for
 		 * its completion to see the correct decrypted data.
 		 */
-		f2fs_wait_on_block_writeback(inode, block_nr);
+		for (i = 0; i < len_blks; i++)
+			f2fs_wait_on_block_writeback(inode, block_nr + i);
 
-		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
+		if (!bio_add_folio(bio, folio,
+				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)),
 				offset << PAGE_SHIFT))
 			goto submit_and_realloc;
 
 		folio_in_bio = true;
-		inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+		for (i = 0; i < len_blks; i++)
+			inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-				F2FS_BLKSIZE(F2FS_I_SB(inode)));
-		last_block_in_bio = block_nr;
+				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)));
+		last_block_in_bio = block_nr + len_blks - 1;
 	}
 	trace_f2fs_read_folio(folio, DATA);
 err_out:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
