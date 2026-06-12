Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E391FCD98CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hmKi/AaftZdFboiHjVsqwe9ww3VUC1U7RnLdAyoK+z0=; b=mATjdwn7PYbaehcdB2IgyMMfZs
	aBNoaDdlp4IRlNgIJ6Mz8tgS9I3NGASozrcML7FGRv4fcNWpM8tLJZHzhEwuea985s/iLj2iWrbxn
	CQyJsAgqLeOBbl2uun/8Z8DBl4gjOe2TiSb8O1fdmJ3/G1Mfoo9gC3Rdxn9uZQWgvOA4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wY0Xi-0005Iu-HM;
	Fri, 12 Jun 2026 11:59:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wY0Xg-0005In-76
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=; b=RzrFUwIROaq9uba1YUaWwVi089
 XzmVCXAlMZcOBYv363j/UEiuNXraAta/r1lIfU5OmaZBWc+7Z7vzQW0LS5HV79+mOviDrLD8G1H1G
 n45Oj+nNDmi61nkKt4jFyk+y6JVCSQNeKxkE3lP1NJtVdEBuvkGvwKP7KNMPwhWkD6z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=; b=N
 EhwhDPVJ++qztNMmyso7SwcAU6a8UNPv0G8qI8JR955z7vQpwsOIL5ggAxnbWxQjERc8XOYX5BCMZ
 dVRMtLNq6/2BRqZnWGeNloZu7W8nSPsWkZlX+3haHC3aHKHYeM7GlqL4w6DDGcNG97X52z9O/DsgR
 DXZs9II5r700Vy8E=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY0Xf-0001kg-9Q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:59:20 +0000
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8423f420455so482430b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781265549; x=1781870349; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=;
 b=EuTo9dBHT25DJGFPXUTJn8XifgHw/OhJ9tHQPsH6ckDG5RmNonSb3u1jvWPhoL68V1
 cgqkOcnL56+rTzDF+CWazIOKA0KzxCPzf8l4r4uIVBR9lzNh/S0f56GCKE7cX3OnXYbs
 /8rUJ6owN72Py44Dsg+wE5dbc3C/kwpSOmMAh/4sYrGL638RayZMoR044wyFT1Le2Azu
 ndJeuN9Yz8p8j7TSWDzD/Rf8UQXuc4Pub5vNQ0RPCs0Vb4ABhG983VCPufvl25+9LFGg
 p2gQNrfh9HC/SD/+q2TAolyjP6rimAb4ivEs4Bkv/4Lg2mifBR+FNJpwPzzEhngpnDyz
 hZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781265549; x=1781870349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/KWFvfLBUuOEbqCTObm+8eedd4hBvnMS8TqsV3eqbI=;
 b=tZTdGNzY/XiGhR4uPed+56DESEYFjTDGmNou6xsCeeHMdZacN3ZO+tdiTmCEM7N+iX
 f9OamfdU6R/1z2jzGo32VvZEEgh+SxZNFHAPYkWj3q8nz72XemrHdLuUzlxynxpaf5Gc
 Zmg2liBW4odTKgEPk5LDlCD5Gx+oQrIWFbPTIUjCiYHbdDwaE9qxCcHrAS06JSmBwZKJ
 4EobVXSJ3Y3zF6ldiBRI3/NIfE5y8sCZp73DMmZeVu/Uw3j6J85WyaYdzfi+/0qcDJxE
 R/C/9W08VQ5SrAiDBgxolPOVVvdBA1O442Q8XOdXJ9P5iE7OlC857T0GRzo8etMu9TWb
 9GvA==
X-Gm-Message-State: AOJu0Yw/PtFSOJ7tsk09byrM/ca5hqjFcW0vHnLOcUgjDpQZ0HRYem0/
 nb6ZvVeSx8NFRWEkFMkVDqUGayegb4qDqZZJ4Yvr/X6sZzsAFqfBB7qJ8vLdjA==
