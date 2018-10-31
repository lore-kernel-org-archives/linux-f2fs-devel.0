From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: change segment to section in f2fs_ioc_gc_range
Date: Wed, 31 Oct 2018 11:32:47 +0800
Message-ID: <d7822529-c830-dfbe-80c3-470f5ef57d4d@huawei.com>
References: <1540391736-20714-1-git-send-email-yunlong.song@huawei.com>
 <1540903075-62916-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540903075-62916-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/30 20:37, Yunlong Song wrote:
> f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
> blocks of section each time, so fix it from segment to section.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
