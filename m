From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: change the codes of checking CP_CRC_RECOVERY_FLAG
 to macro
Date: Sat, 25 Feb 2017 16:10:45 +0800
Message-ID: <58B13C05.50900@huawei.com>
References: <1487930771-14491-1-git-send-email-yunlong.song@huawei.com>
 <096f8d0b-774c-2065-db96-dde455a4ec53@huawei.com>
 <58B014FC.6090308@huawei.com>
 <3e2f166f-e532-a04b-d8dd-6b21d7243bc4@huawei.com>
 <58B01FC0.8060901@huawei.com> <20170224181235.GC39009@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170224181235.GC39009@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, cm224.lee@samsung.com, chao@kernel.org, sylinux@163.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/25 2:12, Jaegeuk Kim wrote:

> 
> This is to handle only one case in which:
> 
> 1. uses old kernel without this flag,
> 2. calls fsync and gets sudden power-cut,
> 3. updates new kernel having this flag before mount.
> 
> Then, if we do not check this flag at mount time, we will lose the last fsync'ed
> node blocks.
> 

So I just send a v2 patch to only change to macro in fill_node_footer_blkaddr and
allocate_segment_by_default, these two functions are called frequently, so it is
better to use macro code. And I remain the original checking code in is_recoverable_dnode,
this function is called only once after mount, it's OK.

-- 
Thanks,
Yunlong Song
