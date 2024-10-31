Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4815E68958
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:26:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6Pa1-0001z0-Vi;
	Thu, 31 Oct 2024 07:26:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t6Pa0-0001yu-Vt
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kOz9I2HXoKQsVa0ZLBVRrE1t6FFYIYtyYDuvM79ItkM=; b=YZE0SxFdBZzh6l0QmFMpDSWPQM
 Sb1/5ekTio5Wt1yrzSDmjpTY+u3pwC/u++WvkWrwbXj5egs3ezYp5cimgDRn50ECD+alAxYPwsUBX
 7JYhxXl/IlUrQxX4e1ximk+JaHl53q8lS397NkaHG+EAu8eSe4RGd9ovQfiCB8qERd5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kOz9I2HXoKQsVa0ZLBVRrE1t6FFYIYtyYDuvM79ItkM=; b=FYUyf5UmQBqaseQ/EJU5a2PZs8
 YzJnGOSMkPjsSuGGlCe0j6xIIwhaGQyuZ2NY9UvZbomzfRuZOrMh25aU6KT0MPXAbLMwmsHSFP8d/
 YfJ1Xe9DdYJfzIWfuXGcclbIeLjv7WD8laUIVtyUhikCgO+f8ysUO/c4LWQqckTSqffI=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6PZz-00089u-Ic for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:26:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 30850A43242;
 Thu, 31 Oct 2024 07:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF5C4CEC3;
 Thu, 31 Oct 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730359605;
 bh=R5MrToygnAnWBRaIJo+U8dMwcxWH2k2sEzsW0crF64E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=oSvhssApEEiqkdIQnOFF3OUyV6oLukghXdSuqQIJOzy7v7i5GWhGa75tD+yH18pEU
 l/b+hISBipwGpURQXghWZMVNb50QFGkN346S+doBxFEvq8B+zawTsPsiJCc3TdnvXi
 F+wtJHLxK0CMtW0qA5EDZ7DLkJqgTaphrXhAhfwRahshtYvATaN8uTOTLGaLuad96k
 2uongINHyddqj5LVTYwoXu/o+0lpnC/596g+HWDei39NfmNkzMp0HLlgEd0oQ6Z2Su
 QxQXhS6UQc8qbKmIzglH76+aSn7EaGyRQX6digLy+usfEZjOgRXV+FBRhECMpmTebC
 7lzUPJtBVtgVA==
Message-ID: <036ed265-23c1-4a16-a1bb-452b90e8cf1f@kernel.org>
Date: Thu, 31 Oct 2024 15:26:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
 <20241030103136.2874140-3-yi.sun@unisoc.com>
Content-Language: en-US
In-Reply-To: <20241030103136.2874140-3-yi.sun@unisoc.com>
X-Headers-End: 1t6PZz-00089u-Ic
Subject: Re: [f2fs-dev] [PATCH v2 2/5] f2fs: expand
 f2fs_invalidate_compress_page() to f2fs_invalidate_compress_pages_range()
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
 linux-f2fs-devel@lists.sourceforge.net, sunyibuaa@gmail.com,
 hao_hao.wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/30 18:31, Yi Sun wrote:
> New function f2fs_invalidate_compress_pages_range() adds the @len
> parameter. So it can process some consecutive blocks at a time.
> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>   fs/f2fs/compress.c | 7 ++++---
>   fs/f2fs/f2fs.h     | 9 +++++----
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7f26440e8595..e607a7885b57 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1903,11 +1903,12 @@ struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
>   	return sbi->compress_inode->i_mapping;
>   }
>   
> -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr)
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +				block_t blkaddr, unsigned int len)
>   {
> -	if (!sbi->compress_inode)
> +	if (!sbi->compress_inode || len == 0)

We can remove len == 0 check condition? Or any caller can pass 0 here?

Thanks,

>   		return;
> -	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr);
> +	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + len - 1);
>   }
>   
>   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3c6f3cce5779..d3fe66a93a56 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4384,7 +4384,8 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi);
>   int __init f2fs_init_compress_cache(void);
>   void f2fs_destroy_compress_cache(void);
>   struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
> -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t blkaddr);
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +					block_t blkaddr, unsigned int len);
>   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>   						nid_t ino, block_t blkaddr);
>   bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
> @@ -4439,8 +4440,8 @@ static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return
>   static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info *sbi) { }
>   static inline int __init f2fs_init_compress_cache(void) { return 0; }
>   static inline void f2fs_destroy_compress_cache(void) { }
> -static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi,
> -				block_t blkaddr) { }
> +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +				block_t blkaddr, unsigned int len) { }
>   static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
>   				struct page *page, nid_t ino, block_t blkaddr) { }
>   static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
> @@ -4759,7 +4760,7 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>   								block_t blkaddr)
>   {
>   	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
> -	f2fs_invalidate_compress_page(sbi, blkaddr);
> +	f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
>   }
>   
>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
