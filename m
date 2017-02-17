From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/2] Reduce the overprovision size a lot in f2fs
Date: Fri, 17 Feb 2017 11:33:38 -0800
Message-ID: <20170217193338.GD2951@jaegeuk.local>
References: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487335987-32601-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, zhouxiyu@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

On 02/17, Yunlong Song wrote:
> Rethink the meaning of reserved segments and overprovision segments in f2fs
> 
> The key issue is that flash FTL has already made overprovision itself, e.g. 7%,
> according to the difference between gigabyte (GB) and gibibyte (GiB). And this
> part can nenver be seen by the upper file system. The device capacity which it
> tells the upper file system is the other part which does not include the
> overprovision part, which means the whole device capacity that file system knows
> can "all" be used for write safely. The overprovision flash FTL has already reserved
> includes the needed capacity for garbage collection and other operations. So,
> filesystem can just take it easy and do not need to set the reserved segments and
> overprovision segments again in mkfs.f2fs.
>
> I want to explain more in detail. First, let's forget the section alignment
> issue in the following talk, since it is really not possible in real production
> case. As a result, f2fs does not need to behave like flash (i.e., new write
> must come after erase for a block page in flash).

Simply say no, F2FS has nothing to do with FTL, and LFS acts like flash.

> Take a look at the current design of mkfs.f2fs:
> 
> 	c.reserved_segments = (2 * (100 / c.overprovision + 1) + 6) * c.segs_per_sec;
> 
> The original motivation may be like this:
> 
> For example, if ovp is 20%, we select 5 victim segments to reclaim one free
> segment in the worst case. During this migration, we need additional 4 free
> segments to write valid blocks in the victim segments. Other remaining added
> segments are just to keep as a buffer to prepare any abnormal situation.
> 
> But f2fs does not have to bahave like flash, so why do we need 4 more free segments
> here? For current codes of f2fs gc, we only need 1 free segment:
> 
> Initial status: 1 free segment is needed
> 
>   segment 0     segment 1     segment 2     segment 3     segment 4     segment 5
> |20% invalid| |20% invalid| |20% invalid| |20% invalid| |20% invalid|   | free |
> |80%   valid| |80%   valid| |80%   valid| |80%   valid| |80%   valid|   | free |
> 
> 
> step 1: segment 0 -> segment 5, free segment 0

Should be step 1: segment 0 -> segment 5, prefree segment 0
Anyway,

>   segment 0     segment 1     segment 2     segment 3     segment 4      segment 5
> |    free   | |20% invalid| |20% invalid| |20% invalid| |20% invalid|   |20%  free|
> |    free   | |80%   valid| |80%   valid| |80%   valid| |80%   valid|   |80% valid|
> 
> 
> step 2: segment 1 -> segment 5 and segment 0, free segment 1

Here, we cannot use segment 0 to fill 60% to handle power-cut. If power-cut
happens after this, we will lose prevous data in segment 0. That's why we're
using prefree segments.

Thanks,

> 
>   segment 0     segment 1     segment 2     segment 3     segment 4      segment 5
> |40%    free| |    free   | |20% invalid| |20% invalid| |20% invalid|   |20% valid|
> |60%   valid| |    free   | |80%   valid| |80%   valid| |80%   valid|   |80% valid|
> 
> 
> step 3: segment 2 -> segment 0 and segment 1, free segment 2
> 
>   segment 0     segment 1     segment 2     segment 3     segment 4      segment 5
> |40%   valid| |60%    free| |    free   | |20% invalid| |20% invalid|   |20% valid|
> |60%   valid| |40%   valid| |    free   | |80%   valid| |80%   valid|   |80% valid|
> 
> 
> step 4: segment 3 -> segment 1 and segment 2, free segment 3
> 
>   segment 0     segment 1     segment 2     segment 3     segment 4      segment 5
> |40%   valid| |60%   valid| |80%    free| |    free   | |20% invalid|   |20% valid|
> |60%   valid| |40%   valid| |20%   valid| |    free   | |80%   valid|   |80% valid|
> 
> 
> step 5: segment 4 -> segment 2, free segment 4
> 
>   segment 0     segment 1     segment 2     segment 3     segment 4      segment 5
> |40%   valid| |60%   valid| |80%   valid| |    free   | |    free   |   |20% valid|
> |60%   valid| |40%   valid| |20%   valid| |    free   | |    free   |   |80% valid|
> 
> done. Now there are 1 new free segment.
> 
> If we change the f2fs gc codes in future, we can even let the initial 1 free
> segment go away, just copy valid data among the 5 segments themselves using SSR.
> 
> So the previous formula:
> 
> 	c.reserved_segments = (2 * (100 / c.overprovision + 1) + 6) * c.segs_per_sec;
> 
> is not needed, we can set reserved_segments to any value if we want, no matter
> what value c.overprovision is, just take it away from the formula.
> 
> And take take a look at the overprov_segment_count in current design of
> mkfs.f2fs:
> 
> set_cp(overprov_segment_count, (get_sb(segment_count_main) - get_cp(rsvd_segment_count)) * c.overprovision / 100);
> 
> The original motivation may be like this:
> 
> For example, if ovp is 20%, the worst case is that each segment is 20% invalid,
> then all the segments can not be selected as victim target for FTL GC, then
> there is (segment_count_main - rsvd_segment_count) * 20%, which are all invalid
> blocks and can not be used for write, thus we should regard this as
> overprovision segments, which can never be used by user. However, as we
> have explained above, all the device capacity which FTL tells f2fs can be used
> for write, so it is not correct to use this formula. In fact, we do not need to set
> the overprovision segments at all for this consideration.
> 
> Yunlong Song (2):
>   mkfs.f2fs: add option to set the value of reserved segments
>     and overprovision segments
>   f2fs: fix the case when there is no free segment to allocate for
>     CURSEG_WARM_NODE
> 
>  fs/f2fs/segment.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> -- 
> 1.8.5.2
