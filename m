Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E43CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aO9+RJNcGIZcQurlSVSxv15kr9St33V/lshzi2iOCtM=; b=ANqFM5m4Xad02W4wpWlSrelL3q
	jS75ODxs8xQ3pztXh5hBK21+xZtI62+M2JcDl0NW0zuny8GXeDqaxZD/dV9Q+VCXpM2F5vLNKx8DU
	wi8Z5ythh76zCGYpqNpdaBuEfYT9HVjlfgBTIgeHbIbSreJQZabvO1QCkpEf5ClBrI+w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcJTW-0003B5-Ol;
	Wed, 24 Jun 2026 09:00:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wcJTK-00039w-Bd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TM6/7W5L0lECPXJpPRC/prv4vynbdZprP5beN/B/udw=; b=btri1gecMCWjMY1yMK2Clkp81X
 +oc/vODSRJjgUB6CpTF2e9bHpIUfKbOJ7h8z33EfvV5yeo27OZeiF9+5taZQLWFjxzzA179CWmeeR
 qo4wLPIWDVGWLJ90ysKV65WvwMqpJr6mXEQjsADk+BZsO8IFFzixr4Z3MfRR7Odqpqgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TM6/7W5L0lECPXJpPRC/prv4vynbdZprP5beN/B/udw=; b=BcxpaiJBHjQxMoa1vLMNI2WbUr
 6dNgo8uZyEBCEszIj9KiQr6oWImeEbQapwybAanpVNAAXh4/IAaB3pGRkNn4N2QlrhGO+elFtDksq
 79pcc0wa8LP7k+BhN/5RPT8uwqB2FAtH1UQCRAlEEwDvt48BNuam1PTFGFcKmUxpjNPU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcJSU-0000qh-Dq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42CFC601F9;
 Wed, 24 Jun 2026 08:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76401F000E9;
 Wed, 24 Jun 2026 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782291581;
 bh=TM6/7W5L0lECPXJpPRC/prv4vynbdZprP5beN/B/udw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=Td6fOIN3/f0VBzergs0drcUYmXQQAsvO4StGVdMIjfzMrq302z0CgE5PZLuvuGTgu
 y6OwsR7LXPEEFrY7QrkK2hSlHI12MXhmVem1daB0+ozFWkUYEuEItyZJ7vx5MyaS+t
 Oc1WA2rvp0/OSZzW0f3+n0kg+mE0TC3Ab6FQDwqtxJv9M6iyI463PwXDsZeJtaXgH8
 cA97HZbh6WLwIiL86WWHqng6yP/LFC+v3mboYn4sGQCZ08gXpiYOtiLe5h2IPQIEJa
 sokPZW3EP5W8SOl4LwWjYysGGnj4trZOS4gry4rVwbkUraPobHITXsNO5d1m/HquOK
 yCniGim9xfQ2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19A4A39EF964; Wed, 24 Jun 2026 08:59:31 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178229156954.2577930.8082691450605559803.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 08:59:29 +0000
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Chuck Lever <cel@kernel.org>
X-Headers-End: 1wcJSU-0000qh-Dq
Subject: Re: [f2fs-dev] [PATCH v14 00/15] Exposing case folding behavior
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
Cc: jack@suse.cz, pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 roland.mainz@nrubsig.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, slava@dubeyko.com,
 djwong@kernel.org, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, linux-xfs@vger.kernel.org,
 hirofumi@mail.parknet.co.jp, brauner@kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 sfrench@samba.org, senozhatsky@chromium.org, chuck.lever@oracle.com,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org, stfrench@microsoft.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Thu, 07 May 2026 04:52:53 -0400 you wrote:
> Christian, let's lock this one in. I will post subsequent changes
> as delta patches.
> 
> Following on from:
> 
> https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v14,01/15] fs: Move file_kattr initialization to callers
    https://git.kernel.org/jaegeuk/f2fs/c/14c3197ecf07
  - [f2fs-dev,v14,02/15] fs: Add case sensitivity flags to file_kattr
    https://git.kernel.org/jaegeuk/f2fs/c/3035e4454142
  - [f2fs-dev,v14,03/15] fat: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/c92db2ca726f
  - [f2fs-dev,v14,04/15] exfat: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/27e0b573dd4a
  - [f2fs-dev,v14,05/15] ntfs3: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/eeb7b37b9700
  - [f2fs-dev,v14,06/15] hfs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/b6fe046c3023
  - [f2fs-dev,v14,07/15] hfsplus: Report case sensitivity in fileattr_get
    https://git.kernel.org/jaegeuk/f2fs/c/a6469a15eefe
  - [f2fs-dev,v14,08/15] xfs: Report case sensitivity in fileattr_get
    https://git.kernel.org/jaegeuk/f2fs/c/c9da43e4e5c3
  - [f2fs-dev,v14,09/15] cifs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/e50bc12f5a36
  - [f2fs-dev,v14,10/15] nfs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/92d67628a1a9
  - [f2fs-dev,v14,11/15] vboxsf: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/ef14aa143f1d
  - [f2fs-dev,v14,12/15] isofs: Implement fileattr_get for case sensitivity
    https://git.kernel.org/jaegeuk/f2fs/c/7bbd51b1d748
  - [f2fs-dev,v14,13/15] nfsd: Report export case-folding via NFSv3 PATHCONF
    https://git.kernel.org/jaegeuk/f2fs/c/211cb2ba4877
  - [f2fs-dev,v14,14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
    https://git.kernel.org/jaegeuk/f2fs/c/01ee7c3d2e23
  - [f2fs-dev,v14,15/15] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
    https://git.kernel.org/jaegeuk/f2fs/c/0164df1d1de7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
