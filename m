Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1E2C3DA61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jul 2024 01:32:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sVhur-00087B-P8;
	Mon, 22 Jul 2024 01:32:41 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sVhuq-00086w-8O
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hj2f6hCyFhCJrJ8499Daws5Ix+0JPRtWbNXvkrW6Z/U=; b=D5G/C9zlv9tffAFVNXcHfzN2Oc
 ltuInflmA1XVnO1ZeoohSJ6Xm0ukWcvfhPtRlmjwVORxIpofciffeWgBZJQTp/Ee/sjAveEFc6fB1
 +d0yT2/VPFQcPvR529hUqupJl25RCQgrdOCjez5sx177gUu+hWsaLLKxNDfPUWbntr3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hj2f6hCyFhCJrJ8499Daws5Ix+0JPRtWbNXvkrW6Z/U=; b=SqKQf7edDxzY2wjlOVRpwzbOvu
 7f5+5WL+QBQdF2WLGrsic3AQB1C1GwO4/oITG529wD+pZu42Hat8RQxTGsfGJatzkpXj54FIxkfld
 4ldZv82tmj1yYPCp3kOpL+FBe+mUosEl+uXqo0Q/3MLA4LInzRMIyhhQFyYamNaCjkYE=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sVhup-0006Dc-EP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jul 2024 01:32:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B2A68CE0AD0;
 Mon, 22 Jul 2024 01:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E10C116B1;
 Mon, 22 Jul 2024 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721611952;
 bh=B0bJ2VtHVVdmTBJWPJmBM305+NnqV3hqROops5gLPk8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y23Zq53doO6YekDP+Rb8qQYS+oMaFdYhzbHY6jEXUgrYLe67wNQqPNCdxHHyLTMYP
 mKWrlZy2aEW94dccxMGpXn7+nlQQlwhsgaB/aVWD0sU/LCAmJDEUqUaHTU9lU/uCGN
 SlH9YnaguA+rp1HNz9DBoaSHUcH6gKn7gCioJFi5skHuO9uKBKIT4UPev8ILM6Hbd9
 szbm5rajkjesO5z0w+PmTqKEJQkl7uXle6CeZvfU5hH9F9Jwks2kx43pQd/tl9kYgN
 O3rH1kCp/wmYXzPfi5FdxoYP2KJLTnZzQJ60OgLc4WMFKNWZftA/Ixy6HfwxmetThw
 Gm6N8hHRJHU1A==
Message-ID: <843887b0-72af-4df3-8cad-bff0d9fc85f7@kernel.org>
Date: Mon, 22 Jul 2024 09:32:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julian Sun <sunjunchao2870@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240721131739.260027-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240721131739.260027-1-sunjunchao2870@gmail.com>
X-Headers-End: 1sVhup-0006Dc-EP
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix macro definition
 on_f2fs_build_free_nids
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
Cc: jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/21 21:17, Julian Sun wrote:
> The macro on_f2fs_build_free_nids accepts a parameter nmi,
> but it was not used, rather the variable nm_i was directly used,
> which may be a local variable inside a function that calls the macros.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>   fs/f2fs/node.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index b72ef96f7e33..34eeb2a8598c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -20,7 +20,7 @@
>   #include "iostat.h"
>   #include <trace/events/f2fs.h>
>   
> -#define on_f2fs_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
> +#define on_f2fs_build_free_nids(nmi) mutex_is_locked(&(nmi)->build_lock)

It's better to use nm_i instead of nmi?

Thanks,

>   
>   static struct kmem_cache *nat_entry_slab;
>   static struct kmem_cache *free_nid_slab;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
