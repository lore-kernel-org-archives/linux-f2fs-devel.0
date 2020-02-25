Return-Path: <SRS0=Co/T=4N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931EC35DF2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:37:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520CF21556
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lpWFwxW7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iYU0Xb2f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzJx44Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520CF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j6Tqd-0005Vr-Hj; Tue, 25 Feb 2020 06:37:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1j6Tqb-0005Vj-FX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Feb 2020 06:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=; b=lpWFwxW7/irdMH/Pn500fwbX6H
 Hrmm0RQ4d9r0u6sjNl/TglHY86b5HO/7HeT368QT6y8+PxXPxf/GGFTXITaAQA2MAe2E31Gn7JQLu
 tyOBJQGuijtu/BqCjsWC/P/n8bp3l75iKYxhGT/tULYL5ORWx74Adkm+K+FcDoNUCnaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=; b=iYU0Xb2fnfJtjTPRHr5nJm+jah
 bpJznweVjwgL6I5WWyQIyHCcIE/2BgHryWhHFFNbeCkPgiUjy7IiLQTSXJPcZkCRFRmFbEi0hs8a/
 qXARCcJ+Q9oqVQOlvEZUma8cgKR3k6b04cHchqzmhpq49+FFv2bRYeT+83t1Z2IoH3Qw=;
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1j6TqZ-00Fl2P-KI
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Feb 2020 06:37:37 +0000
Received: by mail-ua1-f68.google.com with SMTP id y23so4147459ual.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Feb 2020 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=;
 b=pzJx44Reo3ZBGEHnlCeQRfKf6QzDFvJC9/ESlgVuvLhTrtTskumX6XphWt72F8lz2i
 XWG7l+mZMXdlrk4XyHjwoZ2bGXyjL40Em6EI3SXpPaottaA42LL7Yxjncjsjvq8DVZBS
 xANCTPnmEOLJNgY76ATtZfAuZpceX2T7nMLZT11M3xhVFssAl+bKzexO0s0Wy/a38ey8
 dFtKBGVNfXr40Kk0G6g3xWCeo2XUttx5hCAHD9YltgGe6OIe0UoEo61IIq0bqm4VSskd
 7voyXOOKTMUYEXt24mxb5bC8k19X0RxbRg+sXmbt+kSflI3bx4byu1jJM2sMCWToaYPc
 jQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LHa86/wmoQGkRYQ2PfZCXHRW/f0snyckDltYTbnlufE=;
 b=uhGqvoMlX4DviL0AQnxXNdKX0qoml0X992O/sk5kM7FnW4KDjGc2qokV2VZSKM0ZBi
 KR9ctpB7EvDiOzi0Bgd5xwOKRHRjqOGU0BzzSuJdfO33J5pBdvNOzhn5EXj+msidKePN
 IY+6BIczhBpFE8dKSbf38wCvGn/3Sykblv2Y4bIz1/uD+H5pBhZsRjeiZOLbW0UiNAZt
 0Udkjqm7hpezqqGuiF2/1LAAshSoPiLIoIfDy1cJFrLZ15Zj40q+/kAyLjzni6crjr/L
 YiHLd4K6OussX2uBYjNRr4bdD0C8MIyjFSA/oMydIJD0yrT5d7H6ZK5N/d04gPTXCrVx
 N3Mw==
X-Gm-Message-State: APjAAAU96Z4d1r8p4bZvWR9md4pRvot9l5wwux32zjt7oB2JRvsczKuK
 XazNdAONRr4soXoxAbgFf3RN7kU+iMsf5eBXfOM=
X-Google-Smtp-Source: APXvYqzWdH//9SDcefrBf8q8Pc8ls6MeTd2RiJR/hUevj+GxiRAGu4sYxICkgWb19+cfsw33A4kPRXcDuzHjBAIjbS4=
X-Received: by 2002:ab0:374a:: with SMTP id i10mr26445743uat.97.1582612647087; 
 Mon, 24 Feb 2020 22:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225014257.83903-1-yuchao0@huawei.com>
