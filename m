Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C451C7EE2A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 May 2023 01:50:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzSmh-0007H1-Vp;
	Thu, 18 May 2023 01:50:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pzSmh-0007Gu-5l
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgST6/xLQeSsFqVLeGSPfD0MX03vXBgL9hN07iE7bEE=; b=TJjM94A/NN10fAQaSuZWPfQ0z0
 XG1vIEid2NFQsYrc3157lL6989ivC9eektb/+PONH4Z67lH7wtoay1WkWVFRqXfq4boBPmxmjNc6h
 D6fhVUvZ46QfQQBze/v0n/JcZmGltaDMaT9CNlNiz8inYi1N15Y/XCqaBjA7KiyRBz98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rgST6/xLQeSsFqVLeGSPfD0MX03vXBgL9hN07iE7bEE=; b=R
 qDXC3WCacCo5qPIga6KUhsztjh9lfp4gG4Kpblh9GMirSQqPA5jLusol+KOgmA3xRTOcELCc1o+Y7
 O+z/6hqi8i0Z9+2udHK9JLnz5hhMH5gY2i4HTtOLIMGg10aVtPBzNweubFz6Zw5VHQavAw1abGW2+
 brDBKj/yhk6muIMc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzSmh-0007UF-B2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 01:50:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EF4D56431A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 May 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB46C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 May 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684374621;
 bh=joYph8gNUO55JHZR70/YLoZokUIa5uB6XcxqpylHq58=;
 h=Subject:From:Date:To:From;
 b=nC+1at/MrNbeV9RacMntc6AVVLbQewWPz1XiWbdkWTQUEHYX4EmLHhLLDDfrbq1s/
 EEUeaYdkZyT1ZsUT1r8vZxV534PTXXvzoMrcrZPv8CC/hntKicWb+zqqVc3B9wb3Gu
 kF7eQ2nOkDcm+YG0TS6gwBPhCyBrskIAsDRr5zaci5pTdg0JI0SRN5lMQqAYxCZrc1
 juPuMFst6dDYA1ospyj570U/SC9eipuhjmSUMDCL8kjTm+qAIuMSxJwq3OGFdynAYL
 WuTXTqRBbnswJ33ir2Iznzu/awq0uKPNygu48a5tD2mCzzCV3pQl9o2qqqMcdIZRID
 WgPUZn0/CHWeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 4265BC4166F for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 May 2023 01:50:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168437462120.19511.4656349150955344848.git-patchwork-summary@kernel.org>
Date: Thu, 18 May 2023 01:50:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pzSmh-0007UF-B2
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

Series: [f2fs-dev,1/2] f2fs: renew value of F2FS_MOUNT_*
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=748349
  Lore link: https://lore.kernel.org/r/20230517094250.1407910-1-chao@kernel.org
    Patches: [f2fs-dev,1/2] f2fs: renew value of F2FS_MOUNT_*
             [f2fs-dev,2/2] f2fs: renew value of F2FS_FEATURE_*

Patch: [f2fs-dev] f2fs: close unused open zones while mounting
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=745391
  Lore link: https://lore.kernel.org/r/20230505204000.3604748-1-daeho43@gmail.com

Patch: [f2fs-dev] f2fs: fix to set noatime and immutable flag for quota file
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=748054
  Lore link: https://lore.kernel.org/r/20230516152346.190199-1-chao@kernel.org

Patch: [f2fs-dev,v3] f2fs: add sanity compress level check for compressed file
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=738051
  Lore link: https://lore.kernel.org/r/20230407183148.23231-1-frank.li@vivo.com

Patch: [f2fs-dev,v2] f2fs: compress: fix to check validity of i_compress_flag field
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=748245
  Lore link: https://lore.kernel.org/r/20230517034139.12879-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix potential deadlock due to unpaired node_write lock use
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=747320
  Lore link: https://lore.kernel.org/r/20230514080723.17313-1-chao@kernel.org

Patch: [f2fs-dev] f2fs: fix the wrong condition to determine atomic context
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=745376
  Lore link: https://lore.kernel.org/r/20230505191841.3185179-1-jaegeuk@kernel.org

Patch: [f2fs-dev,v1] f2fs: Fix over-estimating free section during FG GC
  Submitter: Yonggil Song <yonggil.song@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=746961
  Lore link: https://lore.kernel.org/r/20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
