Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CABC79FB7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKmNsKPfCNq32J+EMTVJd/KYzKag+wlmG/vg8xRcB90=; b=DswGOQg3rDP1Ykb2GnT8mkvdx+
	08iGxgAx//VTlALE3xopEnz5TVs8Wgb2GUAEQp6aEnSLuDfYUT5K68FWrjji3LcVugaK0pqcQh1ns
	T3Uslnyo7NMPpOnZNz4fWECyS5ic2yDlugYijdgaGI93QgDA/jygCNlnE+Z0TTAspNNY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4TnC-0002Pz-4O;
	Thu, 10 Sep 2026 01:41:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4Tn1-0002Pn-Cp
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 01:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IaUHZEF7BQPMLgknLj3GrbaY0NGvoQ5+kD0LNy89SEY=; b=BG6dAnWa1KuIGAeKAQztcxiDV1
 cYIKUkt46ZQ6kGZkOYmvWRFy6sctbeq7SF6pPC7EhrmmtVRvS5GJla0YbjHntKYJguJZb5in6lfss
 5AVR+tknnvrkvgqmAhjkJ9PSlbAyq9dxHRgsMTpADaVLdEjKdRfTQjkUKTm1p0XtKRtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IaUHZEF7BQPMLgknLj3GrbaY0NGvoQ5+kD0LNy89SEY=; b=HzlY/FKKnN7IgaqV5X0B42zhot
 cXFwdiG6g9roYz5Ol+/HRdH0ZvWypqZeTudYrS2p/bINfMZtZ1skcqIp64EaL6eZGBgM5W/3xOjVL
 6RYuN2e+PGHwsT/qZyBfjJuqtOYD+A6SGAI7xwukd4L/wG0mvll6swyyT80Ly21ziD7o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4Tmx-0006ni-AG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 01:41:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E93E243C1F;
 Thu, 10 Sep 2026 01:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28D71F000FF;
 Thu, 10 Sep 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789004473;
 bh=IaUHZEF7BQPMLgknLj3GrbaY0NGvoQ5+kD0LNy89SEY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=alyW9fFPbFHJkcFRl88y+lq4YdOfV/i9oN4x19TZI9gz4nV9F7z6MOzVmWToQ7EW3
 ZEJ9kM96Hi51+2BgzV+T5/WTnS3GMjB+9GjLz85GdDy0sEuDIUejTpa/wPCHyjTOsL
 2ReuFogFXb9wI1CLgYpdws+225+/5xt78yoUZqPCPACzgd3M84+bXdvEUE955gcvHe
 0W+swggrvXXTN3yaYMRP6jULmEXwm+14D5EeJhEmhZGRL0fLBTjzUmW5Cm0mGl9/Ow
 kvN2fgpw3bPikh92KySRIl1O81vvubbP/9GYp9pZUZc+h/aRWfkpyRv/dmg39Z5a3n
 6utRZPvcV71tA==
Message-ID: <f5da23a3-7cd2-41dc-b28e-41118cf113e5@kernel.org>
Date: Thu, 10 Sep 2026 09:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260909190636.3151580-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260909190636.3151580-1-daeho43@gmail.com>
X-Headers-End: 1x4Tmx-0006ni-AG
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix livelock in syncing dirty inodes
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/10/26 03:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During checkpoint, f2fs_sync_dirty_inodes() and f2fs_sync_inode_meta()
> iterate over dirty inodes in their respective lists. If igrab() fails on
> an inode (e.g. because it is in the freeing state), the loop continues
> without moving the current inode to the tail of the list. As a result,
> subsequent iterations pick the same inode repeatedly, preventing other
> ready dirty inodes in the list from making forward progress and leading
> to a livelock.
> 
> Fix this by moving the current inode to the tail of the list
> (list_move_tail(&fi->{dirty_list,gdirty_list}, head)) before attempting
> igrab() in both f2fs_sync_dirty_inodes() and f2fs_sync_inode_meta().
> 
> Additionally, if igrab() fails, yield the CPU with cond_resched() to
> allow the evicting thread to finish eviction. Remove the redundant
> f2fs_submit_merged_write() call, since .writepages already submits cached
> bios via f2fs_submit_merged_write_cond().
> 
> v2:
> - Also apply list_move_tail() to f2fs_sync_dirty_inodes().
> - Remove redundant f2fs_submit_merged_write() calls from both functions,
>   keeping only cond_resched().
> - Update commit title and description.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
