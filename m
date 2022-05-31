Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4243BC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 May 2022 08:01:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nvwoX-0004q0-VE; Tue, 31 May 2022 08:01:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nvwoW-0004pp-Ay
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 May 2022 08:01:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5gI6W4viTWql8Uwhb50aMFlObiKdy2vCUTCbMVtQ14=; b=XqEg47SWsFAGdfaT9j9xP7pDdy
 mjHz/5RkOzqVD2QFLFZ2l5M05afRxsndeD5ydNqzQQ/4vNIrreNfrBqb7vsRMdhCXatI+ykBTFG94
 eTBeuZc21p7eylwgpRSYE+F3tndZwl8X29X+1D66K7WcTO22Hd4QlAzZg9w49nSUIZEY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v5gI6W4viTWql8Uwhb50aMFlObiKdy2vCUTCbMVtQ14=; b=AU+ctdrB2fPIUhwZLMnoEGUxjz
 0QCbgwsKHqW1v08qLNogJW/upO6ecC2NnIh1Ijn9aMypu5ergKH997wveErur7ArwTJUWaBMFp8Uf
 kRD8w/RcReDjBMFb50CaGmXdLVFBngjwReddBGeG0j1NbhaBgOjGsVvo109jKtF1gDpg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nvwoR-009EfA-Lv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 May 2022 08:01:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA0261214;
 Tue, 31 May 2022 08:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DB1C34119;
 Tue, 31 May 2022 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653984065;
 bh=jDuI1OezqWtRhCv5nxYOoLBrXfUkFW5cSU8f621yeiU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hnncicVxHW86XI1aJOefhoU8I5MQu4f342W0L31+J4wjyHdqUCm7PYgbR4SI6I0rK
 J6ZlOAdYhe1wIVE/1+qT9gMtP0Z3yb9IBug/M+NY/Gc0q18XW+d2P1zf5XzrHeg6cs
 mNE+hrAXSeAeVwo2Hd0xCNf+hF9mhCDLSr7YQGUAC+iyYIKF6KMdcHTAvTPdUoDfK+
 U2MRDCoQmoJHbmr7QPzDS7hBWRH1XOJudAL/nr3qM/9FIvTqvTV1Z948JqSHtiyI4l
 L1JC+LKawmNUq1WmeLQpy3uxugeDZItIS8CIUooyGhvO5qqLxPSBwNQNxBkykHV3dZ
 skS+W0hmvpODg==
Message-ID: <fa3cbe36-1738-a811-ce03-dd5aaf8ea3d4@kernel.org>
Date: Tue, 31 May 2022 16:01:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220517032410.3564033-1-chao@kernel.org>
 <YoPZh+vl68IH5loV@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YoPZh+vl68IH5loV@google.com>
X-Headers-End: 1nvwoR-009EfA-Lv
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: separate NOCoW and pinfile semantics
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/18 1:21, Jaegeuk Kim wrote:
> On 05/17, Chao Yu wrote:
>> Pinning a file is heavy, because skipping pinned files make GC
>> running with heavy load or no effect.
>>
>> So that this patch proposes to separate nocow and pinfile semantics:
>> - NOCoW flag can only be set on regular file.
>> - NOCoW file will only trigger IPU at common writeback/flush.
>> - NOCow file will do OPU during GC.
> 
> How about adding
>   - NOCow file will allocate 2MB-aligned space via fallocate.
> 
> So, it'd be same as file pinning except allowing GCs. wdyt?

Well, it seems the segment-aligned allocation feature should not couple with
pin_file or NoCow flag, what about introducing another ioctl for that? something
like: F2FS_IOC_ALIGNMENT_PREALLOCATION w/ arg.alignment_start, arg.alignment_len,
arg.total_len?

Thanks,

