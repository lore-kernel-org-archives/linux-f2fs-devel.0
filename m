Return-Path: <SRS0=KF8H=3Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A4EC35247
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 01:58:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6F62082E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 01:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YxzC0/hB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ChASs8rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6F62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iz9xk-0004TI-K2; Wed, 05 Feb 2020 01:58:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iz9xj-0004T4-8C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 01:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPZQz+BU4+oDvBFsOwqX0DjV6lpn5Jlh7EVg7dsAiaw=; b=YxzC0/hBsyESYd7Sq32j6P9DYk
 xvfxBkoM1cnNdqYVtbNMYYCeQL4EmK1T9KU0aNrUjqrwh3GnbNSszNIp9MR02wBGcH2Zt5WRnWoOd
 dvzJ2LM7Oigwr6VJPIo/ZATTwxkpTsQo5PGImPf6JIgnZws1M9F+kJtVt87tAyJTXyNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kPZQz+BU4+oDvBFsOwqX0DjV6lpn5Jlh7EVg7dsAiaw=; b=ChASs8rPXQwLe2h4mB7wJDSNll
 u7Hy8wb/Mz9IsT5q5Y4y8eRKNvNiIy+ykhc6zMVWqBE1hG7b/InzXqyKIILrHVHPumdQgDFeUu3IU
 A6RFtBDRZi9BJQD1hlhHsT6U4iaH8VKIKusU3kS4oJCVh1oL7TfDUUXX6MV+/wjakw2w=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iz9xg-00AVmn-Ta
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 01:58:43 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C58F14B6B979FCF636BB;
 Wed,  5 Feb 2020 09:58:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 5 Feb 2020
 09:58:30 +0800
To: Matthew Wilcox <willy@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <linux-fsdevel@vger.kernel.org>
References: <20200201150807.17820-1-willy@infradead.org>
 <20200203033903.GB8731@bombadil.infradead.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bd08bf56-f901-33b1-5151-f77fd823e343@huawei.com>
Date: Wed, 5 Feb 2020 09:58:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200203033903.GB8731@bombadil.infradead.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iz9xg-00AVmn-Ta
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Make f2fs_readpages readable again
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/2/3 11:39, Matthew Wilcox wrote:
> 
> Remove the horrendous ifdeffery by slipping an IS_ENABLED into
> f2fs_compressed_file().

I'd like to suggest to use

if (IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) && f2fs_compressed_file(inode))

here to clean up f2fs_readpages' codes.

Otherwise, f2fs module w/o compression support will not recognize compressed
file in most other cases if we add IS_ENABLED() condition into
f2fs_compressed_file().

Thanks,

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix compilation by adding more dummy functions
> 
>  fs/f2fs/data.c |  6 ------
>  fs/f2fs/f2fs.h | 10 +++++++++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8bd9afa81c54..41156a8f60a7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2203,7 +2203,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  				goto next_page;
>  		}
>  
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_compressed_file(inode)) {
>  			/* there are remained comressed pages, submit them */
>  			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
> @@ -2230,14 +2229,11 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  			goto next_page;
>  		}
>  read_single_page:
> -#endif
>  
>  		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
>  					&bio, &last_block_in_bio, is_readahead);
>  		if (ret) {
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  set_error_page:
> -#endif
>  			SetPageError(page);
>  			zero_user_segment(page, 0, PAGE_SIZE);
>  			unlock_page(page);
> @@ -2246,7 +2242,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  		if (pages)
>  			put_page(page);
>  
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_compressed_file(inode)) {
>  			/* last page */
>  			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
> @@ -2257,7 +2252,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  				f2fs_destroy_compress_ctx(&cc);
>  			}
>  		}
> -#endif
>  	}
>  	BUG_ON(pages && !list_empty(pages));
>  	if (bio)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5355be6b6755..e90d2b3f1d2d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2706,7 +2706,8 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
>  
>  static inline int f2fs_compressed_file(struct inode *inode)
>  {
> -	return S_ISREG(inode->i_mode) &&
> +	return IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) &&
> +		S_ISREG(inode->i_mode) &&
>  		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>  }
>  
> @@ -3797,6 +3798,13 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
>  	WARN_ON_ONCE(1);
>  	return ERR_PTR(-EINVAL);
>  }
> +#define f2fs_cluster_can_merge_page(cc, index)	false
> +#define f2fs_read_multi_pages(cc, bio, nr_pages, last, is_ra) 0
> +#define f2fs_init_compress_ctx(cc) 0
> +#define f2fs_destroy_compress_ctx(cc) (void)0
> +#define f2fs_cluster_is_empty(cc) true
> +#define f2fs_compress_ctx_add_page(cc, page) (void)0
> +#define f2fs_is_compressed_cluster(cc, index) false
>  #endif
>  
>  static inline void set_compress_context(struct inode *inode)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
