Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF72CD98E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19RTRE05Lv3DKKLo4o2b4EkGEDeE8r8q+B4pv7bLkMs=; b=m8nVPgtk4ABnTKUZ+PLFxlS6ad
	7LCz87rXVF77qVHfF41daOAY1IGSUIS3MLXLLQwIXEApl167VrOEO1MHpZNK0lGBAHna0RcCOuPP1
	L1TX+lBxhXMvSmc5PYnN1J4lXWhLgaqdTdJ0aPxj7wlHbURYyTKa7psJUpGv82reKRBc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoKP-0002fE-50;
	Wed, 17 Jun 2026 11:21:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKN-0002ey-8p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=; b=at7tZyDoPsMgZ+f3XrHntR7JZu
 mZ6Be4Yz/9h38jPVCoJP0GvlcDGzDuP1lqTzK8yJn1tLWxXslVY+O4t1BpevX9IEx8YHyr9/jI35I
 LZ3mIABMx1o86MIvoW0VGW66TYciKBOGPZmBcCrq5rQpjFFn2t9TbTxQ+gKiLT4a6qz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=; b=GhyAHY8SpQpagyvEu5j5eKe4DD
 yb0v6Ds7zcl8eq6JSu/6Oy33XL1YxBMWrJiPYUtTs2zGKiTvZVdLHQTMaKX91sG9enuqWHM6LUmne
 D5VNMR7kssH9yRLpHc+fZygvSt1Q/Ha0Xh8KlOx4Kq2lqsjFc2B1VJdDGESyjm35X4RQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKL-0002NG-V8 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DBAD760121;
 Wed, 17 Jun 2026 11:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BE01F000E9;
 Wed, 17 Jun 2026 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695256;
 bh=H/ifHRev1KZt7zJcATaDa76vriuxBeCWHVdvTL8hqTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Lv26D56moyfzDjRSXP1h969cV8AgvYZ9N6st5AgvVoCbI7grJ+nuu2E96cZpLkujJ
 fCfjAoeLGwcg2Up76V7nMIxDz8uXtv1f+uvfbgEFI4NiZBJRpKSCXB+691y1wO+/he
 IlpoZKSO7qQSouDyMJev/ycppfktDcR34RxiPRQ/sahCYrYZIs2gYs6aao44sMmeFR
 D3MaO1JSIGWwZ2/0wiSf0M2PUx7tpXGw2a7r7bGmA+bxRiexde2llQri+ukVrmGiks
 /CMxwH+duzWuwQ4e2YqAJh32OFRp1KYM3egdns98DgBG84DsIChKcmPKSGsyTJgIaZ
 6pYRzqZ7vt8mg==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:30 +0800
Message-ID: <4cfac83869d90a41ab6a1c01ad2b13ad95430f4c.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781694879.git.asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZoKL-0002NG-V8
Subject: [f2fs-dev] [PATCH v7 03/11] fstests: add FSNOTIFYWAIT_PROG
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Define `FSNOTIFYWAIT_PROG` for an upcoming test case that uses `fsnotifywait`.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index d5299d5b926f..5661fa0ec310 100644
--- a/common/config
+++ b/common/config
@@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
 
 # udev wait functions.
 #
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