In-Reply-To: <20200225014257.83903-1-yuchao0@huawei.com>
From: Ju Hyung Park <qkrwngud825@gmail.com>
Date: Tue, 25 Feb 2020 15:37:15 +0900
Message-ID: <CAD14+f0e5RsntWQk+0=_6f0rJt=0GNBQBZZ3BqjbQzZqJ7f4iw@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1j6TqZ-00Fl2P-KI
Subject: Re: [f2fs-dev] [PATCH] f2fs: use kmem_cache pool during inline
 xattr lookups
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao.

Sorry for the late reply, I've been busy with my uni stuffs.

It's nice to see this issue getting some attentions back, but
unfortunately, I can't test it at the moment.

Here's the patch we used to see the alloc statistics:
https://pastebin.com/bhBh2dgs by Sultan Alsawaf.

Hope it helps.

On Tue, Feb 25, 2020 at 10:43 AM Chao Yu <yuchao0@huawei.com> wrote:
>
> It's been observed that kzalloc() on lookup_all_xattrs() are called millions
> of times on Android, quickly becoming the top abuser of slub memory allocator.
>
> Use a dedicated kmem cache pool for xattr lookups to mitigate this.
>
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>
> Hi, Ju Hyung,
>
> Let me know if you have any objection on this patch. :)
>
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c | 10 ++++++++-
>  fs/f2fs/xattr.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-----
>  fs/f2fs/xattr.h |  4 ++++
>  4 files changed, 65 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 12a197e89a3e..23b93a116c73 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1486,6 +1486,9 @@ struct f2fs_sb_info {
>         __u32 s_chksum_seed;
>
>         struct workqueue_struct *post_read_wq;  /* post read workqueue */
> +
> +       struct kmem_cache *inline_xattr_slab;   /* inline xattr entry */
> +       unsigned int inline_xattr_slab_size;    /* default inline xattr slab size */
>  };
>
>  struct f2fs_private_dio {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d241e07c0bfa..0b16204d3b7d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1201,6 +1201,7 @@ static void f2fs_put_super(struct super_block *sb)
>         kvfree(sbi->raw_super);
>
>         destroy_device_list(sbi);
> +       f2fs_destroy_xattr_caches(sbi);
>         mempool_destroy(sbi->write_io_dummy);
>  #ifdef CONFIG_QUOTA
>         for (i = 0; i < MAXQUOTAS; i++)
> @@ -3457,12 +3458,17 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>                 }
>         }
>
> +       /* init per sbi slab cache */
> +       err = f2fs_init_xattr_caches(sbi);
> +       if (err)
> +               goto free_io_dummy;
> +
>         /* get an inode for meta space */
>         sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
>         if (IS_ERR(sbi->meta_inode)) {
>                 f2fs_err(sbi, "Failed to read F2FS meta data inode");
>                 err = PTR_ERR(sbi->meta_inode);
> -               goto free_io_dummy;
> +               goto free_xattr_cache;
>         }
>
>         err = f2fs_get_valid_checkpoint(sbi);
> @@ -3735,6 +3741,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>         make_bad_inode(sbi->meta_inode);
>         iput(sbi->meta_inode);
>         sbi->meta_inode = NULL;
> +free_xattr_cache:
> +       f2fs_destroy_xattr_caches(sbi);
>  free_io_dummy:
>         mempool_destroy(sbi->write_io_dummy);
>  free_percpu:
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index a3360a97e624..e46a10eb0e42 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -23,6 +23,25 @@
>  #include "xattr.h"
>  #include "segment.h"
>
> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
> +{
> +       *is_inline = (size == sbi->inline_xattr_slab_size);
> +
> +       if (*is_inline)
> +               return kmem_cache_zalloc(sbi->inline_xattr_slab, GFP_NOFS);
> +
> +       return f2fs_kzalloc(sbi, size, GFP_NOFS);
> +}
> +
> +static void xattr_free(struct f2fs_sb_info *sbi, void *xattr_addr,
> +                                                       bool is_inline)
> +{
> +       if (is_inline)
> +               kmem_cache_free(sbi->inline_xattr_slab, xattr_addr);
> +       else
> +               kvfree(xattr_addr);
> +}
> +
>  static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
>                 struct dentry *unused, struct inode *inode,
>                 const char *name, void *buffer, size_t size)
> @@ -301,7 +320,8 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
>  static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>                                 unsigned int index, unsigned int len,
>                                 const char *name, struct f2fs_xattr_entry **xe,
> -                               void **base_addr, int *base_size)
> +                               void **base_addr, int *base_size,
> +                               bool *is_inline)
>  {
>         void *cur_addr, *txattr_addr, *last_txattr_addr;
>         void *last_addr = NULL;
> @@ -313,7 +333,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>                 return -ENODATA;
>
>         *base_size = XATTR_SIZE(inode) + XATTR_PADDING_SIZE;
> -       txattr_addr = f2fs_kzalloc(F2FS_I_SB(inode), *base_size, GFP_NOFS);
> +       txattr_addr = xattr_alloc(F2FS_I_SB(inode), *base_size, is_inline);
>         if (!txattr_addr)
>                 return -ENOMEM;
>
> @@ -362,7 +382,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>         *base_addr = txattr_addr;
>         return 0;
>  out:
> -       kvfree(txattr_addr);
> +       xattr_free(F2FS_I_SB(inode), txattr_addr, *is_inline);
>         return err;
>  }
>
> @@ -499,6 +519,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>         unsigned int size, len;
>         void *base_addr = NULL;
>         int base_size;
> +       bool is_inline;
>
>         if (name == NULL)
>                 return -EINVAL;
> @@ -509,7 +530,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>
>         down_read(&F2FS_I(inode)->i_xattr_sem);
>         error = lookup_all_xattrs(inode, ipage, index, len, name,
> -                               &entry, &base_addr, &base_size);
> +                               &entry, &base_addr, &base_size, &is_inline);
>         up_read(&F2FS_I(inode)->i_xattr_sem);
>         if (error)
>                 return error;
> @@ -532,7 +553,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>         }
>         error = size;
>  out:
> -       kvfree(base_addr);
> +       xattr_free(F2FS_I_SB(inode), base_addr, is_inline);
>         return error;
>  }
>
> @@ -767,3 +788,26 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
>         f2fs_update_time(sbi, REQ_TIME);
>         return err;
>  }
> +
> +int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi)
> +{
> +       dev_t dev = sbi->sb->s_bdev->bd_dev;
> +       char slab_name[32];
> +
> +       sprintf(slab_name, "f2fs_xattr_entry-%u:%u", MAJOR(dev), MINOR(dev));
> +
> +       sbi->inline_xattr_slab_size = F2FS_OPTION(sbi).inline_xattr_size *
> +                                       sizeof(__le32) + XATTR_PADDING_SIZE;
> +
> +       sbi->inline_xattr_slab = f2fs_kmem_cache_create(slab_name,
> +                                       sbi->inline_xattr_slab_size);
> +       if (!sbi->inline_xattr_slab)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi)
> +{
> +       kmem_cache_destroy(sbi->inline_xattr_slab);
> +}
> diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
> index 574beea46494..7345dfa7b7a9 100644
> --- a/fs/f2fs/xattr.h
> +++ b/fs/f2fs/xattr.h
> @@ -131,6 +131,8 @@ extern int f2fs_setxattr(struct inode *, int, const char *,
>  extern int f2fs_getxattr(struct inode *, int, const char *, void *,
>                                                 size_t, struct page *);
>  extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
> +extern int f2fs_init_xattr_caches(struct f2fs_sb_info *);
> +extern void f2fs_destroy_xattr_caches(struct f2fs_sb_info *);
>  #else
>
>  #define f2fs_xattr_handlers    NULL
> @@ -151,6 +153,8 @@ static inline ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer,
>  {
>         return -EOPNOTSUPP;
>  }
> +static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
> +static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
>  #endif
>
>  #ifdef CONFIG_F2FS_FS_SECURITY
> --
> 2.18.0.rc1
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
