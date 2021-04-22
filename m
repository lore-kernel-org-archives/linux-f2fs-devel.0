Return-Path: <SRS0=Edep=JT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A1C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Apr 2021 04:06:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0409613FB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Apr 2021 04:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0409613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lZQc3-00042e-HS; Thu, 22 Apr 2021 04:06:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lZQc2-00042X-Ne
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Apr 2021 04:06:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dYROMTxkIYSZ5w7ACDcSncWjAGZeaVlAjcJjEKxGLbU=; b=mmFNHXFhg78rQtJy3myAVsbv5Q
 aWiWomgi1qP6/FXzuimcvYXODKpgewOBLQgQlJklyxLt9ivFSL73XSLirCtTXgPSymEpNhpSA3SKA
 0XQIwfpOueOGoZ55H9wIZe6Phat9A5zr22DunTtKxCNnKtHQ8ObNOMvaZ+SklftVtCyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dYROMTxkIYSZ5w7ACDcSncWjAGZeaVlAjcJjEKxGLbU=; b=FbOdxtSXO/dt/wnuXYOT2ZvRC/
 MriCj33NEQehbmtOJ898QNlILmOb1i9//Ir8hM4ZDn+2RPgzK8dA1kxspJZhfnPjC3ERYyT3VjtSy
 SPr7esCokDIxuv/cps60jVhXTQg2nSikZedZk98gDW6UGCEPUhydZfMJQa1blNYDJK4Q=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lZQbz-00AvPN-W1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Apr 2021 04:06:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47ADA6144A;
 Thu, 22 Apr 2021 04:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619064398;
 bh=L4WeoQdEQp2U/UEJoCYX740XlkPBG+zGkFUwUApdLoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M6AF+kqoI0Qh46XYc31ul6i2VacORJiOre7HYr45y75VBMz8jKf9m4zsLN+Mpya+p
 o4H5lIoYO5Z2SyNNWvdprycN8QCQrPSKjlR+gj4pRpVx2Ybo9QJFMcJYuPD0PjZUXF
 CYioxVcQsc+uD87OdeLwxpzCuzKQEPdsoLIkOKYxq+vZvtZejrwYCZDaW6SN9rmfnF
 ptpq7CrRrYsqwrFHaNxZZMggJeYrz7p1iUkOAQXxVzSgjDYWDBs/PUKl0c0ewXhMny
 hu8i6nHu6bAQ0K8/6QIdiQrct8rEkGuzB0xFVWBdX1q/bWILg1Ve37rRmj/W8Wt5Ae
 UZIZLUFfTvNgg==
Date: Wed, 21 Apr 2021 21:06:36 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YID2TOCsgKdi0aLf@google.com>
References: <20210416095838.29568-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416095838.29568-1-yuchao0@huawei.com>
X-Headers-End: 1lZQbz-00AvPN-W1
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: reduce expensive checkpoint
 trigger frequency
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

On 04/16, Chao Yu wrote:
> We may trigger high frequent checkpoint for below case:
> 1. mkdir /mnt/dir1; set dir1 encrypted
> 2. touch /mnt/file1; fsync /mnt/file1
> 3. mkdir /mnt/dir2; set dir2 encrypted
> 4. touch /mnt/file2; fsync /mnt/file2
> ...
> 
> Although, newly created dir and file are not related, due to
> commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will
> trigger checkpoint whenever fsync() comes after a new encrypted dir
> created.

It'll happen once? How much impact will we hit due to this?

> 
> In order to avoid such condition, let's record an entry including
> directory's ino into global cache when we initialize encryption policy
> in a checkpointed directory, and then only trigger checkpoint() when
> target file's parent has non-persisted encryption policy, for the case
> its parent is not checkpointed, need_do_checkpoint() has cover that
> by verifying it with f2fs_is_checkpointed_node().
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h              | 2 ++
>  fs/f2fs/file.c              | 3 +++
>  fs/f2fs/xattr.c             | 6 ++++--
>  include/trace/events/f2fs.h | 3 ++-
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 87d734f5589d..34487e527d12 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -246,6 +246,7 @@ enum {
>  	APPEND_INO,		/* for append ino list */
>  	UPDATE_INO,		/* for update ino list */
>  	TRANS_DIR_INO,		/* for trasactions dir ino list */
> +	ENC_DIR_INO,		/* for encrypted dir ino list */
>  	FLUSH_INO,		/* for multiple device flushing */
>  	MAX_INO_ENTRY,		/* max. list */
>  };
> @@ -1090,6 +1091,7 @@ enum cp_reason_type {
>  	CP_FASTBOOT_MODE,
>  	CP_SPEC_LOG_NUM,
>  	CP_RECOVER_DIR,
> +	CP_ENC_DIR,
>  };
>  
>  enum iostat_type {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6284b2f4a60b..a6c38d8b1ec3 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -218,6 +218,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>  							TRANS_DIR_INO))
>  		cp_reason = CP_RECOVER_DIR;
> +	else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> +							ENC_DIR_INO))
> +		cp_reason = CP_ENC_DIR;
>  
>  	return cp_reason;
>  }
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index c8f34decbf8e..38796d488d15 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -630,6 +630,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  			const char *name, const void *value, size_t size,
>  			struct page *ipage, int flags)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_xattr_entry *here, *last;
>  	void *base_addr, *last_base_addr;
>  	int found, newsize;
> @@ -745,8 +746,9 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>  		f2fs_set_encrypted_inode(inode);
>  	f2fs_mark_inode_dirty_sync(inode, true);
> -	if (!error && S_ISDIR(inode->i_mode))
> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> +	if (!error && S_ISDIR(inode->i_mode) &&
> +			f2fs_is_checkpointed_node(sbi, inode->i_ino))
> +		f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);

Is it right to say ENC_DIR_INO in this case?

>  
>  same:
>  	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 56b113e3cd6a..ca0cf12226e9 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -145,7 +145,8 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
>  		{ CP_NODE_NEED_CP,	"node needs cp" },		\
>  		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
>  		{ CP_SPEC_LOG_NUM,	"log type is 2" },		\
> -		{ CP_RECOVER_DIR,	"dir needs recovery" })
> +		{ CP_RECOVER_DIR,	"dir needs recovery" },		\
> +		{ CP_ENC_DIR,		"persist encryption policy" })
>  
>  #define show_shutdown_mode(type)					\
>  	__print_symbolic(type,						\
> -- 
> 2.29.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
