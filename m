From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: fix the case when there is no free segment to
 allocate for CURSEG_WARM_NODE
Date: Thu, 23 Feb 2017 11:27:19 -0800
Message-ID: <20170223192719.GD2026@jaegeuk.local>
References: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
 <1487335987-32601-3-git-send-email-yunlong.song@huawei.com>
 <20170217183933.GB2951@jaegeuk.local>
 <c1df762d-43f1-b06a-82f5-7022110efe1b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1df762d-43f1-b06a-82f5-7022110efe1b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Yunlong Song <yunlong.song@huawei.com>, cm224.lee@samsung.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, zhouxiyu@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 02/23, Chao Yu wrote:
> On 2017/2/18 2:39, Jaegeuk Kim wrote:
> > Hi Yunlong,
> > 
> > I already started to test this since a couple of days ago. :)
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=908b5f463c82eaf972b149a26bb310f5e25064fd
> 
> Hi, Jaegeuk,
> 
> Could you send this patch into mailing list? Anyway I will comment in this patch
> first. :)
> 
> > 
> > Thanks,
> > 
> > On 02/17, Yunlong Song wrote:
> >> If the free segments are used up, then new_curseg will fail for
> >> CURSEG_WARM_NODE, in this case, we should use change_curseg instead of
> >> new_curseg.
> >>
> >> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> >> ---
> >>  fs/f2fs/segment.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index df2ff5c..32820cd 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -1564,8 +1564,6 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
> >>  
> >>  	if (force)
> >>  		new_curseg(sbi, type, true);
> >> -	else if (type == CURSEG_WARM_NODE)
> 
> Would it be better to check CP_CRC_RECOVERY_FLAG for compatibility of old image?
> 
> else if (!is_set_ckpt_flags(CP_CRC_RECOVERY_FLAG) && type == CURSEG_WARM_NODE)
> 	new_curseg(sbi, type, false);

Agreed, when considering any potential risk. ;)

>From 5b6c6be2d878bd7ec4dc2cb4e2a2da2779fe52ab Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 14 Feb 2017 19:32:51 -0800
Subject: [PATCH] f2fs: use SSR for warm node as well

We have had node chains, but haven't used it so far due to stale node blocks.
Now, we have crc|cp_ver in node footer and give random cp_ver at format time,
we can start to use it again.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b2e0769a09d0..0b42b0cdd674 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1563,7 +1563,8 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 
 	if (force)
 		new_curseg(sbi, type, true);
-	else if (type == CURSEG_WARM_NODE)
+	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
+					type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
-- 
2.11.0
