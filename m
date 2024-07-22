Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA71DC3DA5D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jul 2024 01:28:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sVhrF-0008Jn-DO;
	Mon, 22 Jul 2024 01:28:57 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sVhrE-0008Jc-3M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I0ZAzvxyLp1EQZ50jeSBhH+fe2d1rLs3wDBALUoUzHg=; b=HpHHqM0cMx6Jt3TWd039kwJvER
 ZIp3oFz+SG5CBXuM68UraEMWz3mxm5s2mD87AiZZMMteMcS5MZvYYC02aRFO5faXuvMamL73geBGr
 dQ5MYY6YY70lixbkaMsRml16611meZ2/s/ebDwSAp4jz/q9W1ISUdqE5HLLoMjVZp0es=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I0ZAzvxyLp1EQZ50jeSBhH+fe2d1rLs3wDBALUoUzHg=; b=lFNXAZH/7dg90VfzabiR6Pi5Is
 j5ezYdguLXjqZV3DLpimTF2b6jMz4ISjBFj0ZP3JVb3gsON3bg2YzWz1QwNv6QFHz6Rfrc9MlpSL9
 e36qkAuyJ4qsTWO1VoBU1//QUCX4YxkVbo3vcDCHRvYOez3YeBjZ1BrKsYehp7aCBNv0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sVhrD-0005uX-E2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:28:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 113F260A08;
 Mon, 22 Jul 2024 01:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6084C116B1;
 Mon, 22 Jul 2024 01:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721611729;
 bh=g2tSq9APFMR0Bl17C+GbBQhxN8oIR1MC2bDyCs6g6OE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KiyNexAXxxhWCzfOnl7t3ckfxAPOlNjcBSm3MJGrAZt1BJCpunm6IgWUOFyFyY027
 zun53EGWDkaCXAZ+sy4xJ/arOxe3rt5WbF4a4EWGMMcWIfthpr3jE3s6zLhAPc3RlN
 vXp+JkVI9dGAVrn8B7eC2j5501HP4r0fe+I3kB8iNOxVyO+i/wrtS5/plDxhr3BhJ3
 I2E/T41ff9Uy9aDhf6slsBT3QmuvmPSbFVE0DiUQU8Ly4uiprZ44AS6EUgUhum0LXm
 FWPAWRkiOLiK5teiaFkddVqyHus2RW4qwK+OzSjliDB9fy2RYG6ORy19Ly62Tb231n
 h93VfvPXCA+Dg==
Message-ID: <c81af94d-3b56-4169-b2eb-5d82623ab0af@kernel.org>
Date: Mon, 22 Jul 2024 09:28:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240720103349.3347764-1-yangyongpeng1@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240720103349.3347764-1-yangyongpeng1@oppo.com>
X-Headers-End: 1sVhrD-0005uX-E2
Subject: Re: [f2fs-dev] [PATCH] f2fs: free victim_secmap when pinned_secmap
 allocation fails
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/20 18:33, Yongpeng Yang wrote:
> In the init_victim_secmap function, if the allocation of
> dirty_i->pinned_secmap fails, dirty_i->victim_secmap is not
> freed, which can cause a memory leak.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> ---
>   fs/f2fs/segment.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 78c3198a6308..1e784ea3dbb4 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4971,8 +4971,10 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
>   		return -ENOMEM;
>   
>   	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> -	if (!dirty_i->pinned_secmap)
> +	if (!dirty_i->pinned_secmap) {
> +		kvfree(dirty_i->victim_secmap);

Yongpeng,

In below path, it will release pinned_secmap/victim_secmap?

- f2fs_destroy_segment_manager
  - destroy_victim_secmap
   : kvfree(dirty_i->pinned_secmap);
   : kvfree(dirty_i->victim_secmap);

Thanks,

>   		return -ENOMEM;
> +	}
>   
>   	dirty_i->pinned_secmap_cnt = 0;
>   	dirty_i->enable_pin_section = true;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
