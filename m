From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Date: Tue, 18 Sep 2018 21:21:49 +0800
Message-ID: <19e63fa7-1a48-c1de-eef5-cde242e8300d@kernel.org>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/18 20:39, Yunlong Song wrote:
> The encrypted file may be corrupted by GC in following case:
> 
> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> segment 2,
> 
> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
> 
> Before page 1 is written back and if segment 2 become a victim, then
> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> during the GC process of Time 2, f2fs should wait for page 1 written back
> before reading it, or move_data_block will read a garbage block from
> blkaddr B since page is not written back to blkaddr B yet.
> 
> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> ra_data_block to read encrypted block, but it forgets to add
> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
