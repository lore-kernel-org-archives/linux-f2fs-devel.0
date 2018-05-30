From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH rebase] f2fs-tools: fix overflow bug of start_sector when
 computing zone_align_start_offset
Date: Wed, 30 May 2018 22:30:53 +0800
Message-ID: <2c8079d6-af80-52c0-5359-6c09c6cab416@kernel.org>
References: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
 <1527663509-143986-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527663509-143986-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/30 14:58, Yunlong Song wrote:
> zone_align_start_offset should be u64, but config.start_sector is u32,
> so it may be overflow when computing zone_align_start_offset.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
