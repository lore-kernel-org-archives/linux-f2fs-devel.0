From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v3 3/5] f2fs-tools: unify the writeback
 of superblock
Date: Tue, 11 Sep 2018 15:14:09 -0700
Message-ID: <20180911221409.GD55456@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180830033733.236460-1-zhengjunling@huawei.com>
 <20180830033733.236460-3-zhengjunling@huawei.com>
 <20180907222342.GB93212@jaegeuk-macbookpro.roam.corp.google.com>
 <e4efcfcf-0df8-f2d3-711f-bf64cfba0ce2@huawei.com>
 <0eeec4ed-e059-fca6-92a4-dfc6325a08f9@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fzqvM-00016K-5O
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 22:14:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzqvJ-00EfrY-HR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 22:14:19 +0000
Content-Disposition: inline
In-Reply-To: <0eeec4ed-e059-fca6-92a4-dfc6325a08f9@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 09/11, Junling Zheng wrote:
> Hi, Jaegeuk
> 
> On 2018/9/11 10:43, Junling Zheng wrote:
> > On 2018/9/8 6:23, Jaegeuk Kim wrote:
> >> On 08/30, Junling Zheng wrote:
> >>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> >>> index 38a0da4..df46950 100644
> >>> --- a/include/f2fs_fs.h
> >>> +++ b/include/f2fs_fs.h
> >>> @@ -1411,4 +1411,39 @@ static inline int parse_root_owner(char *ids,
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +enum SB_ADDR {
> >>> +	SB_ADDR_0,
> >>> +	SB_ADDR_1,
> >>> +	SB_ADDR_MAX,
> >>> +};
> >>> +
> >>> +#define SB_FIRST	(1 << SB_ADDR_0)
> >>> +#define SB_SECOND	(1 << SB_ADDR_1)
> >>> +#define SB_ALL		(SB_FIRST | SB_SECOND)
> >>> +
> >>> +static inline int __write_superblock(struct f2fs_super_block *sb, int sb_mask)
> >>> +{
> >>> +	int index, ret;
> >>> +	u_int8_t *buf;
> >>> +
> >>> +	buf = calloc(F2FS_BLKSIZE, 1);
> >>> +	ASSERT(buf);
> >>> +
> >>> +	memcpy(buf + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
> >>> +	for (index = 0; index < SB_ADDR_MAX; index++) {
> >>> +		if ((1 << index) & sb_mask) {
> >>> +			ret = dev_write_block(buf, index);
> >>
> >> This doesn't look like a proper inline function.
> >>
> > 
> > Ok, I'll remove the "inline" flag :)
> > Any other flaws?
> > 
> > Thanks
> > 
> 
> Sorry, here may be difficult to handle :(
> 
> This function is used in both mkfs and fsck, so I think it's proper to place it in
> include/f2fs_fs.h.
> 
> Then, if the "inline" flag is removed it will generate some compile warnings as below:
> 
> In file included from libf2fs.c:11:0:
> ../include/f2fs_fs.h:1428:12: warning: '__write_superblock' defined but not used [-Wunused-function]
>  static int __write_superblock(struct f2fs_super_block *sb, int sb_mask)
>             ^
> 
> Besides, there're some other complex functions like get_best_overprovision(), parse_feature()
> being defined as inline functions.
> 
> So, I think it's better to keep it inline. what do you think?

I meant we'd better keep them separately, since mkfs is quite independent from
fsck friends.

Thanks,

> 
> Thanks
> 
> >>> +			if (ret) {
> >>> +				MSG(0, "\tError: While writing superblock %d "
> >>> +							"to disk!!!\n", index);
> >>> +				free(buf);
> >>> +				return ret;
> >>> +			}
> >>> +		}
> >>> +	}
> >>> +
> >>> +	free(buf);
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  #endif	/*__F2FS_FS_H */
> >>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> >>> index 621126c..7e3846e 100644
> >>> --- a/mkfs/f2fs_format.c
> >>> +++ b/mkfs/f2fs_format.c
> >>> @@ -979,24 +979,7 @@ free_cp:
> >>>  
> >>>  static int f2fs_write_super_block(void)
> >>>  {
> >>> -	int index;
> >>> -	u_int8_t *zero_buff;
> >>> -
> >>> -	zero_buff = calloc(F2FS_BLKSIZE, 1);
> >>> -
> >>> -	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
> >>> -	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
> >>> -	for (index = 0; index < 2; index++) {
> >>> -		if (dev_write_block(zero_buff, index)) {
> >>> -			MSG(1, "\tError: While while writing supe_blk "
> >>> -					"on disk!!! index : %d\n", index);
> >>> -			free(zero_buff);
> >>> -			return -1;
> >>> -		}
> >>> -	}
> >>> -
> >>> -	free(zero_buff);
> >>> -	return 0;
> >>> +	return __write_superblock(sb, SB_ALL);
> >>>  }
> >>>  
> >>>  #ifndef WITH_ANDROID
> >>> -- 
> >>> 2.18.0
> >>
> >> .
> >>
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 
> 
