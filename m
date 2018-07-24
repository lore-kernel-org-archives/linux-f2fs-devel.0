From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 5/5] f2fs: add proc entry to show victim_secmap bitmap
Date: Tue, 24 Jul 2018 23:06:03 +0800
Message-ID: <256e8787-28ae-7466-b813-068eb3b8a83d@kernel.org>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
 <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532355022-163029-6-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/23 22:10, Yunlong Song wrote:
> This patch adds a new proc entry to show victim_secmap information in
> more detail, which is very helpful to know the get_victim candidate
> status clearly, and helpful to debug problems (e.g., some sections can
> not gc all of its blocks, since some blocks belong to atomic file,
> leaving victim_secmap with section bit setting, in extrem case, this
> will lead all bytes of victim_secmap setting with 0xff).
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
