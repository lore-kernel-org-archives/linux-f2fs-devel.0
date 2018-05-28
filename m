From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs-tools: fix to match with the start_sector
Date: Mon, 28 May 2018 15:11:51 +0800
Message-ID: <bf595a86-700e-9225-6a5e-a245dbc027ad@huawei.com>
References: <1525425645-127945-1-git-send-email-yunlong.song@huawei.com>
 <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525659336-145433-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/7 10:15, Yunlong Song wrote:
> f2fs-tools uses ioctl BLKSSZGET to get sector_size, however, this ioctl
> will return a value which may be larger than 512 (according to the value
> of q->limits.logical_block_size), then this will be inconsistent with
> the start_sector, since start_sector is got from ioctl HDIO_GETGEO and
> is always in 512 size unit for a sector. To fix this problem, just
> change the sector_size to the default value when computing with
> start_sector. And fix sectors_per_blk as well.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
