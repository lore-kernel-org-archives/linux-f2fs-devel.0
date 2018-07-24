From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: issue discard align to section in LFS mode
Date: Tue, 24 Jul 2018 10:40:27 +0800
Message-ID: <bec2c80d-13ca-e6be-f73a-ee8c6e9f6462@huawei.com>
References: <1531836275-94933-1-git-send-email-yunlong.song@huawei.com>
 <1532005095-111878-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532005095-111878-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/19 20:58, Yunlong Song wrote:
> For the case when sbi->segs_per_sec > 1 with lfs mode, take
> section:segment = 5 for example, if the section prefree_map is
> ...previous section | current section (1 1 0 1 1) | next section...,
> then the start = x, end = x + 1, after start = start_segno +
> sbi->segs_per_sec, start = x + 5, then it will skip x + 3 and x + 4, but
> their bitmap is still set, which will cause duplicated
> f2fs_issue_discard of this same section in the next write_checkpoint:
> 
> round 1: section bitmap : 1 1 1 1 1, all valid, prefree_map: 0 0 0 0 0
> then rm data block NO.2, block NO.2 becomes invalid, prefree_map: 0 0 1 0 0
> write_checkpoint: section bitmap: 1 1 0 1 1, prefree_map: 0 0 0 0 0,
> prefree of NO.2 is cleared, and no discard issued
> 
> round 2: rm data block NO.0, NO.1, NO.3, NO.4
> all invalid, but prefree bit of NO.2 is set and cleared in round 1, then
> prefree_map: 1 1 0 1 1
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1, no
> valid blocks of this section, so discard issued, but this time prefree
> bit of NO.3 and NO.4 is skipped due to start = start_segno + sbi->segs_per_sec;
> 
> round 3:
> write_checkpoint: section bitmap: 0 0 0 0 0, prefree_map: 0 0 0 1 1 ->
> 0 0 0 0 0, no valid blocks of this section, so discard issued,
> this time prefree bit of NO.3 and NO.4 is cleared, but the discard of
> this section is sent again...
> 
> To fix this problem, we can align the start and end value to section
> boundary for fstrim and real-time discard operation, and decide to issue
> discard only when the whole section is invalid, which can issue discard
> aligned to section size as much as possible and avoid redundant discard.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
