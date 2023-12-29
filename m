Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABCC47077
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Dec 2023 19:10:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rJIFk-0001lT-QF;
	Fri, 29 Dec 2023 19:10:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rJIFj-0001lN-Ij
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Dec 2023 19:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yMCJwplGET/ZCr11t5XHfz6M3sIEloYGrN1CEs2ZfNU=; b=UzOQv+6KkdS8P2Cpa5QYVljNj4
 xBtbecE3YlZrCLPmZDv9v5jSrKFsqeCkjUOHeVRhS3EERLEU6F9t5bfBLIa1Lm3ACqqoWFfnsyNfI
 PC3OyhYk+ki4DOpb5hCZohag4LessLXIlmqz60aiJe6D84SnSuMYIJbGlB5Uc1/pDZ2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yMCJwplGET/ZCr11t5XHfz6M3sIEloYGrN1CEs2ZfNU=; b=AzO1qkcf/eI9EtcgrEV4jNNpDv
 hGXfu0sfEHMc0s2WFqFhELKlBjVC+YLmV77XA0ZdSiizYUHgj+ckrLbA/I8ZlZeeDI7yP4NGmDX5O
 EUZ4TkMr8Pdt5ef7uGvJCFdmBhHU4U2/q7PBsHYjYKmTn9IGhh5cXFPhJZ/OEB1r2tnc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rJIFh-0005NV-Rf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Dec 2023 19:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 74AF5B80E7E;
 Fri, 29 Dec 2023 19:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D981EC433CC;
 Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703877024;
 bh=Ri74LIwEC9/3K1qM7Hw/JxzXKBrH1rB3W05Jf9Ft5fA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=s4YcQPcGh39Vs0Snr6lEdMBC9XSHn5ag0IUp4v+Nq76HH4kaMaLZ+4CTqxCSHD0MY
 YaP9Ku/tDq8dnNqjxULHBxxkZMjk/Mj4uKpgRjUW7o0+eMAQul/nrFUO0iadNgc+C4
 nraFl4I84XOIZzpwCu9pllofsV/XDdk2v+BS0Pblsx/pXiY3d116Fb2CwGu2G8UlMh
 IXr14/i9qXFQ4xJM67/3PYcWZrOLfH6k2PWBAv7I2grjEX1h0T955tesMtSimRUf61
 d3wtgjamIq+W2A2Bc5EjjYLyZuI2HB8YI/KSWdtsmMqgfd59sFgmlu1Qxl7Vzhba2b
 7PAv3VVSjywDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 BE132E333DA; Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170387702477.8173.5505716820349568272.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 19:10:24 +0000
References: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
X-Headers-End: 1rJIFh-0005NV-Rf
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix to check return value of
 f2fs_recover_xattr_data
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 niuzhiguo84@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 12 Dec 2023 10:15:27 +0800 you wrote:
> Should check return value of f2fs_recover_xattr_data in
> __f2fs_setxattr rather than doing invalid retry if error happen.
> 
> Also just do set_page_dirty in f2fs_recover_xattr_data when
> page is changed really.
> 
> Fixes: 50a472bbc79f ("f2fs: do not return EFSCORRUPTED, but try to run online repair")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: fix to check return value of f2fs_recover_xattr_data
    https://git.kernel.org/jaegeuk/f2fs/c/86d7d57a3f09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
