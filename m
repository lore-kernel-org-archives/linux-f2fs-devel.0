From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: fix count of seg_freed to make sec_freed correct
Date: Wed, 24 Oct 2018 17:31:33 +0800
Message-ID: <6eed9a3c-120e-f920-58cd-7ce2a2b9bc16@huawei.com>
References: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
 <1540368510-14270-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540368510-14270-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/24 16:08, Yunlong Song wrote:
> When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
> gc starts, do_garbage_collect will skip counting seg_freed++, and this
> will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
