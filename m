From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: only flush the single temp bio cache which owns
 the target page
Date: Wed, 14 Nov 2018 18:49:55 +0800
Message-ID: <264f0463-bda9-cf5b-9236-13edc7f06936@huawei.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
 <1542081452-66059-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542081452-66059-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/11/13 11:57, Yunlong Song wrote:
> Previously, when f2fs finds which temp bio cache owns the target page,
> it will flush all the three temp bio caches, but we only need to flush
> one single bio cache indeed, which can help to keep bio merged.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
