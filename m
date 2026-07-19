Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9C6C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 08:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:Date:To:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DYJDFHNVMhQQRO+I7u/UmLi2bHoOm4KR/kN95P2ntGM=; b=juHfs223sQQmktQwZZjPLcD8Qs
	ro6TTzgAw2mFJrnJQmEPnV3p721gABPftpfdm1l48le1QYcgOpAxArHQb4/SXNhlLQr/b6BQyXuYP
	N6wYg1R6+FpSeTG+lRNdvLGMBiJQ+6r2KEq/kY+TbIeM+BT3fhdQoonEubusuyQ5JtIU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlNAh-0001Wi-8t;
	Sun, 19 Jul 2026 08:46:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wlNAf-0001Wc-Tb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 08:46:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dUvX8gecFJ2u6baMcbOFCOLfemTBHpSn5RLuwC5A4MY=; b=j0xeGxgg85k6FVrUKK96ht9V5I
 jOlGLHLTp1UDlIGpDbGde9EwzK3lGYTux/o+6gXcFJSKM23mtlWg3xfMb4pkCqdWAHsDBA/Kl7RWe
 qJw8uwrf/pJ0ptK0rR8ymFMCjo3tklSotv5grgZJGhIrXULbWdnC8PZPyTVSxjqKKogE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dUvX8gecFJ2u6baMcbOFCOLfemTBHpSn5RLuwC5A4MY=; b=DG/Z0XzcgwFtU9Zxoi+onuEeTp
 gMK4QWw8E9nfOHb82wtgN0bBJgEHFikV3LK3WoEmRky89xVrHnpOyaSPXOTTLdeIrtZufj6aDuWzw
 3K4C0YE6jRm0EJPY6BbKWoUeALWj/rT+v8DyMB5oPsBAxO4OvrofojTPFajwIKPWETO0=;
Received: from out203-205-221-155.mail.qq.com ([203.205.221.155])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlNAe-0003k6-OR for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 08:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1784450798; bh=dUvX8gecFJ2u6baMcbOFCOLfemTBHpSn5RLuwC5A4MY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bar7Xwc78320tfjNJ/uxsDQVlCk+X1cjtnrqahH2+aJXLoV9JVz8RPuEABKLpC9IQ
 K8DMNBigzAFftjVV4pLx4Zdr5DA/1UnL17S6vemF9uoLGb0LTxHwfD7sn6feUL1zii
 bTarjxBJt8U4dHlUKn9CB9gSHlzlJKJT+kyRxl4A=
Received: from ikun ([223.65.85.165])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id B5213A5C; Sun, 19 Jul 2026 16:45:18 +0800
X-QQ-mid: xmsmtpt1784450718tarqiyoj6
Message-ID: <tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ7hi3npMz4REHgCb43EKtDQcpCCg1bQ7BYSLYUEYMA8MwGdlBQa
 CGDza58dQ51c+W6O3yQ+6bbyo4iVMbPjZn0WhWxzXcvyFzOYh5tNVCbtybO9WfRPfppBNls9FKSh
 vKGUorclOfrnjnlWA39oxDXYWgfbeYVi8dvDAGuGYHXg5cPrxJP3kP8J528dOpkVWOwF7O10e36u
 gj5VtJpcRgsUH4pZFH2PMZsxvDwMMuEhIujpzF4yEiAcHpIjK//zziYJa0n036O0gquYcoX6tRkV
 T+9je79OaQNohcLOu/+lQh+ZQcBzL5Luldf79Y9g1WCPLgTrspXxyThK7Ue8eeIMOn9a4bGfGxU4
 f6knND1sSWModBTxyb7t10O3eGS/Bvv6LbSdMOqn3KGy7jy+luIeX3XP9vhecFe7kzI7+q5bzocR
 Xs14ys/PnIC5V2JvwdrLNQH185aA08Fp5up5/Utv7gPE1clIwt48QqD2WKtuJpbgFD601meVpDbj
 nfywIBffOOViqw8IpKuCKvmiHyaLXXKfikr15rb8bzbK2Y79iWJ3zlh0pcsHmxyGfTuwfSVfiMJ2
 qndRrYXkhzn8GHb4/iKDwLvkHlCY10D53QvzZv8hvWh5hHJZfEC7pbSxtVfwOVUtWly5dcXbGU9E
 GsIn37mdgIfFGoc77ZWFP3Cj8CckX8cmlGvzUiDq/goSm4DGEtenrGvUKDQ4zE6ldMVS1Q9uu02s
 hA+mMG3pK674ap00vKIdSBA0W1fWyOvMCDC7RyvrLgojs0NBY3o2fFBOWNfTPRztnPQmzs5jRuaI
 4yoisfKKG1tQqZo9obDv5Cj7FqvjClk1aMqa6CtyyY3EGY7nOG2Eeq3dxzoj9Eb5Oclia74mBvEN
 Qy+b1V6OFXncQmzUJvpZ3b1GPk9i5l2NCp3Kc7GtBSFodVX/aq62p+dshdt+1Grf7xKT7JEyezGr
 2sBCiMYpm1GnuwXu8n06SMYgX4rA3BipwPwDano+V7tFZeeh0ZeGYZJXo0g/siMjVpOnjMKzUnZ7
 JffUkSZL2YtwxwbUK2YjEJ0ABLsnY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
To: jaegeuk@kernel.org
Date: Sun, 19 Jul 2026 16:45:14 +0800
X-OQ-MSGID: <20260719084514.586-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
References: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
MIME-Version: 1.0
X-Headers-End: 1wlNAe-0003k6-OR
Subject: [f2fs-dev] [PATCH v2] f2fs: fix dentry folio leak in find_in_level
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
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

find_in_level() gets a dentry folio with f2fs_find_data_folio() before
calling find_in_block().  If find_in_block() returns an error, the
function stores the error in res_folio and breaks out of the loop without
dropping the dentry folio.

This leaks the folio reference on the find_in_block() error path.  Drop
the dentry folio before returning the error to the caller.

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
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
