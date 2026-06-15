Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C40CD8CA8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbRRZKZr1MGSw1pa5jT+hlTWfiPR3jqbpPDfcqzn6Eo=; b=mjjHmrxHKh89kdXqmI4q/M+GJr
	aWhXwiGPbPIHj0cibqUYQn3qtkwIxR9KmLTjpjWFUnOXnEIpd7n399YSM9+7onZonTqL5Sw3vAylv
	6ELDx7vUypQlZXPEq1PqDwGWqE5A4iGR/x4l1RT3k3vjb9royQxk3lP5mhPIbpZmK1z4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wYxd8-0002I9-DQ;
	Mon, 15 Jun 2026 03:04:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wYxd6-0002I2-3X
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2QNQXfLtdJq4zDVVS8/wh0UvbzBf1iUZMVkOAs61smM=; b=WvAgOr6Uniapq+n4AKOR6PJfAV
 6i5kW6d4ShXDCkuRwgIVARUj8FbAQFVfsQ7+tIGJVa9rCA5/k7av2e5TveOQIr/C06qnCKREAGUMF
 rAMErK5peJCrz+amUvDCrbXwYm2p+46r0vuVVTINQ3uQMwSiflMaL6QY0BZlg/P2dcUc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2QNQXfLtdJq4zDVVS8/wh0UvbzBf1iUZMVkOAs61smM=; b=KMQpuuRLXKrh0rZq6BvE5P8sEL
 qlKrjK0GI4k+c/zCZoIs6+F0Fnk2Cb1zmU5nN24u3Ei2zzoVRI5X93U8QIB2p/nFxBFGD0LZ5n//1
 h6bkBJ4AvYLOeDclBe0IeDEi9Mo42A/Q1z9ykzGdZ8Kb9NMr/bdz1m56EmdJHbh80Jpk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wYxd2-0007kt-O3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 03:04:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 596984077C;
 Mon, 15 Jun 2026 03:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE221F000E9;
 Mon, 15 Jun 2026 03:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781492677;
 bh=2QNQXfLtdJq4zDVVS8/wh0UvbzBf1iUZMVkOAs61smM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KVpgvAcAv8BNr2qvLWHzto6NR0vi1yzqgQ8tIrUJ7se4eKE1bfLdxjpf46Jz8p0Ml
 YNa84vCmAwc2qByhW6mXLocL7ghqanKvxNsqyu/ImfAEQ4SlT3btNHjbE7HXaIyLGr
 9brBOs5TTeisTvvWftB8lY8sQpE0zD4cT6zH6jEdzT58VKsPk9gmSLFG1mNWRg95oJ
 9ZdOiQpc42qn3JUZeAGQVvFfB3BTTHX5WsqtDZRkC/RcXtpQTRWMlg4UxSKYc06yUq
 DZIUO4WPuYyWpZkG5fC77yjPFbqyl3druHN7kPyduNc6xhyHvNMZYedYkPf41C1egA
 vhpXbSaf8piCQ==
Date: Mon, 15 Jun 2026 03:04:35 +0000
To: LiaoYuanhong-vivo <liaoyuanhong@vivo.com>
Message-ID: <ai9rw8tjybY8Aiqu@google.com>
References: <20260602134104.348655-1-liaoyuanhong@vivo.com>
 <20260611125006.508734-1-liaoyuanhong@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611125006.508734-1-liaoyuanhong@vivo.com>
X-Headers-End: 1wYxd2-0007kt-O3
Subject: Re: [f2fs-dev] [PATCH v2 0/3] f2fs: support encrypted inline data
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: corbet@lwn.net, tytso@mit.edu, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/11, LiaoYuanhong-vivo wrote:
> Hi,
> 
> Gentle ping on this series.
> 
> v2 tries to address the previous concerns by avoiding per-file software
> tfm growth, preparing the software transform lazily, and explicitly
> disabling unsupported key combinations.
> 
> The main remaining limitation is hardware-wrapped keys. If this makes
> the feature unlikely to be accepted, please let me know. Otherwise, I
> would appreciate any review comments on the current direction.

Yeah, that'd be a big win, if we have the hardware-wrapped key support. By
any chance, can you add it in the patch set?

> 
> If maintainers have any feasible direction in mind, I would also
> appreciate hearing it.
> 
> Thanks,
> Liao Yuanhong


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
