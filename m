Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14081C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kPbIhBoHShAUrQKh6Z+rq258R+WDkyv+sHPiyVqz0ok=; b=aUdFb+ALj34Z+CePpOO21+wb4K
	OwwPUpOBxBqe3v166cTyG7QtsJzmqcP4gkycxZdddSBrbaJ13cGlAr3iG83MOltqrWklF5FsMW3Et
	uf7sNsSJiye5p04jOFiRzBwjXuf2aCPum+lsaTK3ZxCuchCbGROA3WdbiHdCa0OBGxsI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wroDs-0008O3-Of;
	Thu, 06 Aug 2026 02:52:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wroDm-0008Nu-FN
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+emREkmLMQHBZB1YtQSWdNtRWoQppA9KHuAfHeyLu+Q=; b=jdaT0jhpMny9LoGjqTdXWmHd0P
 IfN8hkwQjSXehK9jRBfJK3DUDyjIa8zzgnjRS0IbObnRLHS/UUM45TbJTipyL9h3Og/Ebm9qaOg59
 XURCgg0uKerfDht72pQy46fWcSMI/vXv2M3pgF6+LqDrF1FYh7qk4aoIW8aEMQB/taCw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+emREkmLMQHBZB1YtQSWdNtRWoQppA9KHuAfHeyLu+Q=; b=d
 0wd2ia97wRxiqNalQRfHSxAC1ZnoYMtUZ2DDVrOPuog/eKapgHXMjY4+/ElzZScyr0v2RJKUaKvM4
 LP2Nxf6FD+jTKF1+Uyeo7v16mC3j1Mwcl2MsLWARLs9IhYNrR92Crg/IbetQCAOdbY3BgHhiZy0jl
 A+BoOVPbMxgz64yE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wroDp-0002sN-6K for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:52:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54E96438DA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Aug 2026 02:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520901F000E9;
 Thu,  6 Aug 2026 02:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785984752;
 bh=+emREkmLMQHBZB1YtQSWdNtRWoQppA9KHuAfHeyLu+Q=;
 h=From:To:Cc:Subject:Date;
 b=Ic8AMtdYiClHYdvvpcs6m5MMd6m4DKHOTJK2mkffcOrAiSR2XPdpO4InaMxskQqbi
 GMBPczLQWcQjAOl+FatjZ8hMKyVM2N59ErrOv9DReM1deI3q8wHQi21Xt9T4v39wXy
 wQBpmR5rAwnBMDgmhiXZfULGzar++tkuDG8tQnmEi0WtTVcLp16/6pPGk9gGbHsENU
 NmmWB43mxQHErd24hU0IthIg9cPi7GWQldKNA5c3jcFsI6f+oTdZ9eJLBnmfzwSV1s
 Cgh+7qI8TAO4wbS5JwVfkogXHqtQBZ0YQ9wqekuOfiJ65y311DcUNhBM7YVFac0YCF
 n1KpwMHYPhILw==
To: jaegeuk@kernel.org
Date: Thu,  6 Aug 2026 10:52:24 +0800
Message-ID: <20260806025224.2194078-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
MIME-Version: 1.0
X-Headers-End: 1wroDp-0002sN-6K
Subject: [f2fs-dev] [PATCH v2] f2fs: print error information in
 f2fs_put_super()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

So that we can know in which path we may missed to account the
reference correclty: normal path or error handling path.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix typo in commit message
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 25309e6d4156..5902b2da7ea4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2058,7 +2058,8 @@ static void f2fs_put_super(struct super_block *sb)
 		if (!get_pages(sbi, i))
 			continue;
 		f2fs_err(sbi, "detect filesystem reference count leak during "
-			"umount, type: %d, count: %lld", i, get_pages(sbi, i));
+			"umount, type: %d, count: %lld, err: %d, cp_err: %d",
+			i, get_pages(sbi, i), err, f2fs_cp_error(sbi));
 		f2fs_bug_on(sbi, 1);
 	}
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
