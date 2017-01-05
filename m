From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: fix small discards when se->valid_blocks is zero
Date: Thu, 5 Jan 2017 10:38:41 +0800
Message-ID: <586DB1B1.7010501@huawei.com>
References: <1483434117-24427-1-git-send-email-yunlong.song@huawei.com>
 <20170104015510.GB16504@jaegeuk.local> <586C731F.9020509@huawei.com>
 <20170104223618.GA1011@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104223618.GA1011@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Kim,
    I am afraid your fix still has some problems when the section/segment != 1, when the segment has zero valid blocks but the section does not,
the blocks of that deleted file can still not notify the FTL by the small discards in your fix. And even in the case section/segment == 1, the blocks
of that deleted file can only be discarded in a range of single 2M rather than its real blocks range, which disturbs the semantic of "small discards".
    By the way, there is still a problem of "double discard". When the small discard option is on, the blocks of the deleted file will send small discard
via add_discard_addrs, and also will send the section-level discard when the whole section is free later. I will think about to avoid the section-level
discard, then the small discard of that deleted file is needed although "!se->valid_blocks && !IS_CURSEG(sbi, cpc->trim_start)"  is true, since the other
blocks of that segment has already sent small discard when they got invalid before, and we just need to send the discard of that deleted file which
is the last one taking up in the segment.

On 2017/1/5 6:36, Jaegeuk Kim wrote:
> On 01/04, Yunlong Song wrote:
>> Hi Kim,
>>     Although the blocks of that file will finally be discarded when it is not current segment any more and almost fully invalidate,
>> but the point is that the blocks of that file can only be discarded along with the whole segment now, which violates the meaning
>> of small discard. Look at the case I said in last mail, if the segment which owns the deleted file has no more changing after the file
>> deleting, and its validate blocks are perhaps over 95%, and it may not be easy to be selected as a gc victim. In this case, FTL can
>> not know the "file delete" on time, and the invalidate blocks of that file can not be discarded in FTL layer on time.
> Correction: current active segment is also treated as a candidate for small
> discards in add_discard_addrs().
>
> So, it seems you want to discard small invalid chunks in the current active
> segments, right? If so, how do you think this change?
>
> ---
>  fs/f2fs/segment.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 82078734f379..394a6fef7f82 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -853,11 +853,10 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>  	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
>  		return false;
>  
> -	if (!force) {
> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> -		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
> -			return false;
> -	}
> +	if (!force && (!test_opt(sbi, DISCARD) ||
> +		(!se->valid_blocks && !IS_CURSEG(sbi, cpc->trim_start)) ||
> +		SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards))
> +		return false;
>  
>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>  	for (i = 0; i < entries; i++)


-- 
Thanks,
Yunlong Song
