Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5150DD1CA15
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:16:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t8A30-0000k4-BB;
	Tue, 05 Nov 2024 03:16:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t8A2z-0000jp-9n
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 03:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eV5CnuhTR3otEWH2+t/X7s1ZUDcARwCU+1mykG/pD5c=; b=hwqcO4K0/9xHkkHNeu4qDAOfaW
 gfOLxojobbucUBgscTzs+5T2V+TzsXqSqckiqn/96ioH0bTH6sV90KrmAoCIrkzzy5GDNJygAy+OT
 1yMP+5QEnDR5Qn40pjOMu5A2xcKKugf4LyV2wmZ51tQc7vTz+KBxwmIrHcRL8oM80b6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eV5CnuhTR3otEWH2+t/X7s1ZUDcARwCU+1mykG/pD5c=; b=gTRsGvlQhGUg+VBf3hsWx3g0sJ
 GV0o75toX1TJOs+ZCDTTDXpkKdBe/1uGf2yfnwkWZw2fouumiH3gabwuXyrpaisFCuzjf3XqYDEqI
 AT9N57R/u0pEKOcpYHEZm2OZKUkEdHv3s1sSo/mCHXIoVJDzzXVpj70eC9bvY77CY2a4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t8A2y-0005H9-LR for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 03:16:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8493E5C56D7;
 Tue,  5 Nov 2024 03:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A1C4CECE;
 Tue,  5 Nov 2024 03:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730776550;
 bh=DYXSN1MfpgZ26ekPgjplaJVj/lw8x307aYQ/0XgHtU4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=UE/R62T5BX+eGYvqU2C3kKQxv23yQeGzxoXHNj0A5co4FYMlLgbBAKJpLhhoimG0k
 848q6aHGWddZrz6PeXNmQxOK8ljcSi/kpNFuZQrzoZpFv/Icp7/+SmyUpDlIusAnA0
 NXkQXxvtGalBM8PiVpxmf+OOusB3fghfvEmeWd5ULKwP45k15+xIGJwlvzk57EwNyQ
 eq1S8L6mQn594GSEXddbhDWH+LUA7oMEqTPKVcZ3bOijwB62HNJZYRyVmD/AN7DTzt
 rLh1lq5prVqYZ/spSYxLcdJImlt0TGDMPQJ1xaIKNGWmMC1lAwKVzli8R11qlCEpCe
 L7EhCtYRVsoew==
Message-ID: <888aaf87-1363-4c1f-bd95-d119c72d7b30@kernel.org>
Date: Tue, 5 Nov 2024 11:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1t8A2y-0005H9-LR
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix to adjust appropriate length
 for fiemap
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/4 9:56, Zhiguo Niu wrote:
> If user give a file size as "length" parameter for fiemap
> operations, but if this size is non-block size aligned,
> it will show 2 segments fiemap results even this whole file
> is contiguous on disk, such as the following results:
> 
>   ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> Fiemap: offset = 0 len = 19034
>          logical addr.    physical addr.   length           flags
> 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> 
> after this patch:
> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> Fiemap: offset = 0 len = 19034
>      logical addr.    physical addr.   length           flags
> 0    0000000000000000 00000000315f3000 0000000000005000 00001001

Hi Zhiguo,

Any testcase to reproduce this bug? w/o this patch, it looks output
from fiemap looks fine?

f2fs_io fiemap 0 19034 file
Fiemap: offset = 0 len = 19034
	logical addr.    physical addr.   length           flags
0	0000000000000000 0000000004401000 0000000000005000 00001001

Thanks,

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> V2: correct commit msg according to Chao's questions
> f2fs_io has been modified for testing, the length for fiemap is
> real file size, not block number
> ---
>   fs/f2fs/data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 306b86b0..9fc229d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   			goto out;
>   	}
>   
> -	if (bytes_to_blks(inode, len) == 0)
> -		len = blks_to_bytes(inode, 1);
> +	if (len & (blks_to_bytes(inode, 1) - 1))
> +		len = round_up(len, blks_to_bytes(inode, 1));
>   
>   	start_blk = bytes_to_blks(inode, start);
>   	last_blk = bytes_to_blks(inode, start + len - 1);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
