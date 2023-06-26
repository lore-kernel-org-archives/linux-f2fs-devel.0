Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B915EEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jun 2023 13:30:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qDmIc-0001g6-DP;
	Mon, 26 Jun 2023 13:30:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qDmIV-0001fz-Ch
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 13:30:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpLoc4jP3sDXXH1hkeqZ6JBFYOG/hbsD4HnnRndeOUg=; b=KTcbwlG2clv2IVhiCK2EuPhzSM
 ensfKBltTlxL1iWr2cJkWsYjsuJ0sTCa1H5K2404mSgxV/562+1cxE1Cdwh0Av+o5lY/EhW3DsyWn
 YgX6X4eA5u8SlwuYTVy25RIrr6mfcnbZiB6iSz/dRxfsQE4ll8TBK6XbPiYT64SzOvNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zpLoc4jP3sDXXH1hkeqZ6JBFYOG/hbsD4HnnRndeOUg=; b=f
 IPJTQBVkjBTKDQCceiFBGkR1NsryGVmtB7/8zcEIFuF2DAFWCDud3epsQSAsDbCvNZUKW0wOCbswt
 szL9OZLx10yXm9+O6nPxN9eCnSUJLGpuKzhlmtWG0Za0gkMVB6q7i7QX9jZQnJTBSa4bpEVDwCEf/
 S/zb5OKVfvIujn7E=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qDmIV-0005fH-9W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jun 2023 13:30:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DB1A760EA2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BFD5C433C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687786221;
 bh=+2VUtOCt0ydelXjaB+71mhqV+BWaviAicNso8a+Ob50=;
 h=Subject:From:Date:To:From;
 b=cg6X9FNRrULNpJSzgX5u9M3+QD06dKouyaDfWILH3DLFXohmrOG53VcBSVk8EcW3G
 ZSusfuhoTNrNWdefxwU9gpVO6d5SLTS14A4aU5QxltzXIdgldBbZG0vch/mxoRIupX
 dECPm2lvhnX19LjyHpJY6jHjlVFoUZQlo2Td2zl3af+qfl29UG5aDX32gzBEZDDywl
 +7O/7f7LqTNQMt193DCoKT9gIAOFvCHHxfjapFLgyke+YK+IVk6oOfH2KvRT/yzqtY
 sC7jgysFRYG9p3dzR0Bsy0jRZm32Kgs8B6C5jv6LfuQTW8uCa9z8IPncwraPCnbsnm
 16mvij7ISPQPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2AE9DC41671 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Jun 2023 13:30:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168778622105.24530.10899550162556985068.git-patchwork-summary@kernel.org>
Date: Mon, 26 Jun 2023 13:30:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1qDmIV-0005fH-9W
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

Patch: [f2fs-dev,v4] f2fs: refactor struct f2fs_attr macro
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=745538
  Lore link: https://lore.kernel.org/r/20230506151604.36890-1-frank.li@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
