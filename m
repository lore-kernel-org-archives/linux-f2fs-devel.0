Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B1C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZQi7TdYvS1pegV5SvL8v9LYZpklPiCxjJoUcz3gpgAo=; b=X6rQIocd5PyccOVNqL2wLjW9sf
	r8SjkRY287vZLEQiWoByQqOPcYOuhZbpPV0hbUepGTldn37wsRK+G7LV2vQr6e96ZE//8fyZnn1DN
	rJgHmjN05xqGY8UfPuxBNMw04Hb1+KXLhBH2ZOjFpYKUZVKdPSguKThUFcU86Urkh6h8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxRWK-0002Rd-UZ;
	Fri, 21 Aug 2026 15:51:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wxRWJ-0002RQ-LQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Jj+k2WW7Ih6FQcK6i98I3wEs6XRWgiyHFOfmqApElc=; b=gyYJW4ymuZmxfB/GX7plCjTAVD
 FY9+rr2q6IqoY/nJ2K8MOh92vX/b2lkWNv/t5f9SQuo00lw49kP2L6/WgE42Pq/bKQ9jEQkzLoR2/
 /s7QWKzGbT564snIbGc70NNF/+wwMkcUCMnHk5UexL7dbuKXmvi1IgLQdHPvoTCzg+jM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8Jj+k2WW7Ih6FQcK6i98I3wEs6XRWgiyHFOfmqApElc=; b=b
 zOGP7OID60TnNdL3O1/nUHJ1mksl20OzYOPmJxbszHjqQjcmvepm5AEvcP6YQRVyX/sYrBIFTLwD5
 7tDOIvBrQl+iDX5ZwAHl83rEweeAh2mB3FyQQ3esZha+roar6yKi2IAN2V9Xl7agMJMiAC/wdC+ig
 Kad4KyhP4z7Pr8nI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxRWH-0005Eo-Gz for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:51:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2855143C87
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF041F00A3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327456;
 bh=8Jj+k2WW7Ih6FQcK6i98I3wEs6XRWgiyHFOfmqApElc=;
 h=Subject:From:Date:To;
 b=Yikukqrc4l19NryOt/PR0P9DjchjjsIbOqufY5/MdiDCzrfs6IHqtHyv0cagahkTu
 jSPyaPChZtA9s93GhPYtaZ4mQFea7Yk4Zl5vwYsVrOnojKxmZP/0MRysaOIA8p7Ki7
 gi+xgyNW/jkSfHWTnCKQibjfvg8nZng9VyyrV6BG5lCOa5y1/Iv4K8FvuQptHce5zt
 oHc9HDgvI/b9aBLTWxlh3TRLWW0YQvWR/gdC5ez1ocUUh6zEq6AIP5g9767dCCzTaV
 9GfL8a364YZvh6ZJNcXQEZeQm8eYn+U6Bo5zUZu0gh1lRU8ehtpokpr0VR84YuZuEx
 R2E0J5UZMnkzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D3B96380A979 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:50:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178732740553.1339488.2751032986638102328.git-patchwork-summary@kernel.org>
Date: Fri, 21 Aug 2026 15:50:05 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wxRWH-0005Eo-Gz
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: use f2fs_{down, up}_(read, write}_trace() for nat_tree_lock
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1147165
  Lore link: https://lore.kernel.org/r/20260817111916.1648354-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix error handling on device alias check in rename and unlink
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1149850
  Lore link: https://lore.kernel.org/r/20260821141742.2678300-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: fix to reset all pinned status during fggc
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1146902
  Lore link: https://lore.kernel.org/r/20260817023927.1066935-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: fix i_size when pinned fallocate partially fails
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1147913
  Lore link: https://lore.kernel.org/r/20260818145535.449055-1-zhanxusheng@xiaomi.com

Patch: [f2fs-dev,v2] f2fs: avoid setting SBI_NEED_FSCK on transient resize failure
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1149226
  Lore link: https://lore.kernel.org/r/20260820164340.2802152-1-daeho43@gmail.com

Patch: None
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1148146
  Lore link: https://lore.kernel.org/r/20260819013107.3542105-1-chao@kernel.org


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
