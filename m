From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v4] Revert "f2fs crypto: avoid unneeded memory allocation
 in ->readdir"
Date: Wed, 28 Feb 2018 20:32:20 +0800
Message-ID: <0a7fec6b-0f94-00f7-f5d4-8eac1f9cee73@huawei.com>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
 <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
 <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/28 13:48, Jaegeuk Kim wrote:
> Hi Yunlong,
> 
> As Eric pointed out, how do you think using nohighmem for directory likewise
> ext4, which looks like more efficient?

OK, I have sent out another patch like this.

  Actually, we don't need to do this in
> most of recent kernels, right?
> 

Why? I have got this panic using arm with recent kernel.
