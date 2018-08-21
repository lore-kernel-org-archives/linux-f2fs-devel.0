From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: fix performance issue observed with
 multi-thread sequential read
Date: Tue, 21 Aug 2018 11:30:22 +0800
Message-ID: <782a0bae-a398-9afe-745e-cca31e8fc8e8@huawei.com>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
 <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
 <20180810185640.GA63079@jaegeuk-macbookpro.roam.corp.google.com>
 <20180817182944.GA58612@jaegeuk-macbookpro.roam.corp.google.com>
 <20180821023626.GB20263@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821023626.GB20263@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/8/21 10:36, Jaegeuk Kim wrote:
> This reverts the commit - "b93f771 - f2fs: remove writepages lock"
> to fix the drop in sequential read throughput.
> 
> Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
> device: UFS
> 
> Before -
> read throughput: 185 MB/s
> total read requests: 85177 (of these ~80000 are 4KB size requests).
> total write requests: 2546 (of these ~2208 requests are written in 512KB).
> 
> After -
> read throughput: 758 MB/s
> total read requests: 2417 (of these ~2042 are 512KB reads).
> total write requests: 2701 (of these ~2034 requests are written in 512KB).
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> Change log from v4:
>  - add __should_serialize_io
>  - fix wrong condition
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
>  fs/f2fs/data.c                          | 21 +++++++++++++++++++++
>  fs/f2fs/f2fs.h                          |  2 ++
>  fs/f2fs/segment.c                       |  1 +
>  fs/f2fs/super.c                         |  1 +
>  fs/f2fs/sysfs.c                         |  2 ++
>  6 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 9b0123388f18..94a24aedcdb2 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -51,6 +51,14 @@ Description:
>  		 Controls the dirty page count condition for the in-place-update
>  		 policies.
>  
> +What:		/sys/fs/f2fs/<disk>/min_seq_blocks
> +Date:		August 2018
> +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		 Controls the dirty page count condition for batched sequential
> +		 writes in ->writepages.
> +
> +
>  What:		/sys/fs/f2fs/<disk>/min_hot_blocks
>  Date:		March 2017
>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 43d3723dc886..bdcb023506a7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2122,6 +2122,18 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	return ret;
>  }
>  
> +static inline bool __should_serialize_io(struct inode *inode,
> +					struct writeback_control *wbc)
> +{
> +	if (!S_ISREG(inode->i_mode))

Good catch! Will be better. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
