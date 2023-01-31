Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBC3C64EC3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Jan 2023 19:10:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pMw1c-0001zS-V2;
	Tue, 31 Jan 2023 19:10:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pMw1X-0001z4-3h
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b9yVM6lWLYviV/B3l+RWke0TQ7l8iuncLqiE1kduTsA=; b=ivpXCSP7nXvP3INOij6ZA4dwkb
 JympzbowMcjQWKqjYmU4d3S3cX60WM112r27m1vq6OqJ5xTDyzrkF7BytwPNZSy5GGbZ81hmUFJlB
 80n6P3+UeE2nYAaOhrmdxmm+E2jGJqOOXtYBHW+KzjhlvzG3Q2ap6mvR98H7t+rOO0M4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b9yVM6lWLYviV/B3l+RWke0TQ7l8iuncLqiE1kduTsA=; b=R
 QU1WBFF6Wd3wzdyPoMRfJbYjSxm+YTDZlbfVwwbWz+TolItQrYhAKClEVzMv8OdRwkM/vrswl7sKX
 3V48OX/iotIz5hDJJ4/RRT02MtyxFMsRlghhRNX/2YDlqJoTAoh6nUXni2HnJMoEpvZArsusVBB5I
 8pbo+jscbKx7Te7I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pMw1R-0006XF-9v for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Jan 2023 19:10:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AB59F61645
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D38AC433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675192220;
 bh=PD80lhW/veSpEcHn9WkUHTgN99BNqo+D92b7YCb5mq4=;
 h=Subject:From:Date:To:From;
 b=eF56a46d0gTdQSmbvSFmGF+TNhLvQl6nlNYQQyVR1hE7ikhqvHqXIs4KJN6g6yAly
 Z9BI/NCHjNVysmjtLsZoEw1vQ71cjtJhgYSQ/TWpo6aAW6QCS6q2r8fIJ+S6Vwp0Dt
 cwdcUX/IGkzSyGH2BrTljgQOKLRt/2FfiTWBLP+2j0yz9JriFJjhwp5Gy5NJ0s5P0I
 tvEpYmWdl411WMxXlDLdQX5bbnDoLNdjnyNmVSz9vt/E8QhdahrgOSksSXkZw4jxSQ
 g5WyhVYq03rAUd//qgeMz/OABit7UTcaZzB07wLYpGaBGGGVTXGNMoqLyp0oW4Xegn
 XCoCz0vshXxCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 F06DBC072E7 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 31 Jan 2023 19:10:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167519221989.20142.14322152430732793961.git-patchwork-summary@kernel.org>
Date: Tue, 31 Jan 2023 19:10:19 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pMw1R-0006XF-9v
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

Series: [f2fs-dev,1/8] f2fs: remove __add_sum_entry
  Submitter: Christoph Hellwig <hch@lst.de>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=713525
  Lore link: https://lore.kernel.org/r/20230119063625.466485-2-hch@lst.de
    Patches: [f2fs-dev,1/8] f2fs: remove __add_sum_entry
             [f2fs-dev,2/8] f2fs: simplify do_checkpoint
             [f2fs-dev,3/8] f2fs: add a f2fs_curseg_valid_blocks helper
             [f2fs-dev,5/8] f2fs: refactor __allocate_new_segment
             [f2fs-dev,6/8] f2fs: remove __allocate_new_section
             [f2fs-dev,7/8] f2fs: refactor next blk selection
             [f2fs-dev,8/8] f2fs: remove __has_curseg_space

Series: [f2fs-dev,1/5] f2fs: introduce trace_f2fs_replace_atomic_write_block
  Submitter: Chao Yu <chao@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=709941
  Lore link: https://lore.kernel.org/r/20230109034453.490176-1-chao@kernel.org
    Patches: [f2fs-dev,1/5] f2fs: introduce trace_f2fs_replace_atomic_write_block
             [f2fs-dev,3/5] f2fs: fix to abort atomic write only during do_exist()

Patch: [f2fs-dev,v2] f2fs: reduce stack memory cost by using bitfield in struct f2fs_io_info
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=716749
  Lore link: https://lore.kernel.org/r/20230130012012.2078978-1-chao@kernel.org

Series: [f2fs-dev,1/3] f2fs: clean up __update_extent_tree_range()
  Submitter: Chao Yu <chao@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=717383
  Lore link: https://lore.kernel.org/r/20230131144701.34418-1-chao@kernel.org
    Patches: [f2fs-dev,1/3] f2fs: clean up __update_extent_tree_range()
             [f2fs-dev,2/3] f2fs: fix to update age extent correctly during truncation
             [f2fs-dev,3/3] f2fs: fix to update age extent in f2fs_do_zero_range()

Patch: [f2fs-dev] f2fs: clean up i_compress_flag and i_compress_level usage
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=716559
  Lore link: https://lore.kernel.org/r/20230128103011.1316979-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to handle F2FS_IOC_START_ATOMIC_REPLACE in f2fs_compat_ioctl()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=716560
  Lore link: https://lore.kernel.org/r/20230128103226.1318362-1-chao@kernel.org

Series: [f2fs-dev,v3,1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=714192
  Lore link: https://lore.kernel.org/r/20230120161656.70308-1-frank.li@vivo.com
    Patches: [f2fs-dev,v3,1/2] f2fs: fix to avoid potential memory corruption in __update_iostat_latency()


Total patches: 16

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
