Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B2C54E58
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:45:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rmJri-0003FD-MA;
	Mon, 18 Mar 2024 20:45:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rmJri-0003F6-63
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Wjq/kWiY3L7E/5n8CGwccRolJnvJKd48b0skZ/VuyA=; b=aeOo+AhbKqdVUTDMOOb8zq0ZhO
 2Z/2ceo0thw6oUO2u5bDieqvKKRo1/js03Kw5ccOa//VAbQCoAA06ryGP0rPoKr42kD38DcooM2L9
 i5JwpCmE108tCF7he8+F8k5SVh63FaMqAsKmbn/3CwCuKkGQd9QqYFwNpKcROiJ+s/L0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7Wjq/kWiY3L7E/5n8CGwccRolJnvJKd48b0skZ/VuyA=; b=X
 pmYC5fN4DOJzNmHnmPqQLf7uD3YZ5hUePuiCPbfjh+cg6runtYhj+Uq1A7xSxG/5+JZFsiwMZuOKN
 SkeS94BSYbHJm0m9ATNopkK2afx6qi88zMIKwaArpxO9baXCTchFHtmFQP0xGQhsP1bnHHpJnw2Yy
 NxgajkyzhdIPXa+w=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rmJrW-0002Jh-Bq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Mar 2024 20:45:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 061B2CE0B68
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Mar 2024 20:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3817EC433C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710794733;
 bh=l4KjZ0+MDTvRiQX2SDkXIKf95NCeLdyM3pKybHbNr10=;
 h=Subject:From:Date:To:From;
 b=ESIZAUJe6gWjh5utdTongMsmVRWcbJDMluXSVyS4aDIHxXHuc7V4Gwx2VexFHBEBU
 VTQkgw8OfpuI5Owi84+kdEcebAZ/1w0dzgrkJ2zv1lq+9pQqxIu62KGsRSJy8vFNCj
 RP4dqrS9CcBXM99uyqD8Vwzvq54BBs+me7GHOaGyv+0Q+z4dDLDV6yHzOWByzgLNIk
 JmajrzIRXyBLsCLmVpfop+8+lfW/2JhxU2rK9wPAcJV7G3bgZohXUs3otWofBQ7y9U
 qk2GiIzrAiYv2VLSwFMllnVL+GpAGeuFdtcXmdmD4pIzp9rRTXmhzAnMJDZZtnVuP6
 fc/YdXVtl+2kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 24AA317B6477 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Mar 2024 20:45:33 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171079473309.25373.5641181802344355105.git-patchwork-summary@kernel.org>
Date: Mon, 18 Mar 2024 20:45:33 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rmJrW-0002Jh-Bq
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: block: remove gfp_mask for blkdev_zone_mgmt()
  Submitter: Johannes Thumshirn <johannes.thumshirn@wdc.com>
  Committer: Jens Axboe <axboe@kernel.dk>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=820775
  Lore link: https://lore.kernel.org/r/20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com
    Patches: [f2fs-dev,v3,1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
             [f2fs-dev,v3,2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
             [f2fs-dev,v3,3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
             [f2fs-dev,v3,4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
             [f2fs-dev,v3,5/5] block: remove gfp_flags from blkdev_zone_mgmt

Series: Set casefold/fscrypt dentry operations through sb->s_d_op
  Submitter: Gabriel Krisman Bertazi <krisman@suse.de>
  Committer: Gabriel Krisman Bertazi <krisman@suse.de>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=828378
  Lore link: https://lore.kernel.org/r/20240221171412.10710-1-krisman@suse.de
    Patches: [f2fs-dev,v7,01/10] ovl: Always reject mounting over case-insensitive directories
             [f2fs-dev,v7,02/10] fscrypt: Factor out a helper to configure the lookup dentry
             [f2fs-dev,v7,03/10] fscrypt: Drop d_revalidate for valid dentries during lookup
             [f2fs-dev,v7,04/10] fscrypt: Drop d_revalidate once the key is added
             [f2fs-dev,v7,05/10] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
             [f2fs-dev,v7,06/10] libfs: Add helper to choose dentry operations at mount-time
             [f2fs-dev,v7,07/10] ext4: Configure dentry operations at dentry-creation time
             [f2fs-dev,v7,08/10] f2fs: Configure dentry operations at dentry-creation time
             [f2fs-dev,v7,09/10] ubifs: Configure dentry operations at dentry-creation time
             [f2fs-dev,v7,10/10] libfs: Drop generic_set_encrypted_ci_d_ops

Patch: [f2fs-dev,GIT,PULL] f2fs update for 6.9-rc1
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=836164
  Lore link: https://lore.kernel.org/r/ZfiBt0gRe_Elp7hE@google.com


Total patches: 16

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
