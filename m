Return-Path: <SRS0=KzLc=MG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C95C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Jul 2021 02:27:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5286E6135A;
	Wed, 14 Jul 2021 02:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5286E6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m3Ucc-0000rG-7c; Wed, 14 Jul 2021 02:27:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m3Uca-0000r3-Sa
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Jul 2021 02:27:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EMkMOOaIxAqFas79EtObVpTJ3QgnrMOC9HlPxH6pNC8=; b=flBVOir41Ph9pD5ZBoLkJIcH4m
 9ZWGXL13ZL1upftvNTHiw0Kb0YLP8N+3dJFz+Yc+sV8akvk4nlg5iQ4mVZ/gxADA33VBJzwOyPBbG
 jWExUDC5w/i3cuv5GeUOTVzlJIbuRWigZl5RhxEw79yBGCUbAgl/J1GVlUIWFsiYvQSM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EMkMOOaIxAqFas79EtObVpTJ3QgnrMOC9HlPxH6pNC8=; b=lU60YL+HP+9aua7QRJq4dUZsgS
 oVVT+kwx0qhYcqzyNH4vZSy0i9ijra8Cg1yE7EtSensjRCkmpqUK1SwJfsoB2GmflSCAqw722Mhd8
 /qgQ2Cs9lMEsWWgF8Lm3FE5e8e/o3WTMZpX3H0S9Y2dPiqpU3ojsWOcgquwgmImTd0gE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m3UcU-0000M6-Ne
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Jul 2021 02:27:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DEB6611C0;
 Wed, 14 Jul 2021 02:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626229644;
 bh=Bj+HpaEPtkQE5eY6vbygK1YC7JiEJPnWWpcKchZsslY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BKiFegzHYXscUYOtgpqkndal3xjPRF+5NV0ZiTfdLdLnSt2JD2JLzSskyKiW7vWVh
 bhSFm5vTgauPYGP4frZB519ChPzGQw2sualqo971t9yX/5wfidcFUHjJGmcjaZ8xIp
 nMHfGwVHY0ShUYyfBbfMf0l/+YhGnMfB/WBlOHlqktXZXSpFXCBR0XCCbLauui1ZMl
 5ZZn+ckCww9xKYvs7qgN/pjyTB6tEcCAunp44rM33nTSC8lX3krkNEqh3AQcbMajNO
 If2AfKX2tRJvOLuiZh9iTfC4J+OT8E27gPt72D93sCnYdl6qTxFJtwWm5JksbONTvR
 fNZHK8ZpYxN6w==
To: jaegeuk@kernel.org
References: <20210707015815.1978-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <ac39c9af-2ddd-5033-2b64-cb10aadc66a2@kernel.org>
Date: Wed, 14 Jul 2021 10:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707015815.1978-1-chao@kernel.org>
Content-Language: en-US
X-Headers-End: 1m3UcU-0000M6-Ne
Subject: Re: [f2fs-dev] [RFC NO MERGE] f2fs: extent cache: support unaligned
 extent
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/7 9:58, Chao Yu wrote:
> Compressed inode may suffer read performance issue due to it can not
> use extent cache, so I propose to add this unaligned extent support
> to improve it.
> 
> Currently, it only works in readonly format f2fs image.
> 
> Unaligned extent: in one compressed cluster, physical block number
> will be less than logical block number, so we add an extra physical
> block length in extent info in order to indicate such extent status.
> 
> The idea is if one whole cluster blocks are contiguous physically,
> once its mapping info was readed at first time, we will cache an
> unaligned (or aligned) extent info entry in extent cache, it expects
> that the mapping info will be hitted when rereading cluster.
> 
> Merge policy:
> - Aligned extents can be merged.
> - Aligned extent and unaligned extent can not be merged.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> 
> I just post this for comments, it passes compiling, w/o any test.
> 
>   fs/f2fs/compress.c     | 25 ++++++++++++
>   fs/f2fs/data.c         | 38 +++++++++++++-----
>   fs/f2fs/extent_cache.c | 90 +++++++++++++++++++++++++++++++++++++-----
>   fs/f2fs/f2fs.h         | 33 +++++++++++++---
>   fs/f2fs/node.c         | 20 ++++++++++
>   5 files changed, 181 insertions(+), 25 deletions(-)

Jaegeuk, any thoughts about this idea?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
