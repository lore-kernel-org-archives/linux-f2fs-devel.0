Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562960820D6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CVe2ZFIp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XxQ9gl6s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gWn3CqS5;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adzmqr5S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23QSXUcxpJ9I+8LmSsOwRmorYZECN3yWg5P2kYKcCQ4=; b=CVe2ZFIpR4TUWTgFHytR7vUSFV
	zOdWUqajGS00ZQg/9027ePfwawAafXktXY6CqIRVFx9n8vvUK/JqyuC9XjQIyj2oifzvk2ux4xJpc
	xgTLIogov2H89eRrxaxMTo0EP0UqbjUlDxs2bTvCxAsqq5wgyLSah4qud+//njPzeMKU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTW-0001J0-DR;
	Mon, 19 Oct 2026 15:40:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTF-0001IZ-TR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iZJHrYGA4vvk72TfCN2wk/iV+4PmycnQTPaBgYupmAA=; b=XxQ9gl6sHNMmo0WA3lUgIRbtew
 6KVceP87LxkNJRTR7o9NlT9JQelktHqBCyuz8XweXXfpYpS7Tiq5kByRPbt8GiqTROX57ZHhnjKp6
 rDOV+02xJtsq1aYZ5oM5t7Z7CihPyNB1IhifG99TYqct3fEiSRHF9ZImUNWBNVLatn1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iZJHrYGA4vvk72TfCN2wk/iV+4PmycnQTPaBgYupmAA=; b=gWn3CqS5mqA/orSOUfJcUSWtaJ
 /xoKkWhXKZuoUdXmPM2gHtjD+VrUSEw6bhXsgI2xSYr+f6GNu/0iMHP4LvHle1Z3U47lbWX4v137f
 2Vm4BR7ENojy6fTnsgDZn0Dzps7auHfEPpVAOMEcCMFWaQ8DbBJoH7L28Qv0rMy+GnaM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTB-0003jS-VK for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5056460D93;
 Mon, 19 Oct 2026 15:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0674D1F000C4;
 Mon, 19 Oct 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424408;
 bh=iZJHrYGA4vvk72TfCN2wk/iV+4PmycnQTPaBgYupmAA=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=adzmqr5SCl8jrlV8Gr5UMACGuhiZR2Burf8qeoQ1FN+Vh9ByqsAT/VS+cpnVB/D4z
 xSziBi0lxrRZh3LC4loOFAl3X7G2yQPNIhQMYxQgHWgn2gcFNDr8U5SKkrREety1L7
 Ajh/NRgyR0mPQ0zVYS7M0fFwJrPdzY4e9xX5C9Q8ijP/tF3rLIzHgP4x8/eN3isY/2
 7j0U/tRt0PYA+U/IlBXdvfMtxGgcjeXOfPYEFEa+s9PBgVYoxj8KSUohxXuVr6Y35o
 /2XlCuGNIUI+FM231su1k0shpe1xwhWACWk6aiUEJuR/RVT+OO38mxhyE/+TphMqcX
 XpaIrSCVoKWYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F15983811A71; Mon, 19 Oct 2026 15:40:07 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242440678.2714099.1586605259418361333.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:06 +0000
References: <20260911143549.909867-1-daeho43@gmail.com>
In-Reply-To: <20260911143549.909867-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Spam-Score: -2.5 (--)
X-Headers-End: 1xIpTB-0003jS-VK
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use BIT_ULL for mount option
 bitmasks
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
Cc: lkp@intel.com, daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 11 Sep 2026 07:35:48 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Although f2fs_mount_info.opt and f2fs_fs_context.opt_mask are declared as
> unsigned long long (64 bits), the option bit manipulation macros
> (clear_opt, set_opt, test_opt) and context helpers (ctx_set_opt,
> ctx_clear_opt, ctx_test_opt) use BIT(), which expands to (UL(1) << nr).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: use BIT_ULL for mount option bitmasks
    https://git.kernel.org/jaegeuk/f2fs/c/a5388dd98954
  - [f2fs-dev,v2,2/2] f2fs: introduce reserve_shrink mount option for filesystem shrinkage
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
