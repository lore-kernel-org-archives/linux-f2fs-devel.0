Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AB3C76196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Apr 2023 23:26:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pm0tr-00037B-8Z;
	Mon, 10 Apr 2023 23:26:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pm0tp-000374-Hz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Apr 2023 23:26:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w1tH3cCWEn8tjZpJaqhgbOeNza+BQDMDB7Gu4heqh7E=; b=M6HTbBYM0B4qrFz7OSYco3AvuJ
 qITaf46j7eHqHZHgSUPWz4+ibS7c+W0k+cuPCiYqyjmv/iSkB75s60Uv57feMvdHYGRywuVpYSQuN
 6Or/XByWIsuKfYtXClf7HurYEYShZccfIBunB7/YKS3bLr7hRPuN5AME0Gw7WhL0qXTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w1tH3cCWEn8tjZpJaqhgbOeNza+BQDMDB7Gu4heqh7E=; b=LbKFJ2WdXWe5i1iLiTU/oqxUlY
 A5o4nbj8glZ2gHuwCVyKHSPQBFyqeDsVmz9Q6pA9UEEDzDW5TB0N+vsT4QaJ4xWH2Mls0Wa7v1Pnj
 6nc1UdYy8p2Qgj/EU8BHXtPpZdBJLA17n+sR2KCVbJMdxwSfhK7GhdLPUFuNYH44D7sI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pm0ti-0004LT-Jb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Apr 2023 23:26:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2D561FF8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Apr 2023 23:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88396C433EF;
 Mon, 10 Apr 2023 23:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681169160;
 bh=k5F1BKx94FTCrzsmWl/DeGGautLN/4tWce1bWlL7SUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QLCn1o5CPzO1qNasSSrgJbwVbR3j1cOJOrWztz134v8nfj3/2p42N/XrNhAIPStet
 eAzUW4Ck+8jKdM5fJZQV+ri77zPTSBpZLqt4Zj3duDcXleTJ2Z+pLMGRtP0cHiWsRT
 AGBSMGC+JvqRzOdcukzFuryO2yE78d2M3/0VjEqjI/wRP+nCZsht0QmqFU3ilXxaw4
 FswZMs6sFAE+E12FbM0IbOQdwPGvGHTvQIM2sisL0XAdoVA/cH3dt320QlcrzAk8dd
 1A5m2PssfNqj0mmCsObgde11BgIM8vvBr3S4UUDzMqnQileOfnhEexnPNIzjFdhkri
 y1Fz6nVcUlBRg==
Date: Mon, 10 Apr 2023 16:25:58 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZDSbBk8bD8meyGel@google.com>
References: <20230410093912.2184557-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230410093912.2184557-1-chao@kernel.org>
X-Headers-End: 1pm0ti-0004LT-Jb
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: fix to use spinlock to avoid
 page.private update race
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/10, Chao Yu wrote:
> There may be subtle race condition, make PagePrivate and page_private
> being inconsistent, result in decreasing page count incorrectly,
> introduce a per-inode spinlock to avoid such condition.

No...what have you found? The set/clear.. were supposed to be done in page_lock,
and checking the flag should not corrupt any memory.

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 19 ++++++++++++++++++-
>  fs/f2fs/super.c |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c378aedcadea..6b31bef5853e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -856,6 +856,8 @@ struct f2fs_inode_info {
>  
>  	unsigned int atomic_write_cnt;
>  	loff_t original_i_size;		/* original i_size before atomic write */
> +
> +	spinlock_t private_lock;	/* protect page->private */
>  };
>  
>  static inline void get_read_extent_info(struct extent_info *ext,
> @@ -1413,21 +1415,28 @@ static inline bool page_private_##name(struct page *page) \
>  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
>  
> +static inline struct f2fs_inode_info *F2FS_I(struct inode *inode);
>  #define PAGE_PRIVATE_SET_FUNC(name, flagname) \
>  static inline void set_page_private_##name(struct page *page) \
>  { \
> +	unsigned long flags; \
> +	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags); \
>  	if (!PagePrivate(page)) \
>  		attach_page_private(page, (void *)page->private); \
>  	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> +	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags); \
>  }
>  
>  #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
>  static inline void clear_page_private_##name(struct page *page) \
>  { \
> +	unsigned long flags; \
> +	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags); \
>  	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
> +	if (page_private(page) == (BIT(PAGE_PRIVATE_NOT_POINTER))) \
>  		detach_page_private(page); \
> +	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags); \
>  }
>  
>  PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
> @@ -1456,17 +1465,25 @@ static inline unsigned long get_page_private_data(struct page *page)
>  
>  static inline void set_page_private_data(struct page *page, unsigned long data)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags);
>  	if (!PagePrivate(page))
>  		attach_page_private(page, 0);
>  	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
>  	page_private(page) |= data << PAGE_PRIVATE_MAX;
> +	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags);
>  }
>  
>  static inline void clear_page_private_data(struct page *page)
>  {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&F2FS_I(page->mapping->host)->private_lock, flags);
>  	page_private(page) &= GENMASK(PAGE_PRIVATE_MAX - 1, 0);
>  	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER))
>  		detach_page_private(page);
> +	spin_unlock_irqrestore(&F2FS_I(page->mapping->host)->private_lock, flags);
>  }
>  
>  /* For compression */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a1b570a5e50f..555424dd85fd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1419,6 +1419,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	init_f2fs_rwsem(&fi->i_gc_rwsem[WRITE]);
>  	init_f2fs_rwsem(&fi->i_xattr_sem);
>  
> +	spin_lock_init(&fi->private_lock);
> +
>  	/* Will be used by directory only */
>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
>  
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
