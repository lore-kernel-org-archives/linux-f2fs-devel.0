From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: add nowait aio support
Date: Thu, 8 Mar 2018 17:04:35 +0800
Message-ID: <9dce3494-50c1-4cf8-52b9-f8e8ead2f82b@huawei.com>
References: <1520493679-17778-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520493679-17778-1-git-send-email-hyc.lee@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hyunchul Lee <hyc.lee@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-team@lge.com, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/8 15:21, Hyunchul Lee wrote:
> From: Hyunchul Lee <cheol.lee@lge.com>
> 
> This patch adds nowait aio support[1].
> 
> Return EAGAIN if any of the following checks fail for direct I/O:
>   - i_rwsem is not lockable
>   - Blocks are not allocated at the write location
> 
> And xfstests generic/471 is passed.
> 
>  [1]: 6be96d "Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT"
> 
> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
