Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6B0CC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZlijtX140O6RaAwXp2SsI3gqsgynW6uiWYjDo7HNJWw=; b=aa16i/daLYDfBYlxqmMWlNiTRe
	hqa2UJwnVAmoRC2VyiYUfYaSxFnLDTJuUdeLhTm34VucJ2j6lecc2q4qJ3YuJWmUGkBCk+x1eDNpw
	pFxEZY2FkavShskXF4X1uA8PRqCzc9ySIIohLodaPV6CpiJ9IhpJ28be66pHheYagvPo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGqtG-0005Xn-B3;
	Wed, 14 Oct 2026 04:46:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGqtF-0005Xb-F0
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 04:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kXD2GjwhdrNaOacUYXGcDRg2qS2dsXZ26SXag0ScQEQ=; b=C7hPwXQk6Ca95EdTTYjbP10nXz
 H8TuD5bEPqZBwro/aSN5YQyht3VeCawdLvrF+BRXO5NSUe10U/ifWlH8PeY5O1vxlwK2WmWTRaB4h
 gnOU09dVOidIIWsbLr388U+D4u42ORYdJci0gYe6Y6UvhYdeU8OM3YtGRXoogouVIx68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kXD2GjwhdrNaOacUYXGcDRg2qS2dsXZ26SXag0ScQEQ=; b=JcDhVeWPEDMtcL/OjYVUdevT9P
 GRGsoPwAbEyPkFCXYH84tAW8d28qw/iMEwhLxrlLL2SL0lg7oIp4YrOwjDwH2Z/dXE2l5FJZwfbhT
 T5bKX1BMzriFJRb+vHtspWMrdrkp+HHzMZsCjWC0j1FftVrRVgePZ6Fyfy6DKboKgECI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGqtF-0002ea-QT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 04:46:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 551854094B;
 Wed, 14 Oct 2026 04:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541A41F000FF;
 Wed, 14 Oct 2026 04:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791953212;
 bh=kXD2GjwhdrNaOacUYXGcDRg2qS2dsXZ26SXag0ScQEQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=U0nVGai/btox4o7m+rnlgmn87HVj675DswCm7fGvqSQRPIqiUK1EWBlo/5NFDPmlg
 hyud5NVORz+PcEFB+YdhUZzPi765+CJGcPhCYQxNbwcFHcQcxE2zXW+XmTkJ7mosEQ
 mSYLMwnTvoWmzwKrtqlQMW8wctTXL0f2E1Zu/R90BIPEU/m18ZuqBPE0SDJPw1bn3N
 +CSTlHC1fQYHqY7bQaQmtF+s9druCs94JGp91RqyWurngWRzI70zvaTL3ODSAwwB/b
 gdhwU2/8bbyx19966uvZTjwecZSVSatYk97QZcucfk6RIcVYX71CSv9lIdpgUvJix9
 P0RaCAXLiEPew==
Message-ID: <c8760418-a4b1-4649-bbac-ca465fd5b73b@kernel.org>
Date: Wed, 14 Oct 2026 12:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20261002064853.37782-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20261002064853.37782-1-jsjlee1020@gmail.com>
X-Headers-End: 1xGqtF-0002ea-QT
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unnecessary reads in
 f2fs_update_meta_block()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/2/26 14:48, Seongjae Jeong wrote:
> When the packed SSA feature is enabled, f2fs_update_meta_block()
> uses f2fs_get_meta_cache_retry(), which reads the target block from
> disk if the cache entry is not uptodate.
> 
> However, f2fs_update_meta_block() overwrites the entire filesystem
> block with memcpy(), so the existing contents are not needed.
> Partial updates to packed SSA blocks are handled separately in
> write_sum_block().
> 
> Use f2fs_grab_meta_cache() unconditionally to avoid reading blocks
> that will be fully overwritten. Also remove the error check, since
> f2fs_grab_meta_cache() retries allocation failures internally and
> does not return an error pointer.
> 
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
