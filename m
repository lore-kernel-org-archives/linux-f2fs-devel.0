Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C482C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdQWqgzA4i8qHYV9SAEgi2piBQIiRmG9vakOOvaxI8Q=; b=Yw65js35h5wENQ2fT+WGcL4gg9
	ifQ+8UxWh4Fq+cMqXCtFKor9K8lqHOC+IF3Hg4tO7AAo9gqpyz8conHOi9h/+CYcCs00OlXchj4NF
	YXuOMUdIcbFK8A+VFuXJ3qqDXhBRJnnbmqNV2uMqKwwZxBTWAeX9n/FakZIMMftUhB6M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnGV-0002NG-7J;
	Mon, 03 Aug 2026 07:39:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqnGU-0002N5-Ll
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:39:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fejKHcPM2ITUhqGAzQ+zd1iL7MlkWRA5eMaBt7uQOrY=; b=QWehuIBasGRIxkzcOUyJ96yMBi
 hgqXfcujtZSmH6jaSMQXP19DRZEI9jGYLjUg3ycLSEfJL2xVGeoJAmRK9rb5WXQnjOz671hz94xha
 /Pk2riOYXcCoZB7OSiRWz3qVKkTnPim6l9vwetZcmL2RmKI9kDxbNEfnVpS7ZVLKg/e4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fejKHcPM2ITUhqGAzQ+zd1iL7MlkWRA5eMaBt7uQOrY=; b=F0Mo/RHABqrRiu28tBYPYXKO5l
 xeWmqXV2aFm55QTZiMuqo9w8gfXW3v4s8pTKRsMMSwZaQxn2k+ms2/QW8kQRQ3wUbRyF9uiJiCs+v
 qLwafN+yl0YtUYkV8FIDQEgHHPilu5Voc1Xs6q1gSJ2w1AJTHJTJNJVqHpYwTsYE6vV4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnGU-0006s6-I1 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:39:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFA9C438AF;
 Mon,  3 Aug 2026 07:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D311F00A3A;
 Mon,  3 Aug 2026 07:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785742748;
 bh=fejKHcPM2ITUhqGAzQ+zd1iL7MlkWRA5eMaBt7uQOrY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LMRdESgwY+8jtpGWjXA5C7Lr5qXvWRppNMiOfBW1WqJZ6O9fXkK87G3WylRNejc/W
 VdMB2BxMXCYaWSZKIQE7ok3vMnArpzK23t5UeoaNSqaaY5TEKA4Y1sGzh2kt/IFnuk
 g4Y0M8luZHxmpwc3UepuNmsru1a66s8GxPEEx9fD52CHPxqr1T8J8R401AzF23vcxK
 7CmY4atNTOFUMJkSpqCoUX8Wy69nUUrlsPxAQA07HZwwSWzRLwIBrq75Hg+YNnJLWz
 ks+6aw4mA6ZfJs6HvOzJPhBz1klRP9eZtlVaO9UZ0+BBtPAi151eDRttP15r1rvLMJ
 Wk5/lC+GEvvHw==
Message-ID: <f5584be3-e251-41c1-a7c9-e5241521133a@kernel.org>
Date: Mon, 3 Aug 2026 15:39:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260723193544.2462174-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260723193544.2462174-1-daeho43@gmail.com>
X-Headers-End: 1wqnGU-0006s6-I1
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: handle find_next_free_block
 failure gracefully
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/24/26 03:35, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When find_next_free_block() fails to allocate a free block, callers like
> move_one_curseg_info(), reserve_new_block(), and update_block() previously
> crashed via ASSERT().

Seems there are a lot of ASSERT() in path of above functions? e.g.

f2fs_create

	/* write child */
	set_summary(&sum, de->ino, 0, ni.version);
	ret = reserve_new_block(sbi, &blkaddr, &sum, CURSEG_HOT_NODE, 1);
	nodeblk_alloced = true;
	ASSERT(!ret);

convert_inline_dentry

	ret = update_block(sbi, node, p_blkaddr, NULL);
	ASSERT(ret >= 0);

