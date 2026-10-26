Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F2606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ND3tmitl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LhqQbMgl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sq5+Pv68;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIzfmbI8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bY5IQ9Gw+i4a7wB7v4Q95GgZTS2QvsUrp0OXk1Okee8=; b=ND3tmitle3RDQu
	jYy7cW455lvt/z647ujIB8/4iSs8+nwsSyHQJE7OdzasrmeKiA+M6dOF3mfklvO1/iuT6lUld4Va+
	D5l5b3tfLFwJpidbSiCE1+acxojzhtxyiDhMHwsIU3zzI9VHeJbrJRZ3Oez+9gOzYHz3RCSP20ELr
	o34=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLMoQ-000000000rG-09Mt;
	Mon, 26 Oct 2026 15:40:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xLMo3-000000000qn-3YMC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:40:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NwOaDW3IKFzrSo7Bh0MMRKLfKzgUJTqf3sxAkLkKUf8=; b=LhqQbMglfb04Nidy+kcOSYdEu/
 pSprYGEd/MoMXTa7hjDVwXsS32knUlPDecnktmyX1oYn+3Kp/429TGj/swBzfMyd4L/8r4URWEQii
 Z1ckAgAK3lhMbB3i8joEBXr3cWZpSkjFdZnvSV7LK5NTeJ6RyNO5dSnCxR4c70QyHQFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NwOaDW3IKFzrSo7Bh0MMRKLfKzgUJTqf3sxAkLkKUf8=; b=Sq5+Pv68YCbWF1lW13/eU3Becn
 Dl5oqX4JtiZHvMU8vJv9Qom/qAy2fxEwJI4CwtnxGQ37YfI8wMP4wzn1p1tIFNpgivZlXfXsP+owc
 UlOB0WEdhaXqAifVZTUVkAJEYVerb/1JpuWDzsBDqB1rarGxASMa8hPMqQ3irukbS17Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLMo1-000000005S1-3rp9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:40:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59F8D601F9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 15:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C311F01828;
 Mon, 26 Oct 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793029208;
 bh=NwOaDW3IKFzrSo7Bh0MMRKLfKzgUJTqf3sxAkLkKUf8=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=KIzfmbI8bz/CC45PT3r57JDhBQ+qYzAmmt6vUSKytYx3SSomQAtBT3dX1/5GAex2o
 AjxsLl6gTjASosPOFCp2CpLXwhBzlMvzGCYFqquBZNXDRnrX6zeHdjuNopNu5lsLWV
 0mFiBWh9CUHoET9QBhtJNrbl2OAXSggecwPmwYmKx/0/s7M9TNTyswUuGUUQGRrgg6
 s0bse5GDXktDjxYv/fPtz8dYdSsuHFHorAPsf72vRb5qFiDudU6Dn4yMVU1oqTo+bA
 W1MsdBYEeurgFgSOTepGgbC3SXmnLZ6IIKvUlWCBVAjtA2QrXWFaFmZ3UN6PY8yPxR
 yTiQQfXTuyQag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 0741939EF95E; Mon, 26 Oct 2026 15:40:08 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179302920657.3239427.10043176302785058573.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 15:40:06 +0000
References: <20261026002350.1451587-1-chao@kernel.org>
In-Reply-To: <20261026002350.1451587-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLMo1-000000005S1-3rp9
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix to fetch ino via
 ino_of_node() under cache lock
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 26 Oct 2026 08:23:49 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In f2fs_writeback_node_caches(), it's better to fetch ino via ino_of_node()
> under cache lock, otherwise, node cache content may become stale after cache
> is unlocked due to racing w/ truncation.
> 
> Commit 493b9dc8b52c ("f2fs: cache: use node cache") fixes similar issue in
> f2fs_flush_inline_data() introduced in commit 34c061ad85a2 ("f2fs: Avoid double
> lock for cp_rwsem during checkpoint").
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: fix to fetch ino via ino_of_node() under cache lock
    https://git.kernel.org/jaegeuk/f2fs/c/cd6d8b189139
  - [f2fs-dev,v2,2/2] f2fs: fix to update superblock crc in sanity_check_area_boundary()
    https://git.kernel.org/jaegeuk/f2fs/c/f8f956c7ec8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
