Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A005C88CB6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jun 2023 14:38:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8ih4-0004ZF-A2;
	Mon, 12 Jun 2023 14:38:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q8ih3-0004Z9-7P
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 14:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+xuMGzhgQzvF0oSfNhAUt1/ZS5mZehbhHvuIZVcnZ2A=; b=hqrUH/Rf//0U9O5NuFmNM1eNFI
 dQrMn2emFMEGtQAEcCPngMVedy3SVA/g4zCMu+8rHxUBtkkr6jhWO+TvfgPxjuwJGps9pMOaByfb1
 0oDLzmYNiSStn0FQ+dzuUasgQDh+fLmcBh8R6kO8qfajcWyxYZGIzaWE8fPq4MInwQKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+xuMGzhgQzvF0oSfNhAUt1/ZS5mZehbhHvuIZVcnZ2A=; b=aC0WXtRPQX2wNKxX9pIYLCqHyU
 f1CztEZ1FX2YvwaNwzrORk8vURVFaA6FBHCOt6Z31dAPsfs7sNmM8vmZ1EAFSAz4/oKCEKffXDnT8
 3Hxbskxnfn/LLhiqzoPZr5KawJYzLLmbBtiUvnM5AU9+Bfn89fZ/1px9Jlh+H684nxps=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8igz-0004Jq-BB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 14:38:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EBFEF620A0;
 Mon, 12 Jun 2023 14:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FC6C433A1;
 Mon, 12 Jun 2023 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686580723;
 bh=gcogc2MHa/anB+TUpT1xFrrgFluTtUso9EJEcBuwueM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j9fmqTSsfjuhMrrIloRBYfqCcAKIl0C+hg6AJ7uKGF6ASRismfc+gJNawGKSLKTf/
 PFtahFp71ewjLRU0LT3kYtgc6FnHKAiM3AFioNpmo3rSA0qw48o8sChR28x3Dl/4N7
 Zq4FWMMOEn9hvk9F9vNbcVjb/4dEoJAETSW2SF/SwQh6vGI1mfB5Z6nJ6OXnaFp6VT
 E+p2W7Yu13ckbAzQirdtN18huUeSeLwN+vyNRglKsrQJCWlNn/ISB9t1UAm4ewnqg3
 w3v4K5NrFwK09hBwL5JwfZHxEMGTBzTl70hu8H9XGwCh6iCmCx2ovGgijvfccSVGVS
 Z0rcl4WUZp5OA==
Message-ID: <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
Date: Mon, 12 Jun 2023 22:38:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230609131555.56651-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230609131555.56651-1-frank.li@vivo.com>
X-Headers-End: 1q8igz-0004Jq-BB
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: don't force buffered io when
 in COMPR_MODE_USER mode
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
Cc: Qi Han <hanqi@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/9 21:15, Yangtao Li wrote:
> It is observed that when in user compression mode (compress_extension=*),
> even though the file is not compressed, the file is still forced to use
> buffer io, which makes the AndroBench sequential read and write drop
> significantly. In fact, when the file is not compressed, we don't need
> to force it to buffer io.
> 
>                   | w/o patch | w/ patch |
> seq read  (MB/s) | 1320.068  | 3696.154 |
> seq write (MB/s) | 617.996   | 2978.478 |
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h | 14 ++++++++++++++
>   fs/f2fs/file.c |  2 +-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1efcfd9e5a99..7f5472525310 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct inode *inode)
>   		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>   }
>   
> +static inline bool f2fs_is_compressed_file(struct inode *inode)
> +{
> +	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
> +
> +	if (compress_mode == COMPR_MODE_FS)
> +		return f2fs_compressed_file(inode);
> +	else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||

Should check dirty page as well? i_compr_blocks may increase after
data writeback.

Thanks,

> +		is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
> +		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
> +		return true;
> +
> +	return false;
> +}
> +
>   static inline bool f2fs_need_compress_data(struct inode *inode)
>   {
>   	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 74ecc9e20619..0698129b2165 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
>   		return true;
>   	if (fsverity_active(inode))
>   		return true;
> -	if (f2fs_compressed_file(inode))
> +	if (f2fs_is_compressed_file(inode))
>   		return true;
>   
>   	/* disallow direct IO if any of devices has unaligned blksize */


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