> 
>>
>> This flag can satisfying the demand of:
>> 1) avoiding fragment of file's physical block
>> 2) userspace doesn't want to pin file's physical address
>>
>> After commit 5d539245cb18 ("f2fs: export FS_NOCOW_FL flag to user"),
>> Pin_file and NOCoW flags have already been twined closely. e.g.
>> once we set pinfile flag in file, nocow flag will be shown; and after
>> clearing pinfile flag, nocow flag will disappear.
>>
>> So, in order to keep backward compatibility, let use below semantics:
>>
>> f2fs_ioc_set_pin_file/f2fs_fileattr_set logic:
>> 		pinfile			nocow
>> set		set pinfile | nocow	set nocow
>> clear		clear pinfile | nocow	clear nocow
>>
>> File Behaviors:
>> w/ pinfile, w/ nocow:		use pinfile semantics
>> w/ pinfile, w/o nocow:		use pinfile semantics
>> w/o pinfile, w/ nocow:		use nocow semantics
>> w/o pinfile, w/o nocow:		no pinfile or nocow semantics
>>
>> NOCoW can also be set on directory, and it will have no effect on
>> directory, however, new files created in nocow directory will have the
>> flag set.
>>
>> Signed-off-by: Chao Yu <chao.yu@oppo.com>
>> ---
>> v4:
>> - allow IPU only for NoCowed regular inode.
>>   fs/f2fs/data.c |  3 +++
>>   fs/f2fs/f2fs.h | 13 +++++++++++--
>>   fs/f2fs/file.c | 18 +++++++++++++++++-
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 54a7a8ad994d..42d95ac6b508 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2498,6 +2498,9 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
>>   	if (f2fs_is_pinned_file(inode))
>>   		return true;
>>   
>> +	if (S_ISREG(inode->i_mode) && F2FS_I(inode)->i_flags & F2FS_NOCOW_FL)
>> +		return true;
>> +
>>   	/* if this is cold file, we should overwrite to avoid fragmentation */
>>   	if (file_is_cold(inode))
>>   		return true;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 492af5b96de1..5c67736000a7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2916,13 +2916,15 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>   #define F2FS_NOCOMP_FL			0x00000400 /* Don't compress */
>>   #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
>>   #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
>> +#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
>>   #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
>>   #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
>>   
>>   /* Flags that should be inherited by new inodes from their parent. */
>>   #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
>>   			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
>> -			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL)
>> +			   F2FS_CASEFOLD_FL | F2FS_COMPR_FL | F2FS_NOCOMP_FL | \
>> +			   F2FS_NOCOW_FL)
>>   
>>   /* Flags that are appropriate for regular files (all but dir-specific ones). */
>>   #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
>> @@ -2954,9 +2956,16 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>>   		fallthrough;
>>   	case FI_DATA_EXIST:
>>   	case FI_INLINE_DOTS:
>> -	case FI_PIN_FILE:
>>   	case FI_COMPRESS_RELEASED:
>>   		f2fs_mark_inode_dirty_sync(inode, true);
>> +		break;
>> +	case FI_PIN_FILE:
>> +		if (set)
>> +			F2FS_I(inode)->i_flags |= F2FS_NOCOW_FL;
>> +		else
>> +			F2FS_I(inode)->i_flags &= ~F2FS_NOCOW_FL;
>> +		f2fs_mark_inode_dirty_sync(inode, true);
>> +		break;
>>   	}
>>   }
>>   
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 216081ea8c81..9e71ce8601f9 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1851,6 +1851,20 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   	if (IS_NOQUOTA(inode))
>>   		return -EPERM;
>>   
>> +	if ((iflags ^ masked_flags) & F2FS_NOCOW_FL) {
>> +		int ret;
>> +
>> +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
>> +			return -EINVAL;
>> +		if (S_ISREG(inode->i_mode)) {
>> +			if (f2fs_should_update_outplace(inode, NULL))
>> +				return -EINVAL;
>> +			ret = f2fs_convert_inline_inode(inode);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	}
>> +
>>   	if ((iflags ^ masked_flags) & F2FS_CASEFOLD_FL) {
>>   		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>>   			return -EOPNOTSUPP;
>> @@ -1926,6 +1940,7 @@ static const struct {
>>   	{ F2FS_NOCOMP_FL,	FS_NOCOMP_FL },
>>   	{ F2FS_INDEX_FL,	FS_INDEX_FL },
>>   	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
>> +	{ F2FS_NOCOW_FL,	FS_NOCOW_FL },
>>   	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
>>   	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
>>   };
>> @@ -1957,7 +1972,8 @@ static const struct {
>>   		FS_NOCOMP_FL |		\
>>   		FS_DIRSYNC_FL |		\
>>   		FS_PROJINHERIT_FL |	\
>> -		FS_CASEFOLD_FL)
>> +		FS_CASEFOLD_FL |	\
>> +		FS_NOCOW_FL)
>>   
>>   /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
>>   static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
>> -- 
>> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
