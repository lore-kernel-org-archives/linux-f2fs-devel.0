From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 04/10] f2fs: support IO alignment for DATA and
 NODE writes
Date: Wed, 4 Jan 2017 16:23:26 +0800
Message-ID: <7920f143-750a-69df-f4b3-eeac82c1014b@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161230185117.3832-4-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/12/31 2:51, Jaegeuk Kim wrote:
> This patch implements IO alignment by filling dummy blocks in DATA and NODE
> write bios. If we can guarantee, for example, 32KB or 64KB for such the IOs,
> we can eliminate underlying dummy page problem which FTL conducts in order to
> close MLC or TLC partial written pages.
> 
> Note that,
>  - it requires "-o mode=lfs".
>  - IO size should be power of 2, not exceed BIO_MAX_PAGES, 256.
>  - read IO is still 4KB.
>  - do checkpoint at fsync, if dummy NODE page was written.

Which scenario we can benefit from? Any numbers?

I doubt that there are some potential side-effect points:
 - write amplification will be more serious than before
 - free space will be more fragmented since dummy blocks is separated in whole
address space
 - there is less chance to merge small(unaligned) IOs in block layer

Thoughts?

Thanks,
