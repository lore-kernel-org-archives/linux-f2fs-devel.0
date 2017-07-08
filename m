From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: support plain user/group quota
Date: Sun, 9 Jul 2017 00:15:47 +0800
Message-ID: <3cb2d6d3-7ece-9d95-e95e-44dd93f431c7@kernel.org>
References: <20170706135245.6093-1-chao@kernel.org>
 <20170707191233.GA29629@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707191233.GA29629@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/7/8 3:12, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I've updated your patch like this.
> 
> - modify description 
> - use filemap_write_and_wait() directly aligned to the below v2 patch.
> 
>   f2fs: avoid deadlock caused by lock order of page and

Looks good to me.

I've updated doc in the patch rebased on this version as well.

Thanks,
