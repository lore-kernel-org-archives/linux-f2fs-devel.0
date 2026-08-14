Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B93AC5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wOnDf1BT1XXoSUv2bJJsjjZ5Rj7j69O74aeAJmf7NUY=; b=NecQYsGVuidHDYspk1NCkcZ2G/
	MUMEX7cadSfxkqU6wl74ix0hjhMSBcxqC2LTrr06rH4m0W6QhT17SR7AgKFtSd9tyYRhXE3RdZUHZ
	97+LVeKKlCOeh2FepAcbeTiHF+/cL8tWUp/G2B1elSEzRdKpQhzU5L7w/8030vXoBX3U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuv6W-0007Nb-Mb;
	Fri, 14 Aug 2026 16:50:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wuv6V-0007NU-Au
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OtKu+0FR9F6+wk9ms5Hg2inMMog2nT+6OnDgOfCcjrk=; b=B7DT/dmU1ESwhCXrrRyU9vQCe+
 sp2pt/vXkMCicUHXZaZJsms7PHeHQpuLdEDXRcJD51Tse5HxGQjgZ+AGOoHQpG43Pj1riz1+Ihwss
 TRnHQbOizrNKPwQ9kiw2j7iLnISXgk5zAzib6InRCXvq65pVzFw6ng22dDAfvKjdShpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OtKu+0FR9F6+wk9ms5Hg2inMMog2nT+6OnDgOfCcjrk=; b=VUF6v6Wqaeb0DP2GSpDAm9woqS
 BWIy15wmDBM5cRogierUDykWOBKaFcuAnEJGZVmXgm8UAmsBqJlEiWE4VYaIlGlzI9SAyzWJw/75R
 SRiJWGrFqtIEg5R7ZxMVcN/qbVsUUBvPQuyUTVXzlv8KaLOrGgkxhP+H8W9McojaZHUk=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuv6U-0007DD-Tj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:59 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-480001972b8so504830f8f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786726192; x=1787330992; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtKu+0FR9F6+wk9ms5Hg2inMMog2nT+6OnDgOfCcjrk=;
 b=clMqdk5dFLL687dxtWVQShk8GNjG3HrsO2MJiZhdNZz0wIcobucyKlEHnKsfOmc78N
 9/6bCe+D1BbH8nBe4tRihT/YRmV5LtIyZK3rtRnEZSJScr/waAr/aqcftKTabKaShAL5
 8+2MCVxvIldNSZKByuugQBL5+9nwJcsGl/2HUymNy+gjb8T36jt/AsEU8cHVc3RYC2lr
 QV9zJUCQBqm3GJ70NpZ7SrQ7LzkDi+UCV2uUdxbTsKw7VX0GtjSu+Q6inX3M1CbjC1hr
 fMAGE0ue2SJ47fzpYzeYMc3UFvd2mi+MO3krnBuO4G8+9Bu775bZea8G49LpR9VPxL2l
 /ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786726192; x=1787330992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OtKu+0FR9F6+wk9ms5Hg2inMMog2nT+6OnDgOfCcjrk=;
 b=IyEQSnC7dOOpqhHcjS5ctfQiVSS0JRBOu6vtLIITF5BHCCYvl1KB24V3BpIpphRxRN
 KqHSu4hDQz2onpGANP22YNeilMD1hlvXR9urJh5AMjFov6FAsm38YxVZyGife16T9UyG
 6+vdS26Hgm6bihk81CHzW+DGlAJ4Zb5xSdqtLYRhl8ATWuWieI8vRVF6uUL2bc0s7+uZ
 t8uAp8TgsYEfG4ffQIdn/TiO/8KqlDaQ7Q+Mg8aq+oHE9DDRrMTDR8A8kOWCdz85Qoyd
 mUITKfuIz+CH8KpczAb6p3b+RwUJ8hiH8xvb6RIP7VKkaZ+zrCIEr6h8LrHUHz0v2ScX
 l5Aw==
X-Gm-Message-State: AOJu0YzTvWlDgTpv3GLM0m21kSHxdXbJR5sYYnJHQWWO7D4Y6B/jbzmm
 9miOSbyxjXMqVcCvPGtRNMv2yOJ+Pok0ITy8waKV/hKEE4uWF6FhmM4bswlmYw==
