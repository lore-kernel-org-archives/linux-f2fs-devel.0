Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70852C5AD55
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzYtEq9rLIExaY0Vh5ahIU9i6BH60vz1G4eeJObsVkg=; b=AWui1TqfT2g1kx1bWzk23Xn3tW
	vFEHF56dt6A0aRhkpOzRJA6UbTyUB4PFAyn863a2OMRDEjgEU7ccK4FZVThfUjJwsWZABp7JyJZ7g
	f8AJdlhVbZ9ZKM7UUtfl2FMF/HG9v0R4fJLeJocSOcTjaBjkr/71KU/r4YEV3+Y6D/VM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtbbX-0001cU-Fv;
	Tue, 11 Aug 2026 01:48:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wtbbW-0001cJ-Km
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 01:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+GWjg8hBvbU7KU+S4PDCbfHpRBPfeUB/s6esOsf0QI=; b=QIlWAyBpkeHP8OFmLZ1n4VzFFN
 YRAcREz4ktRsF4Fp5NPHt9My2xr8V3dRwPMyjPnhbiy16Ft7G2upVDbnnx9ASxHc+F8VrEljNglJm
 3jdIxHNgXVX2iBAeIyPD9GhwwEMaYwEFJar7Q/IsjuC4RmbMPuHDfF+jV4ZYZXvyLaO0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I+GWjg8hBvbU7KU+S4PDCbfHpRBPfeUB/s6esOsf0QI=; b=nDmIPGDAlBgvKnU/WiqUBorGwN
 s4vbUr9jgO3/ut8im9TUJv+JpGO7mMjXD/GbsJZ27D3xLyWv7pqjgTrjG9JZ/c64Drm3aNedCCT19
 Z1t+MTHXAGJjHloj0qB3bWIVYhCoDvBsKM1OD+TDPE7jI7k4KPRrMEOwWndZk2WbyAWY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtbba-000206-HK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 01:48:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A6EA24186B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 01:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93F01F000E9;
 Tue, 11 Aug 2026 01:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786412909;
 bh=I+GWjg8hBvbU7KU+S4PDCbfHpRBPfeUB/s6esOsf0QI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=F/OY/br3TG2VGX882ECqcSfWDJd7fSp/STpNUurVUKAHf3XQ9+5bUYkar7rONd3Ww
 GxOXSmYQX4D1VUDsU8ZEZQLodC1/hA0Au7kIXRX9tBwJ1bfIoTbjjS1em8WoNIUfIk
 EHTjdLjAI+qSdAcQsjGN5wuKX9hD3fszZ0aLlXXnKel6RLdjxl08AxjPl6b/GznhxV
 YkqV4TeLN4BZj+9rz7rocRYkwFOJ2maxjAV14T32ijWPHQHOzYWBMHSVn0an/IljN/
 hXFCZ6E/Y3VNvd+tIUW1FWD1h0jSx9LpCzuZlswWV/CRvRZD+ED9AM0wZaOfoZ6uN7
 akxQ2IIDxxBMg==
Message-ID: <43d7f2ef-ddb4-46af-ab6d-eda8d15a4983@kernel.org>
Date: Tue, 11 Aug 2026 09:48:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260807220235.384637-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260807220235.384637-1-jaegeuk@kernel.org>
X-Headers-End: 1wtbba-000206-HK
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: refactor f2fs_evict_inode having
 three major parts
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/8/26 06:02, Jaegeuk Kim via Linux-f2fs-devel wrote:
> 1. f2fs_pre_evict_inode()
>  : drop all in-memory structures
> 
> 2. f2fs_delete_inode()
>  : truncate inode blocks, if it was unlinked.
> 
> 3. f2fs_post_evict_inode()
>  : update inode records for future access

That's a good cleanup! more clear now.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