X-Gm-Gg: Acq92OEnHKdBkcCJnz7AyRi2Wg2bAgZQ2Nke41Fdfp+JEhcS1JPE3cXSRewYDciEw0I
 WpttsAfk0Hltwcl0mHOSzyzmE2xB5iByoAnzFjmonI+xnGzvibS09VMa3RuJiNdet9uLGfDJzLT
 JNBhfLqB/RiVttLxmLSO9Bf3xSpCV8JVbIoHP61C51kKbV/xM2Juoy6fAgZNWuyMPfe/7uJ+zS+
 pHwr4HjjLM1p0q1dJcCTe/KJT0QtkylL3cwkTsGdLylO3Kd3Vpxm1gvkXJhyaMPDi4LO0nCDV4J
 gnNGD0OD2lOovQpFrIj/zue6QdOrjkz28scmXPvIaHl3QlUYshGKiLENJRCNNG266AUNOc+n4Ye
 WBFpb6tW5xSBnVf0caIAuSVbBQAWeqU21ASfoC5jYAb1bCeX5Kumb1Fub2D653dxM+fsX67ATzy
 Ufib2KP2G5WDJgjxJ23b5h/PymyqXZzINajVpk23Wycl2ec0tHBVp2sVrSYaNdg4wpGYcA2PhGB
 JTyaXtx
X-Received: by 2002:a05:6a00:3e29:b0:842:422b:259f with SMTP id
 d2e1a72fcca58-8434cd81502mr2537106b3a.10.1781265549037; 
 Fri, 12 Jun 2026 04:59:09 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434acf2ac9sm2131197b3a.21.2026.06.12.04.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:59:08 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 12 Jun 2026 19:58:36 +0800
Message-ID: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wY0Xf-0001kg-9Q
Subject: [f2fs-dev] [PATCH RESEND 1/5] f2fs: fix extent merge failure when
 largest extent is not in rb-tree
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

The following scenario can cause fiemap to report incorrect extents:

$ mkfs.f2fs /dev/vdb -f
$ mount -o mode=lfs /dev/vdb /mnt/f2fs/
$ dd if=/dev/urandom of=data bs=4K count=874 conv=notrunc
$ f2fs_io fiemap 0 1000000 data 1
$ shrink all extent
$ dd if=/dev/urandom of=data bs=4K count=150 seek=874 conv=notrunc
$ f2fs_io fiemap 0 1000000 data 1
Fiemap: offset = 0 len = 1000000
        logical addr.    physical addr.   length           flags
0       0000000000000000 00000002868d4000 000000000036a000 00001000
1       000000000036a000 0000000286c3e000 0000000000096000 00001001

The root cause is that when the largest extent is not in the extent
tree, mergeable extents are not merged, causing f2fs_map_blocks to
misjudge and output an incorrect extent list.

Fix this by allowing the extent being inserted to merge with the largest
extent. When updating the extent tree range, if the new extent can be
front-merged or back-merged with the largest extent and the largest
extent is not in the rb-tree, merge them before the normal lookup.

Fixes: 429511cdf8b3 ("f2fs: add core functions for rb-tree extent cache")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 61f6b9714366..aa368a01b035 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -702,6 +702,27 @@ static void __update_extent_tree_range(struct inode *inode,
 		__drop_largest_extent(et, fofs, len);
 	}
 
+	if (et->largest.len != 0 &&
+			(__is_front_mergeable(tei, &et->largest, type) ||
+			 __is_back_mergeable(tei, &et->largest, type))) {
+		/* 0. try to merge with largest extent. */
+		en = __lookup_extent_node_ret(&et->root,
+				et->cached_en, et->largest.fofs,
+				&prev_en, &next_en,
+				&insert_p, &insert_parent,
+				&leftmost);
+		if (!en) {
+			if (__is_back_mergeable(tei, &et->largest, type)) {
+				tei->fofs = et->largest.fofs;
+				tei->blk = et->largest.blk;
+				fofs = tei->fofs;
+			}
+			tei->len += et->largest.len;
+			len = tei->len;
+			end = fofs + len;
+		}
+	}
+
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = __lookup_extent_node_ret(&et->root,
 					et->cached_en, fofs,
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
