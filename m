Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96780C761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 21:30:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjoEZ-00042R-7D;
	Tue, 04 Apr 2023 21:30:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pjoEU-00042K-9a
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 21:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ElsgdvZe481P84X0M4IkP2lLhgvnGqjPej0krti+Yac=; b=Ka5/JB8+/kH/GW1s0dGd03ur2K
 MHUMCdQhSLf7jw+GLGmGSOmmeu+OjRp6VdHnGkayJqwO+k50hfKvp3zuK2Fful6ncHCDOkS8u/0pW
 zBwmecbFbYZEvpt5xVOPxi1aN2aBo1+1lnni96ZTNgBtqYlBe5O+CjWsliSQ/NzBs+kM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ElsgdvZe481P84X0M4IkP2lLhgvnGqjPej0krti+Yac=; b=Ze/G/pEzOcyqgJKXmtLrbprIlK
 kK32NnThcIrf+HrCBD82gAFPj/gqjMf1QlLFpA0tq4bNm+sNwc3aIMGh/xW0z2RqJZVcsorLD7zMs
 L3CsHhfcqlfNJhK+QsyJj2B5EMoAFPl3Indz9Q4zFUbxhGK7AJ2zyLWNWmDc3YNbIe+I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjoEU-0005ET-Ia for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 21:30:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A2F2D639B3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E68FC4339B;
 Tue,  4 Apr 2023 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680643819;
 bh=2NmdC/BmqtWxzZ/ar/gnNZilCEclqyqnyDigaMMdguc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=PVTRSWggLJrNNHl5pggRwWxzDHWMJdTq1gGeYhR1wNIMkRUN/5VzbABij2nbwz7sW
 UeAZHmZxmd8s3gYvVtyO5BOPHT9mVxqzJ41aIikBQdZ30WsXXUHiYDsj8HkQU2PZcH
 bYsvRN+XYfKz4Xq5Ol96JGPraUoeb2cWz3Msc0XctfDGkAAvPv6LQDNHEKNqBlt+g+
 2nvsUwC9cP4mQnR3x+5uQ20B5qnpCdlVkmAP+Q/hA+9zG1u+4/gnJ/DDLqgZwuIXeW
 K8B1Ujc+tOucAKOxX3br1oqDKV7dgtQABTZQErkWoCukWoWpBKXe+Ln6GwpoCpAhmv
 EGPSxXqScRVEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E5024E524E4; Tue,  4 Apr 2023 21:30:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168064381893.16246.7986262771761292127.git-patchwork-notify@kernel.org>
Date: Tue, 04 Apr 2023 21:30:18 +0000
References: <20230404152807.4987-1-chao@kernel.org>
In-Reply-To: <20230404152807.4987-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pjoEU-0005ET-Ia
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to check readonly condition
 correctly
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  4 Apr 2023 23:28:07 +0800 you wrote:
> With below case, it can mount multi-device image w/ rw option, however
> one of secondary device is set as ro, later update will cause panic, so
> let's introduce f2fs_dev_is_readonly(), and check multi-devices rw status
> in f2fs_remount() w/ it in order to avoid such inconsistent mount status.
> 
> mkfs.f2fs -c /dev/zram1 /dev/zram0 -f
> blockdev --setro /dev/zram1
> mount -t f2fs dev/zram0 /mnt/f2fs
> mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.
> mount -t f2fs -o remount,rw mnt/f2fs
> dd if=/dev/zero  of=/mnt/f2fs/file bs=1M count=8192
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to check readonly condition correctly
    https://git.kernel.org/jaegeuk/f2fs/c/2bce08d26c0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
