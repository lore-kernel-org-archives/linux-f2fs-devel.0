Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA1CC88E6E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HPGioxMQxc//3hwk9NbV7VPLUAQKa85n8QkZ529NrxI=; b=GRcudPjfmnIIRDX/sUJSgNcIay
	6yte5rbtdAReyQ/8h/w0WxK0QLju0NZGgDkwIXiipI3+J41mFz7neUsqforuLStKrXeNFltdVH0cj
	8Ta3kPOD2uXYP03F2p1rGQVYG1RPHNvXUTxcml40BmP6IPw14JK+4Ak08DT5Mhb2XxG0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eK-0004Yr-NZ;
	Mon, 14 Sep 2026 15:31:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eK-0004Yl-0R
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cc8HTBmuSNmmVhV8vyoYyhDH0U8WtI/jVLXD/eO3F2M=; b=LgoVHUlAfshQq6CJMzz/WiT/1/
 xgkVQcsrOzJJ/AzRolxfZRaFWziykRmch5e7c9tZjd8mfULCKD43xuLeaXRMzrU4920fe/Vi6wUoU
 c4xpXZK7YGQAzR0MNfiET7I1VmbIYU5CAnUPTSlEDq726yVd+WB34XXxtNTkwF/HL48k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cc8HTBmuSNmmVhV8vyoYyhDH0U8WtI/jVLXD/eO3F2M=; b=j
 xIl5UeMAzdYJlPKb6zDZJyqz8F1lHF64x4rLc+WJdP9SxLLTKZmSTXGhqtLl4XlNz78uyQH8joBcu
 SkZKudZCgeixirPrd/uVlCQoZtc3t3rXrr7yolROF81Ay7AtnPrSwIhHJeZ+QwQtKTZQzTtBYkwN4
 VEQGSZsB3aQkzK60=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eJ-0000HU-Q4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E97241387
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 15:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533C01F000FF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399870;
 bh=cc8HTBmuSNmmVhV8vyoYyhDH0U8WtI/jVLXD/eO3F2M=;
 h=Subject:From:Date:To;
 b=VNTtu7kG+WKT7mKmcnrKFJTUaBGtvdqTPU/UjWSuKXEcIVoXn2HY+gDFMz5Kqtypq
 9cwCc8X2OcNlHPv5iubv2VQEaUUyzBx5Eywl1CF2dHxZF/X+oP1FI1JiAN0B1GmoTL
 m6BkK92SuD2p53UePZYpffk0E8enXDUCk4Cy2zM8L8VGa/sINJchaa6iHpzZhTwbGf
 bU9RGQJM2wVJDNmPSj1s8SlIEb/FqtUrouozEzH43e1Xypd5PpMND/bwaC3quNg+v0
 1ue/V6jAH2hewN0fRvQFHj3kpHqBEl+DIowqoQI3fW3NcEYb6icj3ICMdIPqoc4SYX
 meD2XIN5w6PwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 961823924A79 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 15:30:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939980501.647967.499549681746217606.git-patchwork-summary@kernel.org>
Date: Mon, 14 Sep 2026 15:30:05 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1x68eJ-0000HU-Q4
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

Patch: [f2fs-dev,v2] f2fs: quota: fix stale lock holder on remount failure
  Submitter: Jianan Huang <jnhuang95@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161266/
  Lore link: https://lore.kernel.org/r/20260909114615.1390443-1-jnhuang95@gmail.com

Patch: [f2fs-dev] f2fs: force out-place update for all writes on compressed file
  Submitter: Jiucheng Xu <jiucheng.xu@amlogic.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1159677/
  Lore link: https://lore.kernel.org/r/20260907-origin-dev-v1-1-85ae7ebc8c98@amlogic.com

Patch: [f2fs-dev] f2fs: fix to record both APPEND and UPDATE ino entries
  Submitter: Zhiguo Niu <zhiguo.niu@unisoc.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161735/
  Lore link: https://lore.kernel.org/r/20260910030243.3005578-1-zhiguo.niu@unisoc.com

Patch: [f2fs-dev,v2] f2fs: compress: fix to handle race between truncate and writeback
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1162119/
  Lore link: https://lore.kernel.org/r/20260910141126.1309794-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: skip node_change lock for inline data writes
  Submitter: Seongjae Jeong <jsjlee1020@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1159083/
  Lore link: https://lore.kernel.org/r/20260906145614.2749-1-jsjlee1020@gmail.com

Patch: [f2fs-dev] f2fs: parameterize node helpers and macros
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1160392/
  Lore link: https://lore.kernel.org/r/20260908100032.3141988-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: fix livelock in syncing dirty inodes
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161548/
  Lore link: https://lore.kernel.org/r/20260909190636.3151580-1-daeho43@gmail.com

Patch: Remove PG_private by using page/folio->private checks instead
  Submitter: Zi Yan <ziy@nvidia.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1160106/
  Lore link: https://lore.kernel.org/r/20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com

Series: Remove PG_private by using page/folio->private checks instead
  Submitter: Zi Yan <ziy@nvidia.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1164167/
  Lore link: https://lore.kernel.org/r/20260913-remove-pg_private-v4-0-848550f7574e@nvidia.com
    Patches: [f2fs-dev,v4,06/16] f2fs: stop using PG_private

Patch: [f2fs-dev] f2fs: fix to avoid folio->mapping dereference in is_{meta, node}_folio()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161713/
  Lore link: https://lore.kernel.org/r/20260910022026.3301257-1-chao@kernel.org


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
