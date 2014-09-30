From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/4] f2fs: check the use of macros on block
	counts and addresses
Date: Tue, 30 Sep 2014 14:19:36 +0800
Message-ID: <006201cfdc76$9a361140$cea233c0$@samsung.com>
References: <1411707287-21760-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1411707287-21760-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, September 26, 2014 12:55 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/4] f2fs: check the use of macros on block counts and addresses
> 
> This patch cleans up the existing and new macros for readability.
> 
> Rule is like this.
> 
>          ,-----------------------------------------> MAX_BLKADDR -,
>          |  ,------------- TOTAL_BLKS ----------------------------,
>          |  |                                                     |
>          |  ,- seg0_blkaddr   ,----- sit/nat/ssa/main blkaddress  |
> block    |  | (SEG0_BLKADDR)  | | | |   (e.g., MAIN_BLKADDR)      |
> address  0..x................ a b c d .............................
>             |                                                     |
> global seg# 0...................... m .............................
>             |                       |                             |
>             |                       `------- MAIN_SEGS -----------'
>             `-------------- TOTAL_SEGS ---------------------------'
>                                     |                             |
>  seg#                               0..........xx..................
> 
> = Note =
>  o GET_SEGNO_FROM_SEG0 : blk address -> global segno
>  o GET_SEGNO           : blk address -> segno
>  o START_BLOCK         : segno -> starting block address
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

I see SM_I(sbi)->segment_count in check_seg_range/check_block_count still
not be instead with TOTAL_SEGS(sbi), how about insteading these together?

Regards,
Yu
