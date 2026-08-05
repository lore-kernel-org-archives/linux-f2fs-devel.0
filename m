Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0C2C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DqfUW1nvj419URlHBSXChzJPYldylnMHhAawQPp56MU=; b=QFFRbidb20oZMiyINsteLs+6Vp
	auLl0HZ82gBbfaksYKdJFk4CK2OUyKLKtDR1uA9wk5UuMFdqPJvBpITfPF2T9T+4dg8KiFSIXilRi
	bojQ64czGZFpOlELZLhkHTELMBu3jOOZnThfzSlPIAapxMZ98Vrj6JsIFAC96WGftyyo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3M-00029u-0S;
	Wed, 05 Aug 2026 21:21:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3K-00029f-Dj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B1MTQKHuM+Rd12Njyz13Bl5DvR3Arz7WFHtTChr6XW0=; b=fPw5m5Pln/O1jTPUatsoZD2qnS
 MmN0XPoCvVaVGwIiAzg4t8QMTMyZgngxIsRUfIFxQBFPJefJUFi6s3RHFAWsIySKdA7ajTJTv3BuF
 ljiaKpajIYG9QPd8M5fXY2oVO+w7YtKfa8UVoF2IzXmJjb2S0V341/eyMavfXuJZTLNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B1MTQKHuM+Rd12Njyz13Bl5DvR3Arz7WFHtTChr6XW0=; b=f
 nCFECNFhEUE0HiztgLEcmRmkPbeG13kNOYAStb0ubexdcsL/XVNPyyQSsMxXu2TqVL75x6geDFiQ5
 0+lwOZKnjbIt3K/TNxhNwVy/U8TRiBQf6kEXpogRvL8Cxpezt586Ea8T+crfB2UISCn5Zf0rJ0yKD
 Hp50NbA2btrSaG9w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3F-0007AN-9p for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7141D43915
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545391F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964879;
 bh=B1MTQKHuM+Rd12Njyz13Bl5DvR3Arz7WFHtTChr6XW0=;
 h=Subject:From:Date:To;
 b=PlBhOn7qg1b6JSvx+OXd6bBHewYoq/SqekJUn9G+gnX9uDJMA1rKse9EnXOopw0Zg
 xI22D+5ScQ6rysy9AfTRj4ugpZXNLF/wohkjHBzyYBy2aYg3DjVln0jaPU9OzuMhrf
 S8Zu/YmQjQodJYVGL37YJFz2QO/osTnfZzceoAivcOkiFwz2HqIac89m4Wx5m1G89r
 F4d1qt5d4G710ye9cmz3dHptLZQY32SBQk9V4byEkXqJCZEYqe3019bhaf7lnWM3MA
 z1OgVhsH9TWjd8Iih9ayGRVWMYUvhX/XMwmO65UhVyJzXcL4l0faKSSyp0CSsDSAZi
 k0pMBCxMFR1rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56947392FFD1 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 21:20:40 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596483900.530543.17679523947672758525.git-patchwork-summary@kernel.org>
Date: Wed, 05 Aug 2026 21:20:39 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wrj3F-0007AN-9p
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

Patch: [f2fs-dev] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1128495
  Lore link: https://lore.kernel.org/r/20260716025908.608098-1-zhanxusheng@xiaomi.com

Patch: [f2fs-dev] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
  Submitter: Rochan Avlur <rochan.avlur@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1136344
  Lore link: https://lore.kernel.org/r/20260729041656.51967-1-rochan.avlur@gmail.com

Patch: [f2fs-dev,v2] f2fs: dirty directory inodes on mtime/ctime update
  Submitter: Joanne Chang <joannechien@google.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1115125
  Lore link: https://lore.kernel.org/r/20260623063428.222361-1-joannechien@google.com

Series: [f2fs-dev,v4,1/2] f2fs: avoid NULL checkpoint thread access in sysfs
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1139739
  Lore link: https://lore.kernel.org/r/20260804014849.1942326-1-qiwenjie@xiaomi.com
    Patches: [f2fs-dev,v4,1/2] f2fs: avoid NULL checkpoint thread access in sysfs
             [f2fs-dev,v4,2/2] f2fs: protect critical_task_priority updates with s_umount

Patch: [f2fs-dev] f2fs: fix to clear dirty flag on folio in error path
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1140776
  Lore link: https://lore.kernel.org/r/20260805122920.674676-1-chao@kernel.org

Patch: [f2fs-dev,v3] f2fs: fix valid block count leak on data block allocation failure
  Submitter: Chen Changcheng <chenchangcheng@kylinos.cn>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1139734
  Lore link: https://lore.kernel.org/r/20260804005402.13026-1-chenchangcheng@kylinos.cn

Patch: [f2fs-dev] f2fs: reject overlapping move range after len expansion
  Submitter: Hao-Qun Huang <alvinhuang0603@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1123585
  Lore link: https://lore.kernel.org/r/20260708065439.1139937-1-alvinhuang0603@gmail.com

Patch: [f2fs-dev,v2] f2fs: Run f2fs_write_end_io() asynchronously
  Submitter: Bart Van Assche <bvanassche@acm.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1139555
  Lore link: https://lore.kernel.org/r/4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org

Patch: [f2fs-dev] f2fs: fix to return -EFSCORRUPTED in f2fs_get_node_info() correctly
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1140757
  Lore link: https://lore.kernel.org/r/20260805122008.664576-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: print error information in f2fs_put_super()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1140777
  Lore link: https://lore.kernel.org/r/20260805122947.675205-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: Remove unused curseg_segno() and curseg_alloc_type()
  Submitter: Zhan Xusheng <zhanxusheng1024@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1116826
  Lore link: https://lore.kernel.org/r/20260626030728.1364795-1-zhanxusheng@xiaomi.com

Patch: [f2fs-dev] f2fs: only redirty pinned folios in redirty_blocks
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1135146
  Lore link: https://lore.kernel.org/r/20260727130430.2109181-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: validate MOVE_RANGE destination size
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1118613
  Lore link: https://lore.kernel.org/r/20260630031700.2573819-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: avoid unnecessary shrink in f2fs_shrink_scan()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1140758
  Lore link: https://lore.kernel.org/r/20260805122050.665256-1-chao@kernel.org

Patch: [f2fs-dev,v2] f2fs: reject invalid recovered filename lengths
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1139335
  Lore link: https://lore.kernel.org/r/20260803114153.1499527-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: limit recovery filename logging to stored length
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1118765
  Lore link: https://lore.kernel.org/r/20260630082331.2757376-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: return writeback error from collapse range
  Submitter: Wenjie Qi <qwjhust@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1134947
  Lore link: https://lore.kernel.org/r/20260727074910.1965988-1-qiwenjie@xiaomi.com

Patch: [f2fs-dev] f2fs: fix to avoid move_range and defragment on device_alias file
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1115361
  Lore link: https://lore.kernel.org/r/20260623124823.1674416-1-chao@kernel.org


Total patches: 19

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
