Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2CCC5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=faUJV/S7qJmrjLRwPDdjiou+3dbr1c7xRrPM0gvryLk=; b=MegFaSEe5x5JXhvBhOqtT71knh
	+Wimlf70tFoyiTtV8fTx1MSPWmwnrYMhKzqCyfHh0x5JzlOVGY9FyZ+G5/E41KkJYf1oVM7pQlmDn
	MXGphoBcYrGrrmXK9kCmYULQwN4N8ii/wvJNepShZEuoXTorXlyKXE8hgtZzxENhSYik=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuv6Q-00067n-UC;
	Fri, 14 Aug 2026 16:49:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wuv6P-00067Y-FU
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6M2k7V6ZJevzzzPofdHWAFd16WWvytUeVI/DEegh0rw=; b=c/m96kyqc91SfpOtSYf/+D56ZU
 ayW4b4ecB38oX+PYVm8prVXT7xaMfGF8oK+l6dCcQcgiilGE/kdcK5hiWLXgwSXd8TRO/D78u3t8y
 N6QytwXFL1ssfoPFF5a17qmhNHGDQChq4ZTrkXsSnwuVY4CFKR1gLvj7yMO1BhfDuSq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6M2k7V6ZJevzzzPofdHWAFd16WWvytUeVI/DEegh0rw=; b=hSrd8SGj3OhCBwQRfgqNrHaKOa
 8VO3lVr4/vo/jTPywng64ObOoKIEG1C7zH3WhmBsCtXQxr0G91k0qfRTRNjSJWMfDjMLkG/sSAm9J
 NypFau5h8JWsTA17eg4EzuDOSVpWC9jgtZyOMKgUvlWS9aqz2JprFDzx4FKIUxBdVsVA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuv6P-0007D2-PP for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:49:54 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9438145e9.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786726187; x=1787330987; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6M2k7V6ZJevzzzPofdHWAFd16WWvytUeVI/DEegh0rw=;
 b=JUr/e/GG8+0R+EJ2DMHxMunoyLoj7gmA524QGE4+Tggo4ysejf66oWxzY1nLJcaAr1
 ZPlzF++yH8d6mx9/kX57MP7ivZ0GzucBFbBR00svaDm3oiXDp++pcATo/vy9O1EJw4Hg
 zfbdMSQsmsGdLfAw52Gpq8kozZssselAY2FVbPAs1IgMkAAG9UTD41z+7wYoYC+Bqfdj
 mluGiAi3+HPZ7Wjy6vbB/YWap/rgrASx53UozUjoE2EMDfr6hcXd4neSqvptAZ0JGhw8
 nUZfu5emeXQEgOMoKt67iczmCah/NEyrprJAJ80XPNtx1013Wddbiw1MdC4s9uMEpDob
 W5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786726187; x=1787330987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6M2k7V6ZJevzzzPofdHWAFd16WWvytUeVI/DEegh0rw=;
 b=PUQASLorJyO32vxbaI0PspanKM2iCff5NKH3VDIJXSajD9KqMAGTEddOymNSm++d93
 mjLcy8Ls/NcAdlj5XRVlxlEarAo2b4liy0KCPSa9HdfU5KTit7SviTO5Y+7bVtxufKLP
 f96ri27FHspnUa+8RB3NFmIpu9TLwQpnTeM/Cs/BUPAMTUf/bohw0dddLDPeVTw5O4SU
 eht6gGPwtB5Gm+Iat0x8VAmFfpzKZAFo2T7beSy8nuSQenw7i48UtrnPsMJPiY/WqDPE
 WyUgkfmprMiXt5IjYOscCzw/hfe4CNLpv1sjLJgWZPK7FffK87eqqDhelgTTjdgkjkOh
 ifFw==
X-Gm-Message-State: AOJu0YyHOwrI2QuFuV7NGTqpyIjnE0yLnFvS1Vzgr7GyLwQERo4VFWTU
 3jLx9iL67NT2mMwqXy0rIOjSQICgStyJk8wrxWf9JryN3QqXGSeD8wFz
