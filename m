Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3793606AAFD
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MsqTbKYk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dId0MG/w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PL1+0QvH;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWZbyyXV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkTqzN3Me+RqU4HdjFkccwBB2ckEtVbvwXeexFEV7es=; b=MsqTbKYkxLXQCCqa8vQv8W/e8t
	ehjC+t7/RwPe03N/XAbsi7zFFgSGvU8POVqjd/knywk/VpWkdIPRcT/ARwl+FNwEBQiZRPoK5BE5j
	Mms/CYmQ2RKCRMt5n3qmJBBRcuGXVr2Tsd/Vdx8IQ5LVOrqUwT9nMTQGEdRApF5QLd88=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpTQ-0007qC-JU;
	Mon, 19 Oct 2026 15:40:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1xIpTF-0007pv-Bd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1AwhYTo8TdLx73LUUCO1C29ZRra7sMAgFbZ3DOAdGuw=; b=dId0MG/w7c34rvkS8wv8XQxGVN
 ekAITEjjRfhyQzyE8QL4sz4K1A6Y7+6glgcYFWEvwTWJDtzg1U4cBuUfUMobnCXDHfze4iDTDmzSn
 SYtW2fhCHkzA1wtDwQBxrpw/O2CQ4d0hvEwb/+LlCnzleX/ZSZzs8HuL8ysQ1IRWvn0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1AwhYTo8TdLx73LUUCO1C29ZRra7sMAgFbZ3DOAdGuw=; b=PL1+0QvH1QR1CvElrk9zbcC0Qa
 ipyPOwfavb87oKVG2t5kB9L2k/ZzsnsTVv+fkPqWgZHW4PwhVLodSklN8yI+2YLSvON76dURX28Bj
 jmMKJtur+iaX0Iri7AJ6SQiINHvx4i21C08HMdJm6BVtyYsP5uUa7I7v8qt4ynaXUhjw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIpTE-0003jV-GH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:40:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 251E2435CC;
 Mon, 19 Oct 2026 15:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DBF1F000C6;
 Mon, 19 Oct 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792424411;
 bh=1AwhYTo8TdLx73LUUCO1C29ZRra7sMAgFbZ3DOAdGuw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=iWZbyyXVdSY3eWdJByqIQvFRAF2kplc5pHMk2j75LoQr5Qknddxi0KdN3zxsjlVIb
 eLjgdXAbKDDTz8leqUd6ScAKr8irnHX0KrdxJTUxkIyHx/NVoR2USiPUzAsgC0GUvt
 vdumFGX4X4MSudqlHlErowRzFbqGz6R3pR+0/2HW7PFvzGufhOel28ruVdazXDzNRV
 foG2h+/9YpXiVttOhuJ0ek073H0sBmcUElxGcHi/imA0RcIwCdcvFqYPwIQvkpzNLS
 b7i0DvCdAmrUF1A/yezWyy3y8Axhr8JNnVDyILf+tg/bA3eFeJI97Fz02GSV1W0apO
 4AIyCBVyAJdBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 F12D93811A71; Mon, 19 Oct 2026 15:40:10 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179242440952.2714099.9716703809963334539.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 15:40:09 +0000
References: <cover.1792116883.git.qiwenjie@xiaomi.com>
In-Reply-To: <cover.1792116883.git.qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xIpTE-0003jV-GH
Subject: Re: [f2fs-dev] [PATCH v4 0/2] f2fs: fix online resize state
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, sunqiuyang@huawei.com
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

On Fri, 16 Oct 2026 13:44:04 +0800 you wrote:
> Online shrink changes both persistent SIT state and the geometry used
> by pinned allocation. This series keeps those states consistent during
> range evacuation and after the geometry changes.
> 
> Patch 1 drains the SIT journal during resize even when there are no
> new dirty sentries. It is unchanged and retains Daeho's Reviewed-by.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,1/2] f2fs: flush SIT journal during filesystem resize
    https://git.kernel.org/jaegeuk/f2fs/c/a6ede4054551
  - [f2fs-dev,v4,2/2] f2fs: refresh pinned allocation boundary after resize
    https://git.kernel.org/jaegeuk/f2fs/c/e4df12e37300

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
