From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix small discards when se->valid_blocks is zero
Date: Wed, 4 Jan 2017 14:36:18 -0800
Message-ID: <20170104223618.GA1011@jaegeuk.local>
References: <1483434117-24427-1-git-send-email-yunlong.song@huawei.com>
 <20170104015510.GB16504@jaegeuk.local>
 <586C731F.9020509@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <586C731F.9020509@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Yunlong Song wrote:
> Hi Kim,
>     Although the blocks of that file will finally be discarded when it is not current segment any more and almost fully invalidate,
> but the point is that the blocks of that file can only be discarded along with the whole segment now, which violates the meaning
> of small discard. Look at the case I said in last mail, if the segment which owns the deleted file has no more changing after the file
> deleting, and its validate blocks are perhaps over 95%, and it may not be easy to be selected as a gc victim. In this case, FTL can
> not know the "file delete" on time, and the invalidate blocks of that file can not be discarded in FTL layer on time.

Correction: current active segment is also treated as a candidate for small
discards in add_discard_addrs().

So, it seems you want to discard small invalid chunks in the current active
segments, right? If so, how do you think this change?

---
 fs/f2fs/segment.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 82078734f379..394a6fef7f82 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -853,11 +853,10 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
 		return false;
 
-	if (!force) {
-		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
-		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
-			return false;
-	}
+	if (!force && (!test_opt(sbi, DISCARD) ||
+		(!se->valid_blocks && !IS_CURSEG(sbi, cpc->trim_start)) ||
+		SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards))
+		return false;
 
 	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
 	for (i = 0; i < entries; i++)
-- 
2.11.0


> 
> On 2017/1/4 9:55, Jaegeuk Kim wrote:
> > Hi Yunlong,
> >
> > On 01/03, Yunlong Song wrote:
> >> In the small discard case, when se->valid_blocks is zero, the add_discard_addrs
> >> will directly return without __add_discard_entry. This will cause the file
> >> delete have no small discard. The case is like this:
> >>
> >> 1. Allocate free 2M segment
> >> 2. Write a file (size n blocks < 512) in that 2M segment, se->valid_blocks = n
> >> 3. Delete that file, se->valid_blocks = 0, add_discard_addrs will return without
> >> sending any discard of that file, and forever due to cur_map[i] ^ ckpt_map[i] =
> >> 0 after that checkpoint
> > During this checkpoint, that'll be discarded as a prefree segment, no?
> > Note that, if this is a current segment, f2fs won't discard it until it is
> > fully allocated.
> >
> > Thanks,
> >
> >> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> >> ---
> >>  fs/f2fs/segment.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index 0738f48..8610f14 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -838,7 +838,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  		return;
> >>  
> >>  	if (!force) {
> >> -		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
> >> +		if (!test_opt(sbi, DISCARD) ||
> >>  		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
> >>  			return;
> >>  	}
> >> -- 
> >> 1.8.5.2
> > .
> >
> 
> 
> -- 
> Thanks,
> Yunlong Song
> 
