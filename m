Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B447C77B70
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Apr 2023 17:00:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmHM3-0008L7-6u;
	Tue, 11 Apr 2023 17:00:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pmHM2-0008L1-2W
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iGH8jZrn2IaakVnDnaQC/WNDrUd1vGO4GIwwGgSZh0A=; b=EQPpLCGBCTCr6tMRJ0WnE8xoLy
 GS3zyt74Qhyf37U8AzD2ac/44HnLUWzWK/FRmb4yksNoWWl/7luOkkkh0IMnfjJF97w6/HBIKJs55
 ClKiLGiXCuMQjlTZcELYWgvB7dxX7oyqccxrahWEd2dypb3zn+0qRZESPob0DwRtQh2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iGH8jZrn2IaakVnDnaQC/WNDrUd1vGO4GIwwGgSZh0A=; b=P
 VBUSstQvHLTCLQx4Yz0pKbkgVkw40mS1KLtqTjmEieMFlipm/l52Ia3UDkjWaxNHlWHEHA/HgMrd3
 +/t4/0HIM+RpyPeQhI5pWK+xTWMbHCte3LN+of8hFilU0fCUiLP/cnSZJhm797IkueE8aVJf5ZiKY
 SzHu05mne4IKr2AU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmHM1-0005Cf-QL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:00:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1006298E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D008BC433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681232419;
 bh=jH1b/N2eWtjFf3Rat+lMYueRG+sD0KYl5SPmtDtejss=;
 h=Subject:From:Date:To:From;
 b=mpLyQfNeE9aTrajSW06eP4tjev/PlQzZC1g0Z2QytvvCQdu2owViRCc4WVj7N03sG
 j7iCS5jvFX23RlAvrJGM5UKtU5dA2ODJNlOQcCZQRqj++T4ozxXID592XPfXFPJrF9
 99otbFl8k5Y9fWsZmVnpwKIfX3ESSFSshjuWnY+7TLxvpuazAN541QmpSEJnNLsM60
 3io6uir0g3H3IL1vlaW/LwOShVsivEPZz9ydd8h4/dAPkFJ4d5hBwhiKfO3jD9Fhz/
 l/L1vmWO+yEht67weRGEuBQ1eXz39XwuQsm903SeRb2s1/1QB4vSV6ip4ErO8Jwdwi
 G++WEp/HrEprQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B36AEE52445 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168123241966.4928.4553261323699662851.git-patchwork-summary@kernel.org>
Date: Tue, 11 Apr 2023 17:00:19 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pmHM1-0005Cf-QL
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

Patch: [f2fs-dev] f2fs: fix to avoid use-after-free for cached IPU bio
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738321
  Lore link: https://lore.kernel.org/r/20230410021402.1833220-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to drop all dirty pages during umount() if cp_error is set
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738320
  Lore link: https://lore.kernel.org/r/20230410021222.1826966-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: use f2fs_hw_is_readonly() instead of bdev_read_only()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738322
  Lore link: https://lore.kernel.org/r/20230410021722.1836433-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: use common implementation of file type
  Submitter: Weizhao Ouyang <o451686892@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=736640
  Lore link: https://lore.kernel.org/r/20230404032844.3596879-1-o451686892@gmail.com

Patch: [f2fs-dev] f2fs: remove unneeded in-memory i_crtime copy
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738323
  Lore link: https://lore.kernel.org/r/20230410022012.1839127-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix to keep consistent i_gc_rwsem lock order
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738319
  Lore link: https://lore.kernel.org/r/20230410021140.1825781-1-chao@kernel.org


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
