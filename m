Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CDAC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TlHO5/fQEForHBlw1hPiSuU6y3Q5m3jf3ZBj7yBxUe8=; b=FDq+HR9rlD0mV60L4msADNAx09
	hiCQKxZuP4VGsveW4eQa2gr3aXU0op5B7jk/dtSZ9lRbVe+tMzNIIw4WAxbDhTLzMgWdL9uJWqjN5
	troxfFoM5GY8CuaJAQ0C9s320mnJLjJvPcAfW4ONTzhqE9sn922OhWrdmwHlkBvFj1Yc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjAIt-0004je-Be;
	Mon, 13 Jul 2026 06:38:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wjAIr-0004jX-3Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FhjgdXDXmVyJ2wLNBzBuxeJXJ2lhdZEYDtlsodvCRCA=; b=h2UB0jsJZi9h+5zHUXKe+UD2za
 0isbFiJScjIeT2YwGysIwTKXT/5f5FXwIDLowf5o04uv4ULngv/LUK2Z2awxxvwZrjk9DmvqeG52W
 hiQPNW26gGMI1HgpdpN3uNzkPwU0JfkzQO/SiD9YhMr9kA4tfrzHFY7RlsLWP4DHTBW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FhjgdXDXmVyJ2wLNBzBuxeJXJ2lhdZEYDtlsodvCRCA=; b=W
 hIp99IGqUEUlzX8j+Q+5Ew306JKdOhQC4jOEuZ60S5vCsVty3YMO4g+I/Sc4wxqzXqIIuYxmdbjJf
 93orH/fiymywbGpjH8WF98d7IE3LtuzXyU/CIV5wrtQNTh9QSZkGHHcjvYGc3mnC0QIkoZm87qAYf
 n6PtpM6NQTVXVd8E=;
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjAIn-0003S4-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783924673; bh=FhjgdXDXmVyJ2wLNBzBuxeJXJ2lhdZEYDtlsodvCRCA=;
 h=From:To:Cc:Subject:Date;
 b=alfGJxvDW4YzhLgAXVQxB9kx+vmNMQAahZGoKNxKqxIED7pKZj3vl0AE+00J1qAoT
 i+XnqgNEJJc3ZYp09gQ/fgSsHEsCSG8hNyz4/be+Ckxd7uEeHcRvTujoVK6mCw2hXH
 KgiJNyp/G0Rws6yutIK7QUJrpUQJaHtlNp0UA7g4=
Received: from ikun ([221.176.157.250])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 923052E0; Mon, 13 Jul 2026 14:36:35 +0800
X-QQ-mid: xmsmtpt1783924595tzzjr6jsm
Message-ID: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
X-QQ-XMAILINFO: NAvK98dRmgdfiiCaRQOVQDshGjlGplufJSt526rpBFw65LInAVG8EMb5Ka3D2t
 GoiG2aTTv1jL/EkkpwDjujnW0TRDlFXq4Aha/P2SmP/UkbaukIWD0qyJjqnsr7Wo5UxXUud8oIMu
 3kQKKjJ/byOPJlTiv8ifoomJ2k/rMhpA3zJAR+oVCdVXEb9H2deRoTkHHDETcFiO/pD/4akxiYMD
 INCRQdm87qM0+JfGxgZyG46cdU6zU8DoiKkRG8qnL1dKh1pJBbCTF4jL/8n4S3QtcYvMjLEVi67o
 ki7l2cUYWClek50bjk/YuKt7ynlRfJgoWLmoXXGjijP8UkYX37YZH2hJbhFXOqdn7sID3IUlBX96
 NoPY5RS+FpNR2bFDg+6ZRaN3j5mOSt8LLXkySOMGYEtT3cNjR0OlGuL+IVP/nZNYRNk/LT0rTnuz
 q6qgBvDwN8Tghc2Sb+N0QkUCZ1II4eHz9wLmSr+Wlx/n00UE9wP1ZgN7uyPVoxY81G6MdvG+kNfo
 +DaOd/X2Otn/WLLqKsEL8aZFSPL7N/PVczmXSrSu9vUmZRYpK7CzGxasDmHeUNfptqDD7/L3HNZL
 bOqTXbqoS9mRWjTSWy5/MdI4sxOs5/NDZBWaVGwn3OcytjC/+oHhrkGSGnMBw76tKFmBOWEhCn2w
 MDFX6x/IN5Hp4MqM4L4zPIl0HPKQ9d553QZTuCuKGpy+qQsPKuXj98BkG825gTD8yxyyKhSF5y9j
 uCk/RwLQq06VOmjWRib7eKbJBjMQvMDiJknCSYFs2Mm8wRHnyetTpproZuxcwp/6d7MaWy75NjID
 iJloqu1MVKFJBlyOM5wmYySMIMiRaoa6R/KPzthsERnnie7kdYLK097zd6yeZmJm8ZfBWb9qVXTK
 fCJ2v0Y+Rp4P9odGdNnVerCchV2gc/UKXZ+pay0+AOwXMBaQqpu+mIW+o/0P73YLlSNwOLd37bNR
 U0PcUnW0ODHH/Yv9rbQtU1yt3Hakk708tS9YCpunoS/8OOX8ANvOw2giOv1XTSDSI99xsnt9xRp+
 C7vbMjXgdSOWIWsPwnN1WkqDfpIc8T6iG4V3ir3BuxcxKWdVouZAiIkEONnbU=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 13 Jul 2026 14:36:33 +0800
X-OQ-MSGID: <20260713063633.555-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
X-Headers-End: 1wjAIn-0003S4-M4
Subject: [f2fs-dev] [PATCH] f2fs: fix dentry folio leak in find_in_level
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: Guanghui Yang <3497809730@qq.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/f2fs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..0562ad211351 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -320,6 +320,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
+			f2fs_folio_put(dentry_folio, false);
 			*res_folio = ERR_CAST(de);
 			de = NULL;
 			break;

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.52.0.windows.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