Can you please take a look?

> 
> Replace these ASSERT() calls with proper error propagation to gracefully
> abort FSCK execution instead of crashing.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/fsck.c    | 22 +++++++++++++++-------
>   fsck/fsck.h    |  8 ++++----
>   fsck/main.c    |  4 +++-
>   fsck/mount.c   | 28 ++++++++++++++++++----------
>   fsck/segment.c |  8 ++++----
>   5 files changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index db44f9d..b128617 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2972,13 +2972,15 @@ int check_curseg_offsets(struct f2fs_sb_info *sbi, bool check_wp)
>   	return 0;
>   }
>   
> -static void fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
> +static int fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
>   {
> -	int i, need_update = 0;
> +	int i, need_update = 0, ret;
>   
>   	for (i = 0; i < NO_CHECK_TYPE; i++) {
>   		if (check_curseg_offset(sbi, i, check_wp)) {
> -			update_curseg_info(sbi, i);
> +			ret = update_curseg_info(sbi, i);

Another caller of fix_curseg_info(), fsck_verify() will accept the failure silently,
I think it needs to propagate the error to do_fsck().

Thanks,

> +			if (ret)
> +				return ret;
>   			need_update = 1;
>   		}
>   	}
> @@ -2987,6 +2989,7 @@ static void fix_curseg_info(struct f2fs_sb_info *sbi, bool check_wp)
>   		write_curseg_info(sbi);
>   		flush_curseg_sit_entries(sbi);
>   	}
> +	return 0;
>   }
>   
>   int check_sit_types(struct f2fs_sb_info *sbi)
> @@ -3595,23 +3598,28 @@ static void fix_wp_sit_alignment(struct f2fs_sb_info *UNUSED(sbi))
>    * Check and fix consistency with write pointers at the beginning of
>    * fsck so that following writes by fsck do not fail.
>    */
> -void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
> +int fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi)
>   {
>   	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	int ret = 0;
>   
>   	if (c.zoned_model != F2FS_ZONED_HM)
> -		return;
> +		return 0;
>   
>   	if (c.fix_on) {
>   		flush_nat_journal_entries(sbi);
>   		flush_sit_journal_entries(sbi);
>   
> -		if (check_curseg_offsets(sbi, true))
> -			fix_curseg_info(sbi, true);
> +		if (check_curseg_offsets(sbi, true)) {
> +			ret = fix_curseg_info(sbi, true);
> +			if (ret)
> +				return ret;
> +		}
>   
>   		fix_wp_sit_alignment(sbi);
>   		fsck->chk.wp_fixed = 1;
>   	}
> +	return 0;
>   }
>   
>   int fsck_chk_curseg_info(struct f2fs_sb_info *sbi)
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 05daa2d..ec37e08 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -190,7 +190,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
>   void fsck_chk_checkpoint(struct f2fs_sb_info *sbi);
>   void fsck_update_sb_flags(struct f2fs_sb_info *sbi);
>   int fsck_chk_meta(struct f2fs_sb_info *sbi);
> -void fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *);
> +int fsck_chk_and_fix_write_pointers(struct f2fs_sb_info *sbi);
>   int fsck_chk_curseg_info(struct f2fs_sb_info *);
>   void pretty_print_filename(const u8 *raw_name, u32 len,
>   			   char out[F2FS_PRINT_NAMELEN], int enc_name);
> @@ -227,11 +227,11 @@ extern int f2fs_find_fsync_inode(struct f2fs_sb_info *, struct list_head *);
>   extern void f2fs_destroy_fsync_dnodes(struct list_head *);
>   
>   extern void flush_journal_entries(struct f2fs_sb_info *);
> -extern void update_curseg_info(struct f2fs_sb_info *, int);
> +extern int update_curseg_info(struct f2fs_sb_info *sbi, int type);
>   extern void zero_journal_entries(struct f2fs_sb_info *);
>   extern void flush_sit_entries(struct f2fs_sb_info *);
> -extern void move_curseg_info(struct f2fs_sb_info *, u64, int);
> -extern void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
> +extern int move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left);
> +extern int move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
>   				 int i);
>   extern void write_curseg_info(struct f2fs_sb_info *);
>   extern void save_curseg_warm_node_info(struct f2fs_sb_info *);
> diff --git a/fsck/main.c b/fsck/main.c
> index 08d38d8..460e4db 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -985,7 +985,9 @@ static int do_fsck(struct f2fs_sb_info *sbi)
>   	if (c.roll_forward && c.zoned_model == F2FS_ZONED_HM)
>   		save_curseg_warm_node_info(sbi);
>   
> -	fsck_chk_and_fix_write_pointers(sbi);
> +	ret = fsck_chk_and_fix_write_pointers(sbi);
> +	if (ret)
> +		return FSCK_OPERATIONAL_ERROR;
>   
>   	fsck_chk_curseg_info(sbi);
>   
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 6f640a0..85ed404 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -3159,7 +3159,7 @@ next_segment:
>   	return -1;
>   }
>   
> -void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
> +int move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
>   				 int i)
>   {
>   	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> @@ -3171,7 +3171,7 @@ void move_one_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left,
>   
>   	if ((get_sb(feature) & F2FS_FEATURE_RO)) {
>   		if (i != CURSEG_HOT_DATA && i != CURSEG_HOT_NODE)
> -			return;
> +			return 0;
>   
>   		if (i == CURSEG_HOT_DATA) {
>   			left = 0;
> @@ -3191,7 +3191,10 @@ bypass_ssa:
>   	to = from;
>   	ret = find_next_free_block(sbi, &to, left, i,
>   				   c.zoned_model == F2FS_ZONED_HM);
> -	ASSERT(ret == 0);
> +	if (ret) {
> +		ERR_MSG("Failed to find next free block for curseg[%d]\n", i);
> +		return ret;
> +	}
>   
>   	old_segno = curseg->segno;
>   	curseg->segno = GET_SEGNO(sbi, to);
> @@ -3211,22 +3214,27 @@ bypass_ssa:
>   
>   	FIX_MSG("Move curseg[%d] %x -> %x after %"PRIx64"\n",
>   		i, old_segno, curseg->segno, from);
> +	return 0;
>   }
>   
> -void move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left)
> +int move_curseg_info(struct f2fs_sb_info *sbi, u64 from, int left)
>   {
> -	int i;
> +	int i, ret;
>   
>   	/* update summary blocks having nullified journal entries */
> -	for (i = 0; i < NO_CHECK_TYPE; i++)
> -		move_one_curseg_info(sbi, from, left, i);
> +	for (i = 0; i < NO_CHECK_TYPE; i++) {
> +		ret = move_one_curseg_info(sbi, from, left, i);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
>   }
>   
> -void update_curseg_info(struct f2fs_sb_info *sbi, int type)
> +int update_curseg_info(struct f2fs_sb_info *sbi, int type)
>   {
>   	if (!relocate_curseg_offset(sbi, type))
> -		return;
> -	move_one_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0, type);
> +		return 0;
> +	return move_one_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0, type);
>   }
>   
>   void zero_journal_entries(struct f2fs_sb_info *sbi)
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 96de22a..46dc747 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -70,8 +70,8 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
>   	}
>   
>   	if (find_next_free_block(sbi, &blkaddr, left, type, false)) {
> -		ERR_MSG("Can't find free block");
> -		ASSERT(0);
> +		ERR_MSG("Can't find free block\n");
> +		return -ENOSPC;
>   	}
>   
>   	se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
> @@ -789,8 +789,8 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
>   
>   	new_blkaddr = SM_I(sbi)->main_blkaddr;
>   	if (find_next_free_block(sbi, &new_blkaddr, 0, type, false)) {
> -		ERR_MSG("Can't find free block for the update");
> -		ASSERT(0);
> +		ERR_MSG("Can't find free block for the update\n");
> +		return -ENOSPC;
>   	}
>   
>   	ret = dev_write_block(buf, new_blkaddr, f2fs_io_type_to_rw_hint(type));



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