X-Gm-Gg: AR+sD11d3yaJxlp/2f0uJE0OA/y7Tm2kkmLanxJuSuq/B5600r17J/OQwGnYU8pBwIG
 tDBBcGU0oOfvL//tk9Owc/bI2lfUzjbnVAMiGHLq0SNxux3Hvj4CspiR0/WmUphhDGZTlhSj3a+
 ipNvkykrO0irz7e42A6t4V6BmcMlx8KeySG0ZfRYzA6FxxEBSGTboPseNdoiue+5rEpvm2CiwBS
 qQwCLYMABqLnN6MD4L44heNg3f2ZtIri5Z5aA5F5kJFJdghgJPEN0vtDlNLG1VS3ybi4NDAtDIB
 ao3lhd95miq9iG/zUhJbnW8B5fVWobpTgcauqQ3qFW04XI+doiCM3JK+BcG09l16X9SRzNpk/cC
 HVZElBGB297GL4Y1vxP+d9ri1CbJZhva8KO1bKlDkXpA59IybyEF9YppBT9nNo1SZWquVfOAN7o
 wIZC9xkDZY9f3jWbi3DDVSeKmc3D9hbe7jlzvSG3G2ThkvyZpTMC8ALh/3oBM3qDmDWYuOW31jA
 cedg/6gH74f/PKEilbBohOyT4GiOUcm6AY=
X-Received: by 2002:a05:600c:a205:b0:493:e543:1dd9 with SMTP id
 5b1f17b1804b1-499821b25f7mr151940775e9.9.1786726187165; 
 Fri, 14 Aug 2026 09:49:47 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1a91sm9021223f8f.21.2026.08.14.09.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:49:46 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 15 Aug 2026 00:49:26 +0800
Message-ID: <20260814164929.693412-2-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
References: <20260814164929.693412-1-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wuv6P-0007D2-PP
Subject: [f2fs-dev] [PATCH 1/3] f2fs: fix extent merge failure when largest
 extent is not in rb-tree
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
1       0000000000000000 0000000286c3e000 0000000000096000 00001001

The root cause is that when the largest extent is not in the extent
tree, mergeable extents are not merged, causing f2fs_map_blocks to
misjudge and output an incorrect extent list.

Fix this by allowing the extent being inserted to merge with the largest
extent. When updating the extent tree range, if the new extent can be
front-merged or back-merged with the largest extent and the largest
extent is not in the rb-tree, merge them before the normal lookup.

The merge logic only applies to the read extent cache, whose largest
extent may be cached without a corresponding rb-tree node. Reuse the
front/back mergeable check results instead of recomputing them.

Fixes: 429511cdf8b3 ("f2fs: add core functions for rb-tree extent cache")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v2:
- Reuse the result of __is_back_mergeable().
---
 fs/f2fs/extent_cache.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 37cf9fa8d537..72e6587f76ab 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -711,6 +711,30 @@ static void __update_extent_tree_range(struct inode *inode,
 		__drop_largest_extent(et, fofs, len);
 	}
 
+	if (type == EX_READ && et->largest.len != 0) {
+		bool front_merge = __is_front_mergeable(tei, &et->largest, type);
+		bool back_merge = __is_back_mergeable(tei, &et->largest, type);
+
+		if (front_merge || back_merge) {
+			/* 0. try to merge with largest extent. */
+			en = __lookup_extent_node_ret(&et->root,
+					et->cached_en, et->largest.fofs,
+					&prev_en, &next_en,
+					&insert_p, &insert_parent,
+					&leftmost);
+			if (!en) {
+				if (back_merge) {
+					tei->fofs = et->largest.fofs;
+					tei->blk = et->largest.blk;
+					fofs = tei->fofs;
+				}
+				tei->len += et->largest.len;
+				len = tei->len;
+				end = fofs + len;
+			}
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