X-Gm-Gg: AR+sD11GCBDIDTjCwHoiBabyVhbP9ud6KbdIRws/kQJY734xm6MFoqoyyqG82bURwMf
 owTyvmgm2ZpYPvBa144GfflL+5KEz8Q6wHc3EN5Fp7To8JTnBxBgQ3cW4oXuu7A2gSVuwxeCT+g
 1epOXlbJwZF6aYcF1BYw4LE0lfN+NTN78YLRVc8y5/dukEVpbNfsIum4eRhZy4pe1cEOBEBEdMU
 iHmW5/gq5jYbR05ynMq/dBt2qOWMH27+yX+OwSgALIZOV1Z4b81J0zlM8OQBpTLCIfg7xVuZ0vQ
 xL5gGD6TyZI9ag/D3MItDWy09EXjA3SSl0xG3CKe01VhLhEVeybIwK+8HoTRDkcp/ua5DYDgsrs
 TTjv6PO+SGHVjyf8VaOjsqMc8S12l36Qace7HxP08ujMP8sGNdsYHz3WbInD1dEYWtTtr07YaRv
 Qxq7YiID8pc3ACxTJ4NDv4GW3WlpKA0g9SUQkDsaFsPHWlu+nzcCAKCVQmS+GLJmhZL1YHXFAXU
 TihLZA67hedUouqNiG3ZG9yMcXLNE5glCI=
X-Received: by 2002:a5d:638f:0:b0:47f:9d0e:f8f with SMTP id
 ffacd0b85a97d-481607bcab5mr8659258f8f.26.1786726192330; 
 Fri, 14 Aug 2026 09:49:52 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm9021223f8f.21.2026.08.14.09.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:49:51 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 15 Aug 2026 00:49:27 +0800
Message-ID: <20260814164929.693412-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wuv6U-0007DD-Tj
Subject: [f2fs-dev] [PATCH 2/3] f2fs: punch largest extent instead of
 dropping it entirely on overlap
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

Previously, when an extent being inserted overlaps with the largest
extent, the largest extent is dropped entirely. This was done to handle
the case where the largest extent is not in memory, avoiding
inconsistency between the largest extent and the extent tree.

This patch changes the semantics of __drop_largest_extent (renamed to
__punch_largest_extent): instead of discarding the entire largest
extent when any overlap is detected, keep the larger remaining portion
(left or right) after the punch. This preserves extent cache coverage
for truncate and overwrite operations that only partially overlap the
largest extent.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/extent_cache.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 72e6587f76ab..aaad72fa1553 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -406,14 +406,31 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	return count;
 }
 
-static void __drop_largest_extent(struct extent_tree *et,
+static void __punch_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
-			fofs + len > et->largest.fofs) {
-		et->largest.len = 0;
-		et->largest_updated = true;
+	unsigned int largest_end, punch_end;
+	unsigned int left_len, right_len;
+
+	if (fofs >= (pgoff_t)et->largest.fofs + et->largest.len ||
+			fofs + len <= et->largest.fofs)
+		return;
+
+	/* Punch [fofs, fofs + len) from largest extent. */
+	largest_end = et->largest.fofs + et->largest.len;
+	punch_end = fofs + len;
+
+	left_len = fofs > et->largest.fofs ? fofs - et->largest.fofs : 0;
+	right_len = largest_end > punch_end ? largest_end - punch_end : 0;
+
+	if (left_len >= right_len) {
+		et->largest.len = left_len;
+	} else {
+		et->largest.blk += punch_end - et->largest.fofs;
+		et->largest.fofs = punch_end;
+		et->largest.len = right_len;
 	}
+	et->largest_updated = true;
 }
 
 void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
@@ -705,10 +722,10 @@ static void __update_extent_tree_range(struct inode *inode,
 		dei.len = 0;
 
 		/*
-		 * drop largest extent before lookup, in case it's already
+		 * punch largest extent before lookup, in case it's already
 		 * been shrunk from extent tree
 		 */
-		__drop_largest_extent(et, fofs, len);
+		__punch_largest_extent(et, fofs, len);
 	}
 
 	if (type == EX_READ && et->largest.len != 0) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
