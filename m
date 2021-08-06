Return-Path: <SRS0=dspS=M5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD3C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 01:00:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D20610FF;
	Fri,  6 Aug 2021 01:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80D20610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBoEK-00023P-QL; Fri, 06 Aug 2021 01:00:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mBoEI-000236-Nq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 01:00:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0noFlTmxay9Q8WUYlrG86e+33MTBVVlT7OFdChoAVBY=; b=NoCy7p/evZGKkMgPE8uAZH/579
 eYo/7dUNceZYlzAtLEiG65/4xc/HXwSsHMr5UdFLIQTFzzUIfZzEopKNtJd0Mlw8YcQp9xiTnv83j
 SdM8Iz8X4IoYaEmQvc0C9MdeCu0nYnwbUXkL0T4+IGhHRtqcVd1ho5BJBktOKi/F8mQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0noFlTmxay9Q8WUYlrG86e+33MTBVVlT7OFdChoAVBY=; b=UyQlKOu8j+bXUEByblnjfckLWc
 i4mQYrXIAcOsjWJD2FIHZqQbdpt+BWjLEM5I4T4ynjKR2td2SqdZsjQ3po+0yuWw4v3RjhXDm2isR
 2btNx6k72nFrU6s7ATi/eN1xGsR4kAOsaSQ1S72xEr/quFQdZsh3H/g2dr51H2J22rio=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBoEH-00DzII-JG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 01:00:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 772A861167;
 Fri,  6 Aug 2021 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628211639;
 bh=+fRtu8waweJ8ujmV3XeQHG/T/ytIG7hFSIJen/mMpdk=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=TE/d26+/bNjW+yvba4OffS9Oqp02w0HJAHnBlIAk69cbi8klSYjF2hpxSmTgeM7eG
 hdT9h3y99aZmnwbkN1pNgsIGRvPfzgS2ZzxZB/hdu0LQbMQFZnVTgDYxsWDUONcQKG
 N+enERYzR7r9uFG9/lq3XGVEnv1idwlUVR7IVm1gbRfknUsd9IKzq7Jv58r9+gHgX2
 Os4W6zqPaQqo23vnhTH+mgb5ZTP+lOQYt/2L68c83n68jclABiPuSF6T/IAXrrCwwq
 xZHzQD/0g8tNeTr01IkZPCP90IwEDX4po3xJIvMAWVy2xOAu1yqTXazwaU1r9Jb8wb
 UIlRWbA/D0QlA==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210729122522.149960-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <9b1f01f4-66ed-3976-3efb-bd5fee347681@kernel.org>
Date: Fri, 6 Aug 2021 09:00:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729122522.149960-1-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1mBoEH-00DzII-JG
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix missing inplace count in overwrite
 with direct io
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/29 20:25, Fengnan Chang wrote:
> For now, overwrite file with direct io use inplace policy, but not
> counted, fix it.

IMO, LFS/SSR/IPU stats in debugfs was for buffered write, maybe we
need to add separated one for DIO.

Jaegeuk, thoughts?

Thanks,

> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/data.c | 6 ++++++
>   fs/f2fs/f2fs.h | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d2cf48c5a2e4..60510acf91ec 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1477,6 +1477,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>   		if (flag == F2FS_GET_BLOCK_DIO)
>   			f2fs_wait_on_block_writeback_range(inode,
>   						map->m_pblk, map->m_len);
> +		if (!f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
> +				map->m_may_create)
> +			stat_add_inplace_blocks(sbi, map->m_len);
>   		goto out;
>   	}
>   
> @@ -1526,6 +1529,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>   			blkaddr = dn.data_blkaddr;
>   			set_inode_flag(inode, FI_APPEND_WRITE);
>   		}
> +		if (!create && !f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
> +				map->m_may_create)
> +			stat_inc_inplace_blocks(sbi);
>   	} else {
>   		if (create) {
>   			if (unlikely(f2fs_cp_error(sbi))) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 867f2c5d9559..3a9df28e6fd7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3804,6 +3804,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
>   		((sbi)->block_count[(curseg)->alloc_type]++)
>   #define stat_inc_inplace_blocks(sbi)					\
>   		(atomic_inc(&(sbi)->inplace_count))
> +#define stat_add_inplace_blocks(sbi, count)				\
> +		(atomic_add(count, &(sbi)->inplace_count))
>   #define stat_update_max_atomic_write(inode)				\
>   	do {								\
>   		int cur = F2FS_I_SB(inode)->atomic_files;	\
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
