From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/5] f2fs: blk_finish_plug of submit_bio in lfs mode
Date: Fri, 13 Jul 2018 11:14:37 +0800
Message-ID: <153b5372-3798-49c8-a8ff-ed642f31e5e5@huawei.com>
References: <1531408170-45758-1-git-send-email-yunlong.song@huawei.com>
 <1531408170-45758-4-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531408170-45758-4-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/12 23:09, Yunlong Song wrote:
> Expand the blk_finish_plug action from blkzoned to normal lfs mode,
> since plug will cause the out-of-order IO submission, which is not
> friendly to flash in lfs mode.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
